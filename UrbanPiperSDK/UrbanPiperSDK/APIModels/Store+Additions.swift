//
//  Store+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 14/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit
import CoreLocation

extension Store {

    public var isStoreClosed: Bool {
        if openingTime != nil, closingTime != nil {
            let currentTime: Date = Date()
            if let openingTime = openingDate, let closingTiming = closingDate {
                guard currentTime > openingTime, currentTime < closingTiming else { return true }
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

    @objc public var isStoreClosedForDelivery: Bool {
        guard let closingTimeForDelivery = closingDate?.addingTimeInterval(TimeInterval(-AppConfigManager.shared.firRemoteConfigDefaults.orderDeliveryOffsetSecs)) else { return false }

        //        guard let openingTimeForDelivery = closingDate?.addingTimeInterval(TimeInterval(-AppConfigManager.shared.firRemoteConfigDefaults.orderDeliveryOffsetSecs)) else { return false }
        //
        //        let now: Date = Date()
        //
        //        return now >= openingTimeForDelivery && now <= closingTimeForDelivery

        return Date() > closingTimeForDelivery
    }
    
    public var openingDate: Date? {
        guard let openingTimeString: String = openingTime, let openingTime = openingTimeString.currentDateTime else { return nil }
        return openingTime
    }
    
    public var closingDate: Date? {
        guard let closingTimeString: String = closingTime, let closingTime = closingTimeString.currentDateTime else { return nil }
        return closingTime
    }
    
    public var coordinate: CLLocationCoordinate2D? {
        guard let latVal = lat, let lngVal = lng, latVal != 0, lngVal != 0 else { return nil }
        return CLLocationCoordinate2DMake(CLLocationDegrees(latVal), CLLocationDegrees(lngVal))
    }
    
    public func distanceFrom(location: CLLocation) -> Double? {
        guard let latVal = lat, let lngVal = lng, latVal != 0, lngVal != 0 else { return nil }
        let storeLocation = CLLocation(latitude: CLLocationDegrees(latVal), longitude: CLLocationDegrees(lngVal))
        return CLLocationDistance(storeLocation.distance(from: location) / 1000)
    }

}
