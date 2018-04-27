//
//  LocationDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 10/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

@objc public protocol OrderingStoreDataModelDelegate {

    @objc func update(_ storeResponse: StoreResponse?, _ deliveryLocation: CLLocation?, _ error: UPError?, _ storeUpdated: Bool)

    @objc func handleLocationManagerFailure(error: Error?)
    @objc func didChangeAuthorization(status: CLAuthorizationStatus)

}

public class OrderingStoreDataModel: UrbanPiperDataModel {

    private struct OrderingStoreUserDefaultKeys {
        static let nearestStoreResponseKey = "NearestStoreResponse"
    }

    private typealias WeakRefDataModelDelegate = WeakRef<OrderingStoreDataModelDelegate>

    static private var observers = [WeakRefDataModelDelegate]()

    @objc public static var nearestStoreResponse: StoreResponse? = {
        guard let storeResponseData = UserDefaults.standard.object(forKey: OrderingStoreUserDefaultKeys.nearestStoreResponseKey) as? Data else { return nil }
        Biz.registerClassNameWhiteLabel()
        Store.registerClassNameWhiteLabel()
        
        FeedbackConfig.registerClassNameWhiteLabel()
        TimeSlot.registerClassNameWhiteLabel()

        StoreResponse.registerClassName()

        guard let storeResponse = NSKeyedUnarchiver.unarchiveObject(with: storeResponseData) as? StoreResponse else { return nil }
        return storeResponse
        }()
        {
        didSet {
            guard let storeResponse = nearestStoreResponse else {
                UserDefaults.standard.removeObject(forKey: OrderingStoreUserDefaultKeys.nearestStoreResponseKey)
                return
            }

            if let previousStoreId = oldValue?.store?.bizLocationId, let currentStoreId = storeResponse.store?.bizLocationId, previousStoreId != currentStoreId {
                
                if let store = storeResponse.store {
                    if let deliverAddress = DeliveryLocationDataModel.deliveryAddress?.fullAddress {
                        if store.closingDay || store.isStoreClosed {
                            if let coordinate = DeliveryLocationDataModel.deliveryLocation?.coordinate {
//                                AnalyticsManager.shared.nearestStoreClosed(lat: coordinate.latitude,
//                                                                           lng: coordinate.longitude,
//                                                                           deliveryAddress: deliverAddress,
//                                                                           storeName: store.name)
                            }
                            
                        } else if store.temporarilyClosed {
                            if let coordinate = DeliveryLocationDataModel.deliveryLocation?.coordinate {
//                                AnalyticsManager.shared.nearestStoreTemporarilyClosed(lat: coordinate.latitude,
//                                                                                      lng: coordinate.longitude,
//                                                                                      deliveryAddress: deliverAddress,
//                                                                                      storeName: store.name)
                            }
                        }
                    }
                } else {
                    if let coordinate = DeliveryLocationDataModel.deliveryLocation?.coordinate {
//                        AnalyticsManager.shared.noStoresNearBy(lat: coordinate.latitude, lng: coordinate.longitude)
                    }
                }
                CartManager.shared.clearCart()
            }

            StoreResponse.registerClassName()
            let storeResponseData: Data = NSKeyedArchiver.archivedData(withRootObject: storeResponse)

            UserDefaults.standard.set(storeResponseData, forKey: OrderingStoreUserDefaultKeys.nearestStoreResponseKey)
        }
    }


    weak public var dataModelDelegate: OrderingStoreDataModelDelegate?

    public typealias UpdateCompletionBlock = (StoreResponse?, UPError?) -> Void
    var updateCompletionBlock: UpdateCompletionBlock?

    var deliveryLocationDataModel: DeliveryLocationDataModel!

    var isFetchingNearestStoreForLocation: CLLocation?

    public override init() {
        super.init()

        deliveryLocationDataModel = DeliveryLocationDataModel(delegate: self)
    }

    @objc public convenience init(delegate: OrderingStoreDataModelDelegate) {
        self.init()
        dataModelDelegate = delegate

        let weakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
        OrderingStoreDataModel.observers.append(weakRefDataModelDelegate)
    }

    deinit {
        OrderingStoreDataModel.observers = OrderingStoreDataModel.observers.filter { $0.value != nil && $0 !== dataModelDelegate }
    }

    @objc public func updateLocationAndNearestStore(completion: @escaping UpdateCompletionBlock) {
        updateCompletionBlock = completion
        deliveryLocationDataModel.updateCurrentUserLocation()
    }

}

//  MARK: API Calls

extension OrderingStoreDataModel {

    fileprivate func fetchNearestStore(location: CLLocation) {

        guard isFetchingNearestStoreForLocation == nil || isFetchingNearestStoreForLocation! != location else {
            _ = OrderingStoreDataModel.observers.map { $0.value?.update(nil, location, nil, false) }
            return
        }

        isFetchingNearestStoreForLocation = location

        OrderingStoreDataModel.nearestStoreResponse = nil
        
        _ = OrderingStoreDataModel.observers.map { $0.value?.update(nil, location, nil, false) }
        
        let dataTask = APIManager.shared.fetchNearestStore(location.coordinate, completion: { [weak self] (data) in
            defer {
                _ = OrderingStoreDataModel.observers.map { $0.value?.update(OrderingStoreDataModel.nearestStoreResponse, location, nil, true) }
                self?.updateCompletionBlock?(OrderingStoreDataModel.nearestStoreResponse, nil)
                self?.updateCompletionBlock = nil
            }

            self?.isFetchingNearestStoreForLocation = nil

            guard let response = data else { return }
            OrderingStoreDataModel.nearestStoreResponse = response
            
            }, failure: { [weak self] (upError) in
                self?.isFetchingNearestStoreForLocation = nil

                defer {
                    _ = OrderingStoreDataModel.observers.map { $0.value?.update(nil, nil, upError, false) }
                    self?.updateCompletionBlock?(nil, upError)
                    self?.updateCompletionBlock = nil
                }
        })

        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  MARK: Custom Delivery Location Selection

extension OrderingStoreDataModel {

    @objc public func updateNearestStore(for location: CLLocation?, address: GMSAddress? = nil, completion: UpdateCompletionBlock?) {
        guard let loc = location else {
            _ = OrderingStoreDataModel.observers.map { $0.value?.update(nil, nil, nil, false) }
            completion?(nil, nil)
            return
        }

        updateCompletionBlock = completion
        deliveryLocationDataModel.setCustomDelivery(location: loc, address: address)
    }
}

extension OrderingStoreDataModel: DeliveryLocationDataModelDelegate {

    public func update(_ deliveryLocation: CLLocation?, _ deliveryAddress: OrderDeliveryAddress?, _ upError: UPError?) {
        if let error = upError {
            _ = OrderingStoreDataModel.observers.map { $0.value?.update(nil, nil, error, false) }
            updateCompletionBlock?(nil, error)
            updateCompletionBlock = nil
        } else if deliveryLocation != nil && (deliveryAddress == nil || OrderingStoreDataModel.nearestStoreResponse == nil) {
            fetchNearestStore(location: deliveryLocation!)
            _ = OrderingStoreDataModel.observers.map { $0.value?.update(OrderingStoreDataModel.nearestStoreResponse, deliveryLocation, nil, false) }
        } else if deliveryLocation != nil, deliveryAddress != nil, upError == nil {
            _ = OrderingStoreDataModel.observers.map { $0.value?.update(OrderingStoreDataModel.nearestStoreResponse, deliveryLocation, nil, false) }
            
            updateCompletionBlock?(OrderingStoreDataModel.nearestStoreResponse, nil)
            updateCompletionBlock = nil
        } else if DeliveryLocationDataModel.deliveryLocation == nil, DeliveryLocationDataModel.deliveryAddress == nil {
            _ = OrderingStoreDataModel.observers.map { $0.value?.update(nil, nil, nil, false) }
            updateCompletionBlock?(nil, nil)
            updateCompletionBlock = nil
        }
    }

    public func handleLocationManagerFailure(error: Error?) {
        _ = OrderingStoreDataModel.observers.map { $0.value?.handleLocationManagerFailure(error: error) }
    }

    public func didChangeAuthorization(status: CLAuthorizationStatus) {
        _ = OrderingStoreDataModel.observers.map { $0.value?.didChangeAuthorization(status: status) }
    }

}


//  App State Management

extension OrderingStoreDataModel {

    @objc open override func appWillEnterForeground() {
        guard let deliveryLocation = DeliveryLocationDataModel.deliveryLocation,
            let deliveryAddress = DeliveryLocationDataModel.deliveryAddress,
            OrderingStoreDataModel.nearestStoreResponse == nil else { return }
        update(deliveryLocation, deliveryAddress, nil)
    }

    @objc open override func appDidEnterBackground() {
    }
    
}

//  Reachability

extension OrderingStoreDataModel {

    @objc open override func networkIsAvailable() {
        guard let deliveryLocation = DeliveryLocationDataModel.deliveryLocation,
            let deliveryAddress = DeliveryLocationDataModel.deliveryAddress,
            OrderingStoreDataModel.nearestStoreResponse == nil else { return }
        update(deliveryLocation, deliveryAddress, nil)
    }

}
