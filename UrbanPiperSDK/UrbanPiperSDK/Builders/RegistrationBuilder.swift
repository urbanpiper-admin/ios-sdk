//
//  RegistrationBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

/// A helper class that contains the related api's to register an user. The api's have to be called in the following order.
///
/// RegistrationBuilder is initialized by calling `UrbanPiperSDK.startRegistration(...)`.
///
/// - `registerUser(...)`, call can be ignored if the user has already been registered and otp verification is pending
/// - `verifyRegOTP(...)`, call to verify the otp sent to the user's phone number
/// - `resendRegOTP(...)`, sends an new otp to validate the user's phone number

public class RegistrationBuilder: NSObject {
    
    /// API call to  register an user to your business
    ///
    /// - Parameters:
    ///   - phone: The phone number entered by the user
    ///   - name: The name entered by the user
    ///   - email: The email entered by the user
    ///   - password: The password entered by the user
    ///   - completion: `APICompletion` with `RegistrationResponse` if the success var is true then the registration is successful
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func registerUser(phone: String, name: String, email: String, password: String/*, referralObject: Referral?*/, completion: @escaping (RegistrationResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        var referralObject: Referral? = nil
        if let responseData: Data = UserDefaults.standard.object(forKey: "referral dictionary") as? Data, let referralParams = NSKeyedUnarchiver.unarchiveObject(with: responseData) as? Referral {
            referralObject = referralParams
        }
        return UserManager.shared.registerUser(name: name, phone: phone, email: email, password: password, referralObject: referralObject, completion: completion, failure: failure)
    }
    
    /// API call to verify the otp sent to the user's phone number
    ///
    /// - Parameters:
    ///   - phone: The phone number of the user
    ///   - otp: The OTP sent to the user's phone number
    ///   - completion: `APICompletion` with `RegistrationResponse` with the success var set to true if the otp has been verified and the user registration is complete
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func verifyRegOTP(phone: String,otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.verifyRegOTP(phone: phone, otp: otp, completion: completion, failure: failure)
    }
    
    /// Send a new otp to the passed in user's phone number
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `RegistrationResponse` if the success variable is true a new OTP has been sent
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func resendRegOTP(phone: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        return UserManager.shared.resendOTP(phone: phone, completion: completion, failure: failure)
    }

}
