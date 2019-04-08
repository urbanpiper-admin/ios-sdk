//
//  Locale.swift
//  UrbanPiper
//
//  Created by Vid on 26/10/18.
//

import UIKit

internal extension Locale {
    static func currentAppleLanguage() -> Locale{
        let current = currentAppleLanguageFull()
        let endIndex = current.index(current.startIndex, offsetBy: 2)
        let currentWithoutLocale = String(current[..<endIndex])
        return Locale(identifier: currentWithoutLocale)
    }
    
    static func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: "AppleLanguages") as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
}
