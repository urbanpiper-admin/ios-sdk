//
//  String.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 14/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension String {

    static let stringToCurrentDateTimeFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        formatter.locale = Locale.currentAppleLanguage()
        formatter.formatterBehavior = .default
        formatter.dateFormat = "HH:mm:ss"

        return formatter
    }()

    public var currentDateTime: Date? {
        guard let date = String.stringToCurrentDateTimeFormatter.date(from: self) else { return  nil }

        let calendar: Calendar = Calendar(identifier: .gregorian)

        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)

        let now: Date = Date()
        let dateToday = calendar.date(bySettingHour: hour, minute: minutes, second: seconds, of: now)!

        return dateToday
    }
    
}
