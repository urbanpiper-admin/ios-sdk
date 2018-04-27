//
//  Store+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 14/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension Store {

    public var isStoreClosed: Bool {
        if openingTime != nil, closingTime != nil {
            let currentTime = Date()
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
    
    public var openingDate: Date? {
        guard let openingTimeString = openingTime, let openingTime = openingTimeString.date else { return nil }
        return openingTime
    }
    
    public var closingDate: Date? {
        guard let closingTimeString = closingTime, let closingTime = closingTimeString.date else { return nil }
        return closingTime
    }

}
