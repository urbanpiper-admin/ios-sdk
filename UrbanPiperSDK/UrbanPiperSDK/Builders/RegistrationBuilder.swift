//
//  RegistrationBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

public class RegistrationBuilder: NSObject {
    
    public private(set) var phone: String?
    
    @discardableResult public func registerUser(phone: String, name: String, email: String, password: String/*, referralObject: Referral?*/, completion: @escaping (RegistrationResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        var referralObject: Referral? = nil
        if let responseData: Data = UserDefaults.standard.object(forKey: "referral dictionary") as? Data, let referralParams = NSKeyedUnarchiver.unarchiveObject(with: responseData) as? Referral {
            referralObject = referralParams
        }
        self.phone = phone
        return UserManager.shared.registerUser(name: name, phone: phone, email: email, password: password, referralObject: referralObject, completion: completion, failure: failure)
    }
    
    @discardableResult public func verifyRegOTP(phone: String,otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        self.phone = phone
        return UserManager.shared.verifyRegOTP(phone: phone, otp: otp, completion: completion, failure: failure)
    }
    
    @discardableResult public func resendRegOTP(completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(phone != nil, "verifyRegOTP method should be called first")
        guard phone != nil else { return nil }
        
        return UserManager.shared.resendOTP(phone: phone!, completion: completion, failure: failure)
    }

}
