//
//  ResetPasswordBuilder.swift
//  UrbanPiper
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit
import RxSwift

/// A helper class that contains the related api's to reset the user's password. The api's have to be called in the following order.
///
/// ResetPasswordBuilder is initialized by calling `UrbanPiper.startPasswordReset(...)`.
///
/// - `forgotPassword(...)`, calling this function sends an otp to the phone number the user entered
/// - `resetPassword(...)`, resets the password to the new password passed if the passed in otp is valid

public class ResetPasswordBuilder: NSObject {

    internal var phone: String?
    
    internal override init() {
    }

    /// API call sends an otp to the phone number passed in if the phone number is registered in the sytem, the phone number needs to contain the country code
    ///
    /// - Parameters:
    ///   - phone: The phone number provided by the user with the country code
    ///   - completion: `APICompletion` with a GenericRespone incicating the status of the call
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func forgotPassword(phone: String, completion: @escaping (GenericResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        self.phone = phone
        return UserManager.shared.forgotPassword(phone: phone, completion: completion, failure: failure)
    }
    
    func forgotPassword(phone: String) -> Observable<GenericResponse> {
        self.phone = phone
        return UserManager.shared.forgotPassword(phone: phone)
    }
    
    /// API call to  reset the password of the user
    ///
    /// - Parameters:
    ///   - otp: The otp received via the user phone
    ///   - password: The new password entered by the user
    ///   - confirmPassword: The confirmation password entered by the user
    ///   - completion: `APICompletion` with a GenericResponse inicating the status of the password reset
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func resetPassword(otp: String, password: String, confirmPassword: String, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(phone != nil, "forgotPassword method should be called first")
        guard phone != nil else { return nil }
        return UserManager.shared.resetPassword(phone: phone!, otp: otp, password: password, confirmPassword: confirmPassword, completion: completion, failure: failure)
    }
    
    func resetPassword(otp: String, password: String, confirmPassword: String) -> Observable<GenericResponse>? {
        assert(phone != nil, "forgotPassword method should be called first")
        guard phone != nil else { return nil }
        return UserManager.shared.resetPassword(phone: phone!, otp: otp, password: password, confirmPassword: confirmPassword)
    }
    
}
