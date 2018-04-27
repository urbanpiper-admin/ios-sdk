//
//  String+Validation.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 08/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension String {
    
    public var isValidEmailId: Bool {
//        let emailRegEx = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" // Strict validation
//        let emailRegEx = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*" // lax validation

//      super strict email validation
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    public var isValidPhoneNumber: Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return phoneTest.evaluate(with: self)
    }
    
    public var isValidPassword: Bool {
        guard !isEmpty else { return false }
        return trimmingCharacters(in: .whitespacesAndNewlines).count > 3
    }
    
    public var isValidStringEntry: Bool {
        guard !isEmpty else { return false }
        return trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
}
