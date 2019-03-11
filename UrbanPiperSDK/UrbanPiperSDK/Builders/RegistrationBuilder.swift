//
//  RegistrationBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

/// A helper class that contains the related api's to register an user. The api's have to be called in the following order.
/// - registerUser(phone:name:email:completion:failure), call can be ignored if the user has already been registered and otp verification is pending
/// - verifyRegOTP(phone:otp:completion:failure:) call to verify the otp sent to the users phone number
/// - resendRegOTP(phone:) sends an new otp to validate the users phone number

public class RegistrationBuilder: NSObject {
    
    /// API call to  register an user to your business
    ///
    /// - Parameters:
    ///   - phone: the phone number entered by the user
    ///   - name: the name entered by the user
    ///   - email: the email entered by the user
    ///   - password: the password entered by the user
    ///   - completion: success callback with RegistrationResponse if the success var is true then the registration is successful
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func registerUser(phone: String, name: String, email: String, password: String/*, referralObject: Referral?*/, completion: @escaping (RegistrationResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        var referralObject: Referral? = nil
        if let responseData: Data = UserDefaults.standard.object(forKey: "referral dictionary") as? Data, let referralParams = NSKeyedUnarchiver.unarchiveObject(with: responseData) as? Referral {
            referralObject = referralParams
        }
        return UserManager.shared.registerUser(name: name, phone: phone, email: email, password: password, referralObject: referralObject, completion: completion, failure: failure)
    }
    
    /// API call to  verify the otp sent to the users phone number
    ///
    /// - Parameters:
    ///   - phone: the phone number of the user
    ///   - otp: the OTP sent to the users phone number
    ///   - completion: success callback with RegistrationResponse with the success var set to true if the otp has been verified and the user registration is complete
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func verifyRegOTP(phone: String,otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.verifyRegOTP(phone: phone, otp: otp, completion: completion, failure: failure)
    }
    
    /// Send a new otp to the passed in users phone number
    ///
    /// - Parameters:
    ///   - completion: success callback indicating if a new OTP has been sent or not
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func resendRegOTP(phone: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        return UserManager.shared.resendOTP(phone: phone, completion: completion, failure: failure)
    }

}
