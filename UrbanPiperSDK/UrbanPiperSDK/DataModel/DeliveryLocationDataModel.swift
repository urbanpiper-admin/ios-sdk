//
//  DeliveryLocationDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 13/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

@objc public protocol DeliveryLocationDataModelDelegate {

    func update(_ deliveryLocation: CLLocation?, _ deliveryAddress: OrderDeliveryAddress?, _ upError: UPError?)

    func handleLocationManagerFailure(error: Error?)
    func didChangeAuthorization(status: CLAuthorizationStatus)

}

public class DeliveryLocationDataModel: UrbanPiperDataModel {

    private struct LocationUserDefaultKeys {
        static let deliveryLocationLatitude = "DeliveryLocationLatitude"
        static let deliveryLocationLongitude = "DeliveryLocationLongitude"
        static let deliveryAddress = "DeliveryAddress"
    }
    
    @objc public static private(set) var shared = DeliveryLocationDataModel()

    static let maxDistanceBetweenLocations = CLLocationDistance(200)

    @objc static let locationUpdateTimeInterval: Int = {
        #if DEBUG
            return 1
        #else
            return 10
        #endif
    }()
    
    @objc var nextLocationUpdateDate: Date?

    @objc var userSelectedDeliveryLocation: Bool = false

    @objc public var deliveryLocation: CLLocation? = {
        guard let lat = UserDefaults.standard.object(forKey: LocationUserDefaultKeys.deliveryLocationLatitude) as? CLLocationDegrees else { return nil }
        guard let lon = UserDefaults.standard.object(forKey: LocationUserDefaultKeys.deliveryLocationLongitude) as? CLLocationDegrees else { return nil }

        return CLLocation(latitude: lat, longitude: lon)
        }()
        {
        didSet {
            guard let loc = deliveryLocation else {
                UserDefaults.standard.removeObject(forKey: LocationUserDefaultKeys.deliveryLocationLatitude)
                UserDefaults.standard.removeObject(forKey: LocationUserDefaultKeys.deliveryLocationLongitude)
                return
            }
            UserDefaults.standard.set(loc.coordinate.latitude, forKey: LocationUserDefaultKeys.deliveryLocationLatitude)
            UserDefaults.standard.set(loc.coordinate.longitude, forKey: LocationUserDefaultKeys.deliveryLocationLongitude)

            LocationManagerDataModel.shared.locationDetermined()
            deliveryAddress = nil
        }
    }

    @objc public var deliveryAddress: OrderDeliveryAddress? = {
        guard let addressData = UserDefaults.standard.object(forKey: LocationUserDefaultKeys.deliveryAddress) as? Data else { return nil }
        OrderDeliveryAddress.registerClassName()
        guard let orderDeliveryAddress = NSKeyedUnarchiver.unarchiveObject(with: addressData) as? OrderDeliveryAddress else { return nil }
        return orderDeliveryAddress
        }()
        {
        didSet {
            guard let address = deliveryAddress else {
                UserDefaults.standard.removeObject(forKey: LocationUserDefaultKeys.deliveryAddress)
                return
            }
            
            if let store = OrderingStoreDataModel.shared.nearestStoreResponse?.store {
                if store.closingDay || store.isStoreClosed {
                    if let coordinate = deliveryLocation?.coordinate {
                        AnalyticsManager.shared.nearestStoreClosed(lat: coordinate.latitude,
                                                                   lng: coordinate.longitude,
                                                                   deliveryAddress: address.fullAddress ?? "",
                                                                   storeName: store.name)
                    }
                    
                } else if store.temporarilyClosed {
                    if let coordinate = deliveryLocation?.coordinate {
                        AnalyticsManager.shared.nearestStoreTemporarilyClosed(lat: coordinate.latitude,
                                                                              lng: coordinate.longitude,
                                                                              deliveryAddress: address.fullAddress ?? "",
                                                                              storeName: store.name)
                    }
                }
            }

            OrderDeliveryAddress.registerClassName()
            let addressData: Data = NSKeyedArchiver.archivedData(withRootObject: address)

            UserDefaults.standard.set(addressData, forKey: LocationUserDefaultKeys.deliveryAddress)
        }
    }

    weak public var dataModelDelegate: DeliveryLocationDataModelDelegate?
    
    private override init() {
        super.init()
        
        LocationManagerDataModel.shared.addObserver(delegate: self)
        guard let location = deliveryLocation, deliveryAddress == nil else { return }
        resolveAddress(from: location)
    }

    deinit {
        LocationManagerDataModel.shared.removeObserver(delegate: self)
    }

    public func updateCurrentUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            nextLocationUpdateDate = nil
        }
        
        LocationManagerDataModel.shared.updateUserLocation()
    }

    public func setCustomDelivery(location: CLLocation, address: OrderDeliveryAddress?) {
        if let addressObject = address {
            deliveryAddress = address
            dataModelDelegate?.update(location, deliveryAddress, nil)
        } else {
            resolveAddress(from: location)
        }
    }
    
}

//  MARK: API Calls

extension DeliveryLocationDataModel {

    public func resolveAddress(from location: CLLocation) {
        nextLocationUpdateDate = Calendar.current.date(byAdding: .minute,
                                                                                 value: Int(DeliveryLocationDataModel.locationUpdateTimeInterval),
                                                                                 to: Date())
        
        deliveryLocation = location
        
        dataModelDelegate?.update(location, nil, nil)

        let modelDelegate = dataModelDelegate
        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate, completionHandler: { [weak self] (response, error) -> Void in
            if let addressObject = response?.firstResult() {
                let deliveryAddress = OrderDeliveryAddress(coordinate: addressObject.coordinate, locality: addressObject.locality, postalCode: addressObject.postalCode, lines: addressObject.lines)

                self?.deliveryAddress = deliveryAddress
                modelDelegate?.update(location, deliveryAddress, nil)
            } else {
                let apiError = UPAPIError(error: error, data: nil)

                modelDelegate?.update(nil, nil, apiError)
            }
        })
    }
    
}

//  MARK: Location Manager Delegate

extension DeliveryLocationDataModel: LocationManagerDataModelDelegate {

    public func update(location: CLLocation?) {
        guard let newLocation = location else {
            dataModelDelegate?.update(nil, nil, nil)
            return
        }

        let now = Date()
        let hasPassedRefreshWindow = (nextLocationUpdateDate == nil || nextLocationUpdateDate! <= now)

        guard deliveryLocation == nil || hasPassedRefreshWindow else {
            dataModelDelegate?.update(deliveryLocation, deliveryAddress, nil)
            return
        }

        if let currentDeliveryLocation = deliveryLocation {
            let distanceInMeters = newLocation.distance(from: currentDeliveryLocation)
            if distanceInMeters <= DeliveryLocationDataModel.maxDistanceBetweenLocations {
                guard let deliveryAddress = deliveryAddress else {
                    resolveAddress(from: currentDeliveryLocation)
                    return
                }
                dataModelDelegate?.update(deliveryLocation, deliveryAddress, nil)
                return
            }
        }
        
        resolveAddress(from: newLocation)
    }

    public func locationManagerFailed(error: Error?) {
        dataModelDelegate?.handleLocationManagerFailure(error: error)
    }

    public func didChangeAuthorization(status: CLAuthorizationStatus) {
        dataModelDelegate?.didChangeAuthorization(status: status)
    }

}


//  App State Management

extension DeliveryLocationDataModel {

    @objc open override func appWillEnterForeground() {
        if let location = deliveryLocation {
            guard deliveryAddress == nil else { return }
            resolveAddress(from: location)
        } else {
            updateCurrentUserLocation()
        }
    }

    @objc open override func appDidEnterBackground() {
    }

}

//  Reachability

extension DeliveryLocationDataModel {

    @objc open override func networkIsAvailable() {
        if let location = deliveryLocation {
            guard deliveryAddress == nil else { return }
            resolveAddress(from: location)
        } else {
            updateCurrentUserLocation()
        }
    }

}
