//
//  SocialRegBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

/// A helper class that contains the related api's to register a social login user. The api's have to be called in the following order.
///
/// SocialRegBuilder is initialized by calling `UrbanPiperSDK.startSocialRegistration(...)`.
///
/// - `verifyPhone(...)`, function to verify the phone number provided by an unregistered social login user, sends an OTP to the phone number passed on success, if the message variable is "new_registration_required" the user has be registered using the `registerSocialUser(...)`, call, else the user's phone number is already present in the system and the phone number needs to be verified by the `verifySocialOTP(...)`, call
/// - `registerSocialUser(...)`, function to register a new social login user if the message variable in verifyPhone response is "new_registration_required"
/// - `verifyRegOTP(...)`, function to verify the phone number passed in by the user if the message variable in verifyPhone response is "new_registration_required"
/// - `resendRegOTP(...)`, function to resend a new otp to the user's phone number passed in by the user if the message variable in verifyPhone response is "new_registration_required"
/// - `verifySocialOTP(...)`, function to verify the phone number passed in by the user if the message variable in verifyPhone response is not "new_registration_required"
/// - `resendSocialOTP(...)`, function to resend a new otp to the user's phone number passed in by the user if the message variable in verifyPhone response is not "new_registration_required"

public class SocialRegBuilder: NSObject {
    
    internal private(set) var name: String?
    internal private(set) var phone: String?
    internal private(set) var email: String?
    internal private(set) var gender: String?
    internal private(set) var provider: SocialLoginProvider?
    internal private(set) var providerAccessToken: String?

    private var verifyPhoneResponse: SocialLoginResponse?
    private var registrationResponse: RegistrationResponse?

    internal override init() {
    }

    /// API call to  check if the passed in phone number is already present in the system
    ///
    /// - Parameters:
    ///   - name: The name of the user from the social login provider
    ///   - phone: The phone number entered by the user
    ///   - email: The email id of the user from the social login provider
    ///   - gender: Optional. The gender value from the social login provider
    ///   - provider: The `SocialLoginProvider` from which the data is from (i.e google, facebook etc.)
    ///   - providerAccessToken: The access token provided by the social login provider
    ///   - completion: `APICompletion` with `SocialLoginResponse`, if the message value is "new_registration_required" the user has to be registered using `registerSocialUser(...)`, else the user's phone number is already present in the system and it needs to be verified by calling `verifySocialOTP(...)`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func verifyPhone(name: String, phone: String, email: String, gender: String?, provider: SocialLoginProvider, providerAccessToken: String, completion: @escaping ((SocialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        self.name = name
        self.phone = phone
        self.email = email
        self.gender = gender
        self.provider = provider
        self.providerAccessToken = providerAccessToken

        self.verifyPhoneResponse = nil
        self.registrationResponse = nil
        
        return UserManager.shared.verifyPhone(phone: phone, email: email, socialLoginProvider: provider, accessToken: providerAccessToken, completion: { [weak self] (response) in
            self?.verifyPhoneResponse = response
            completion(response)
            }, failure: failure)
    }

    /// Function to register a new social login user
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `RegistrationResponse`, sends an otp to the passed in phone number, user is registered successfully if the success variable is true, for a new user registration to verify the OTP the function `verifyRegOTP(...)`, should be called, and to resend the OTP the `resendRegOTP(...)`, should be called
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func registerSocialUser(completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        
        var referralObject: Referral? = nil
        if let responseData: Data = UserDefaults.standard.object(forKey: "referral dictionary") as? Data, let referralParams = NSKeyedUnarchiver.unarchiveObject(with: responseData) as? Referral {
            referralObject = referralParams
        }

        return UserManager.shared.registerSocialUser(name: name!, phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, referralObject: referralObject, completion: { [weak self] (response) in
            self?.registrationResponse = response
            completion(response)
            }, failure: failure)
    }

    /// API call to  verify the OTP sent to the user's phone number during registration, this function should be called only when the callback response message from registration is "User has successfully been registered."
    ///
    /// - Parameters:
    ///   - otp: The OTP sent to the user's phone number during a new social login user registration
    ///   - completion: `APICompletion` with `RegistrationResponse`, otp has been verified successfully if the success varialble is true
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func verifyRegOTP(otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(!(verifyPhoneResponse!.message == "otp_sent"), "User phone no has been registerd previously should use method verifySocialOTP")
        assert(verifyPhoneResponse!.message == "new_registration_required" && registrationResponse != nil, "User should be registered first with method registerSocialUser")
        
        return UserManager.shared.verifyRegOTP(phone: phone!, otp: otp, completion: completion, failure: failure)
    }

    /// API call the resend the OTP to the phone number passed in the registerSocialUser api call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `RegistrationResponse`, a true value for the success variable indicates that the OTP has been resent
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func resendRegOTP(completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(!(verifyPhoneResponse!.message == "otp_sent"), "User phone no has been registerd previously should use method resendSocialOTP")
        assert(verifyPhoneResponse!.message == "new_registration_required" && registrationResponse != nil, "User should be registered first with method resendSocialOTP")
        return UserManager.shared.resendOTP(phone: phone!, completion: completion, failure: failure)
    }
    
    /// API call to verify the OTP sent to the user's phone number during `verifyPhone(...) api call, this function can be used for all the case where the message is other than "new_registration_required"
    ///
    /// - Parameters:
    ///   - otp: the OTP sent to the user's phone number during after the verifyPhone call
    ///   - completion: `APICompletion` with `SocialLoginResponse`, otp has been verified successfully if the success varialble is true
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func verifySocialOTP(otp: String, completion: @escaping ((SocialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(verifyPhoneResponse!.message == "otp_sent", "This is a new registration verifyRegOTP method should be called")
        return UserManager.shared.verifySocialOTP(phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, otp: otp, completion: completion, failure: failure)
    }
    
    /// API call to resend the OTP to the phone number passed in the `verifyPhone(...)`, api call, this function can be used for all the case where the message is other than "new_registration_required"
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `SocialLoginResponse`, a true value for the success variable indicates that the OTP has been resent
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func resendSocialOTP(completion: @escaping ((SocialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(verifyPhoneResponse != nil && verifyPhoneResponse!.message == "otp_sent", "This is a new registration resendRegOTP method should be called")
        return UserManager.shared.verifyPhone(phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, completion: completion, failure: failure)
    }

}
