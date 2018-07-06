//
//  Date.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 14/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

//  MARK: Locale

extension Date {
    
    static public var nextMinuteSecondsLeft: TimeInterval {
        let seconds = Calendar.current.component(Calendar.Component.second, from: Date())
        return TimeInterval(60 - seconds)
    }
    
    static public var currentHourRangeString: String {
        let hour = Calendar.current.component(Calendar.Component.hour, from: Date())
        return "\(hour):00 - \(hour + 1):00"
    }

    static let localeDateToStringFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        formatter.locale = NSLocale.current
        formatter.formatterBehavior = .default

        return formatter
    }()
    
//  MARK: Time
    
    public var hhmmaString: String {
        Date.localeDateToStringFormatter.dateFormat = "hh:mm a"
        return Date.localeDateToStringFormatter.string(from: self)
    }
    
    public var yyyymmddString: String {
        Date.localeDateToStringFormatter.dateFormat = "yyyy-MM-dd"
        return Date.localeDateToStringFormatter.string(from: self)
    }
    
    public var hhmmaddMMMyyyyString: String {
        Date.localeDateToStringFormatter.dateFormat = "hh:mm a, dd MMM yyyy";
        return Date.localeDateToStringFormatter.string(from: self)
    }
    
//  MARK: Date
    
    public var ddMMMString: String {
        Date.localeDateToStringFormatter.dateFormat = "dd MMM"
        return Date.localeDateToStringFormatter.string(from: self)
    }
    
    public var dayName: String {
        Date.localeDateToStringFormatter.dateFormat = "EEEE"
        return Date.localeDateToStringFormatter.string(from: self)
    }
    
//  MARK: Time
    
    public var orderedTimeString: String {
        Date.localeDateToStringFormatter.dateFormat = "dd LLL, yyyy (hh:mm a)";
        return Date.localeDateToStringFormatter.string(from: self)
    }

}
