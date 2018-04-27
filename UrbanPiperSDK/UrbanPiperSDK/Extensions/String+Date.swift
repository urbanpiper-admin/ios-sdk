//
//  String.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 14/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension String {

    static let stringToDateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        formatter.locale = NSLocale.current
        formatter.formatterBehavior = .default
        formatter.dateFormat = "HH:mm:ss"

        return formatter
    }()

    public var date: Date? {
        guard let date = String.stringToDateFormatter.date(from: self) else { return  nil }

        let calendar = Calendar(identifier: .gregorian)

        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)

        let now = Date()
        let dateToday = calendar.date(bySettingHour: hour, minute: minutes, second: seconds, of: now)!

        return dateToday
    }
    
}
