//
//  SharedPreferences.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 28/08/19.
//

import UIKit

class SharedPreferences: NSObject {
    private static let IsNotFirstLaunchKey: String = "IsNotFirstLaunchKey"

    private static let defaults = UserDefaults.standard

    static var currentLocale: Locale = Locale(identifier: Language.english.rawValue)

    static var language: Language = Language.english {
        didSet {
            currentLocale = Locale(identifier: language.rawValue)
        }
    }

    static var isNotFirstLaunch: Bool {
        get {
            return defaults.bool(forKey: SharedPreferences.IsNotFirstLaunchKey)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SharedPreferences.IsNotFirstLaunchKey)
        }
    }
}
