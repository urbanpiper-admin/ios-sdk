//
//  User+Additions.swift
//  UrbanPiperSDK
//
//  Created by Vid on 31/12/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit
import PhoneNumberKit

extension User {

    public var countryCode: String {
        let defaultCountryCode = AppConfigManager.shared.firRemoteConfigDefaults.bizISDCode!
        guard let phoneNo = phone else { return defaultCountryCode }
        let phoneNumberKit = PhoneNumberKit()
        
        do {
            let phoneNumber = try phoneNumberKit.parse(phoneNo)
            return "+\(phoneNumber.countryCode)"
        }
        catch {
            return defaultCountryCode
        }
    }
    
    public var phoneNumberWithOutCountryCode: String? {
        guard let phoneNo = phone else { return nil }
        let phoneNumberKit = PhoneNumberKit()
        
        do {
            let phoneNumber = try phoneNumberKit.parse(phoneNo)
            return String(phoneNumber.numberString.dropFirst(countryCode.count))
        }
        catch {
            return nil
        }
    }
    
}
