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

    func update(_ deliveryLocation: CLLocation?, _ deliveryAddress: Address?, _ upError: UPError?)

    func handleLocationManagerFailure(error: Error?)
    func didChangeAuthorization(status: CLAuthorizationStatus)

}

public class DeliveryLocationDataModel: UrbanPiperDataModel {

    private struct LocationUserDefaultKeys {
        static let deliveryLocationLatitude: String = "DeliveryLocationLatitude"
        static let deliveryLocationLongitude: String = "DeliveryLocationLongitude"
        static let deliveryAddress: String = "DeliveryAddress"
    }
    
    @objc public static private(set) var shared: DeliveryLocationDataModel = DeliveryLocationDataModel()

    static let maxDistanceBetweenLocations: CLLocationDistance = CLLocationDistance(200)

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
        guard let lat: CLLocationDegrees = UserDefaults.standard.object(forKey: LocationUserDefaultKeys.deliveryLocationLatitude) as? CLLocationDegrees else { return nil }
        guard let lon: CLLocationDegrees = UserDefaults.standard.object(forKey: LocationUserDefaultKeys.deliveryLocationLongitude) as? CLLocationDegrees else { return nil }

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
    
    @objc public var deliveryAddress: Address? = {
        guard let addressData: Data = UserDefaults.standard.object(forKey: LocationUserDefaultKeys.deliveryAddress) as? Data else { return nil }
        OrderDeliveryAddress.registerClassName()
        Address.registerClassName()
        guard let orderDeliveryAddress: Address = NSKeyedUnarchiver.unarchiveObject(with: addressData) as? Address else { return nil }
        return orderDeliveryAddress
        }()
        {
        didSet {
            guard let address = deliveryAddress else {
                UserDefaults.standard.removeObject(forKey: LocationUserDefaultKeys.deliveryAddress)
                return
            }
            
            if let store = OrderingStoreDataModel.shared.nearestStoreResponse?.store {
                if let coordinate = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate {
                    AnalyticsManager.shared.nearestStoreFound(lat: coordinate.latitude,
                                                              lng: coordinate.longitude,
                                                              storeName: store.name)
                }
                
                if store.closingDay {
                    if let coordinate = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate {
                        AnalyticsManager.shared.nearestStoreClosedToday(lat: coordinate.latitude,
                                                                        lng: coordinate.longitude,
                                                                        deliveryAddress: address.fullAddress ?? "",
                                                                        storeName: store.name)
                    }
                } else if store.isStoreClosed {
                    if let coordinate = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate {
                        AnalyticsManager.shared.nearestStoreClosed(lat: coordinate.latitude,
                                                                   lng: coordinate.longitude,
                                                                   deliveryAddress: address.fullAddress ?? "",
                                                                   storeName: store.name)
                    }
                } else if store.temporarilyClosed {
                    if let coordinate = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate {
                        AnalyticsManager.shared.nearestStoreTemporarilyClosed(lat: coordinate.latitude,
                                                                              lng: coordinate.longitude,
                                                                              deliveryAddress: address.fullAddress ?? "",
                                                                              storeName: store.name)
                    }
                }
            } else {
                if let coordinate = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate {
                    AnalyticsManager.shared.noStoresNearBy(lat: coordinate.latitude, lng: coordinate.longitude)
                }
            }

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

    public func updateCurrentUserLocation(forced: Bool) {
        if CLLocationManager.locationServicesEnabled(), forced {
            nextLocationUpdateDate = nil
        }
        
        LocationManagerDataModel.shared.updateUserLocation()
    }

    public func setCustomDelivery(location: CLLocation, address: Address?) {
        if let addressObject = address {
            deliveryLocation = location
            deliveryAddress = addressObject
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
        let dataTask = APIManager.shared.reverseGeoCode(lat: location.coordinate.latitude, lng: location.coordinate.longitude, completion: { [weak self] (placeDetailsResponse) in
            if placeDetailsResponse?.result != nil {
                let deliveryAddress = Address(placeDetailsResponse: placeDetailsResponse!)
                self?.deliveryAddress = deliveryAddress
                modelDelegate?.update(location, deliveryAddress, nil)
            } else {
                let upError = UPError(type: .apiError)
                modelDelegate?.update(nil, nil, upError)
            }            
        }, failure: { (error) in
            modelDelegate?.update(nil, nil, error)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
        
//        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate, completionHandler: { [weak self] (response, error) -> Void in
//            if let addressObject = response?.firstResult() {
//                print("\ndelivery address \(addressObject as AnyObject)\n")
//
//                let deliveryAddress: Address = Address(coordinate: addressObject.coordinate, thoroughfare: addressObject.thoroughfare,
//                                                       locality: addressObject.locality, administrativeArea: addressObject.administrativeArea,
//                                                       postalCode: addressObject.postalCode, lines: addressObject.lines)
//
//                self?.deliveryAddress = deliveryAddress
//                modelDelegate?.update(location, deliveryAddress, nil)
//            } else {
//                let apiError: UPAPIError? = UPAPIError(error: error, data: nil)
//
//                modelDelegate?.update(nil, nil, apiError)
//            }
//        })
    }
    
}

//  MARK: Location Manager Delegate

extension DeliveryLocationDataModel: LocationManagerDataModelDelegate {

    public func update(location: CLLocation?) {
        guard let newLocation = location else {
            dataModelDelegate?.update(nil, nil, nil)
            return
        }

        let now: Date = Date()
        let hasPassedRefreshWindow = (nextLocationUpdateDate == nil || nextLocationUpdateDate! <= now)

        guard deliveryLocation == nil || hasPassedRefreshWindow else { return }

        if let currentDeliveryLocation = deliveryLocation {
            let distanceInMeters = newLocation.distance(from: currentDeliveryLocation)
            if distanceInMeters <= DeliveryLocationDataModel.maxDistanceBetweenLocations {
                guard let deliveryAddress = deliveryAddress else {
                    resolveAddress(from: currentDeliveryLocation)
                    return
                }
                nextLocationUpdateDate = Calendar.current.date(byAdding: .minute,
                                                               value: Int(DeliveryLocationDataModel.locationUpdateTimeInterval),
                                                               to: Date())
                dataModelDelegate?.update(deliveryLocation, deliveryAddress, nil)
                return
            }
        }
        
        resolveAddress(from: newLocation)
    }

    public func locationManagerFailed(error: Error?) {
        dataModelDelegate?.handleLocationManagerFailure(error: error)
        guard let userLocation = LocationManagerDataModel.shared.currentUserLocation, deliveryAddress == nil else { return }
        resolveAddress(from: userLocation)
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
            updateCurrentUserLocation(forced: true)
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
            updateCurrentUserLocation(forced: true)
        }
    }

}
