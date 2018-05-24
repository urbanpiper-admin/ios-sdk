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
        static let nextLocationUpdateDate = "NextLocationUpdateDate"
        static let deliveryLocationLatitude = "DeliveryLocationLatitude"
        static let deliveryLocationLongitude = "DeliveryLocationLongitude"
        static let deliveryAddress = "DeliveryAddress"
    }

    static let maxDistanceBetweenLocations = CLLocationDistance(200)

    @objc static let locationUpdateTimeInterval: Int = {
        #if DEBUG
            return 1
        #else
            return 10
        #endif
    }()
    
    @objc static var nextLocationUpdateDate: Date?

    @objc static var userSelectedDeliveryLocation: Bool = false

    @objc public static var deliveryLocation: CLLocation? = {
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

    @objc public static var deliveryAddress: OrderDeliveryAddress? = {
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
            
            if let store = OrderingStoreDataModel.nearestStoreResponse?.store {
                if store.closingDay || store.isStoreClosed {
                    if let coordinate = DeliveryLocationDataModel.deliveryLocation?.coordinate {
                        AnalyticsManager.shared.nearestStoreClosed(lat: coordinate.latitude,
                                                                   lng: coordinate.longitude,
                                                                   deliveryAddress: address.fullAddress ?? "",
                                                                   storeName: store.name)
                    }
                    
                } else if store.temporarilyClosed {
                    if let coordinate = DeliveryLocationDataModel.deliveryLocation?.coordinate {
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
        LocationManagerDataModel.addObserver(delegate: self)
    }
    
    convenience init(delegate: DeliveryLocationDataModelDelegate) {
        self.init()
        dataModelDelegate = delegate
        guard let location = DeliveryLocationDataModel.deliveryLocation, DeliveryLocationDataModel.deliveryAddress == nil else { return }
        resolveAddress(from: location)
    }

    deinit {
        LocationManagerDataModel.removeObserver(delegate: self)
    }

    public func updateCurrentUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            DeliveryLocationDataModel.nextLocationUpdateDate = nil
        }
        
        LocationManagerDataModel.shared.updateUserLocation()
    }

    public func setCustomDelivery(location: CLLocation, address: GMSAddress?) {
        if let addressObject = address {
            let deliveryAddress = OrderDeliveryAddress(gmsAddress: addressObject)
            DeliveryLocationDataModel.deliveryAddress = deliveryAddress

            dataModelDelegate?.update(location, deliveryAddress, nil)
        } else {
            resolveAddress(from: location)
        }
    }
    
}

//  MARK: API Calls

extension DeliveryLocationDataModel {

    public func resolveAddress(from location: CLLocation) {
        DeliveryLocationDataModel.nextLocationUpdateDate = Calendar.current.date(byAdding: .minute,
                                                                                 value: Int(DeliveryLocationDataModel.locationUpdateTimeInterval),
                                                                                 to: Date())
        
        DeliveryLocationDataModel.deliveryLocation = location
        
        dataModelDelegate?.update(location, nil, nil)

        let modelDelegate = dataModelDelegate
        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate, completionHandler: { (response, error) -> Void in
            if let address = response?.firstResult() {
                let address = OrderDeliveryAddress(gmsAddress: address)
                DeliveryLocationDataModel.deliveryAddress = address

                modelDelegate?.update(location, address, nil)
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

        let nextLocationUpdateDate = DeliveryLocationDataModel.nextLocationUpdateDate
        let now = Date()
        let hasPassedRefreshWindow = (nextLocationUpdateDate == nil || nextLocationUpdateDate! <= now)

        guard DeliveryLocationDataModel.deliveryLocation == nil || hasPassedRefreshWindow else {
            dataModelDelegate?.update(DeliveryLocationDataModel.deliveryLocation, DeliveryLocationDataModel.deliveryAddress, nil)
            return
        }

        if let currentDeliveryLocation = DeliveryLocationDataModel.deliveryLocation {
            let distanceInMeters = newLocation.distance(from: currentDeliveryLocation)
            if distanceInMeters <= DeliveryLocationDataModel.maxDistanceBetweenLocations {
                guard let deliveryAddress = DeliveryLocationDataModel.deliveryAddress else {
                    resolveAddress(from: currentDeliveryLocation)
                    return
                }
                dataModelDelegate?.update(DeliveryLocationDataModel.deliveryLocation, deliveryAddress, nil)
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
        if let location = DeliveryLocationDataModel.deliveryLocation {
            guard DeliveryLocationDataModel.deliveryAddress == nil else { return }
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
        if let location = DeliveryLocationDataModel.deliveryLocation {
            guard DeliveryLocationDataModel.deliveryAddress == nil else { return }
            resolveAddress(from: location)
        } else {
            updateCurrentUserLocation()
        }
    }

}
