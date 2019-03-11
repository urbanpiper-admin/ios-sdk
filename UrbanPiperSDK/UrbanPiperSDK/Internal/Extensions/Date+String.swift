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
        
    static internal var currentHourRangeString: String {
        let hour = Calendar.current.component(Calendar.Component.hour, from: Date())
        return "\(hour):00 - \(hour + 1):00"
    }

    static let localeDateToStringFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        formatter.locale = Locale.currentAppleLanguage()
        formatter.formatterBehavior = .default

        return formatter
    }()
    
    //  MARK: Time
    
    internal var hhmmaString: String {
        Date.localeDateToStringFormatter.dateFormat = "hh:mm a"
        return Date.localeDateToStringFormatter.string(from: self)
    }

    internal var yyyymmddString: String {
        Date.localeDateToStringFormatter.dateFormat = "yyyy-MM-dd"
        return Date.localeDateToStringFormatter.string(from: self)
    }
        
//  MARK: Date
    
    internal var dayName: String {
        Date.localeDateToStringFormatter.dateFormat = "EEEE"
        return Date.localeDateToStringFormatter.string(from: self)
    }
    
}
