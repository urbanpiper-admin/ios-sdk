//
//  ResetPasswordBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

/// A helper class that contains the related api's to reset the users password. The api's have to be called in the following order.
/// - forgotPassword(phone:completion:failure), calling this function sends an otp to the phone number the user entered
/// - resetPassword(otp:password:confirmPassword:completion:failure:) resets the password to the new password passed if the passed in otp is valid

public class ResetPasswordBuilder: NSObject {

    internal var phone: String?
    
    internal override init() {
    }

    /// API call sends an otp to the phone number passed in if the phone number is registered in the sytem, the phone number needs to contain the country code
    ///
    /// - Parameters:
    ///   - phone: the phone number provided by the user with the country code
    ///   - completion: success callback with a GenericRespone incicating the status of the call
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Returns an instance of URLSessionDataTask
    @discardableResult public func forgotPassword(phone: String, completion: @escaping (GenericResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        self.phone = phone
        return UserManager.shared.forgotPassword(phone: phone, completion: completion, failure: failure)
    }
    
    /// API call to  reset the password of the user
    ///
    /// - Parameters:
    ///   - otp: the otp received via the user phone
    ///   - password: the new password entered by the user
    ///   - confirmPassword: the confirmation password entered by the user
    ///   - completion: success callback with a GenericResponse inicating the status of the password reset
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Returns an instance of URLSessionDataTask
    @discardableResult public func resetPassword(otp: String, password: String, confirmPassword: String, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(phone != nil, "forgotPassword method should be called first")
        return UserManager.shared.resetPassword(phone: phone!, otp: otp, password: password, confirmPassword: confirmPassword, completion: completion, failure: failure)
    }
    
}
