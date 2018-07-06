//
//  LocationManagerDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 11/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit
import CoreLocation

@objc public protocol LocationManagerDataModelDelegate {

    @objc func update(location: CLLocation?)
    @objc func locationManagerFailed(error: Error?)
    @objc func didChangeAuthorization(status: CLAuthorizationStatus)

}

public class LocationManagerDataModel: UrbanPiperDataModel {

    private typealias WeakRefDataModelDelegate = WeakRef<LocationManagerDataModelDelegate>

    @objc public static private(set) var shared: LocationManagerDataModel = LocationManagerDataModel()

    @objc public var currentUserLocation: CLLocation?

    lazy var locationManager: CLLocationManager = {
        let manager: CLLocationManager = CLLocationManager()
        manager.delegate = self
        manager.pausesLocationUpdatesAutomatically = false
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        return manager
    }()

    private var locationUpdateObservers = [WeakRefDataModelDelegate]()
    
    private override init() {
        super.init()
        updateUserLocation()
    }

    func addObserver(delegate: LocationManagerDataModelDelegate) {
        let weakRefDataModelDelegate: WeakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
        locationUpdateObservers.append(weakRefDataModelDelegate)
    }


    func removeObserver(delegate: LocationManagerDataModelDelegate) {
        guard let index = (locationUpdateObservers.index { $0.value === delegate }) else { return }
        locationUpdateObservers.remove(at: index)
    }

    @objc public func updateUserLocation() {
        locationManager.startUpdatingLocation()
    }

    public func locationDetermined() {
        locationManager.stopUpdatingLocation()
    }

}

extension LocationManagerDataModel: CLLocationManagerDelegate {

    // MARK: - CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            currentUserLocation = nil
            locationUpdateObservers = locationUpdateObservers.filter { $0.value != nil }
            locationUpdateObservers.last?.value?.update(location: nil)
            return
        }

        print("HorizontalAccuracy \(location.horizontalAccuracy)")
//        guard location.horizontalAccuracy < 200 else { return }

        currentUserLocation = location
        locationDetermined()

        locationUpdateObservers = locationUpdateObservers.filter { $0.value != nil }
        locationUpdateObservers.last?.value?.update(location: location)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationUpdateObservers = locationUpdateObservers.filter { $0.value != nil }
        locationUpdateObservers.last?.value?.locationManagerFailed(error: error)
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways: break
//            manager.startUpdatingLocation()
        case .restricted, .denied:
            currentUserLocation = nil
            manager.stopUpdatingLocation()
        }

        locationUpdateObservers = locationUpdateObservers.filter { $0.value != nil }
        locationUpdateObservers.last?.value?.didChangeAuthorization(status: status)
    }

}

//  App State Management

extension LocationManagerDataModel {

    @objc open override func appWillEnterForeground() {
    }

    @objc open override func appDidEnterBackground() {
    }
}

//  Reachability

extension LocationManagerDataModel {

    @objc open override func networkIsAvailable() {
    }

}

