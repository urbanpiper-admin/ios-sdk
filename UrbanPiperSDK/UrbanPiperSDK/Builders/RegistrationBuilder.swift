//
//  RegistrationBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

public class RegistrationBuilder: NSObject {
        
    @discardableResult public func registerUser(phone: String, name: String, email: String, password: String/*, referralObject: Referral?*/, completion: @escaping (RegistrationResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        
        return UserManager.shared.registerUser(name: name, phone: phone, email: email, password: password, referralObject: nil, completion: completion, failure: failure)
    }
    
    @discardableResult public func verifyRegOTP(phone: String,otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.verifyRegOTP(phone: phone, otp: otp, completion: completion, failure: failure)
    }
    
    @discardableResult public func resendOTP(phone: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.resendOTP(phone: phone, completion: completion, failure: failure)
    }

}
