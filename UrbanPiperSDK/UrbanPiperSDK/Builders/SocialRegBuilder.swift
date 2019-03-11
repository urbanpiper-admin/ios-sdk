//
//  SocialRegBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

/// A helper class that contains the related api's to register a social login user.
/// - verifyPhone(name:phone:email:gender:provider:providerAccessToken:completion:failure), function to verify the phone number provided by an unregistered social login user, sends an OTP to the phone number passed in on success, if the message is "new_registration_required" the user has be registered using the registerSocialUser(completion:failure:) call, if the message is "otp_sent" the users phone number is already present in the system and the phone number needs to be verified by the verifySocialOTP(otp:completion:failure) call
/// - registerSocialUser(completion:failure:), function to register a new social login user if the message value in verifyPhone response is "new_registration_required"
/// - verifyRegOTP(paymentOption), function to verify the phone number passed in by the user if the message value in verifyPhone response is "new_registration_required"
/// - resendRegOTP(completion:failure:), function to resend a new otp to the users phone number passed in by the user if the message value in verifyPhone response is "new_registration_required"
/// - verifySocialOTP(otp:completion:failure:), function to verify the phone number passed in by the user if the message value in verifyPhone response is "otp_sent"
/// - resendSocialOTP(completion:failure:), function to resend a new otp to the users phone number passed in by the user if the message value in verifyPhone response is "otp_sent"

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
    ///   - name: the name of the user from the social login provider
    ///   - phone: the phone number entered by the user
    ///   - email: the email id of the user from the social login provider
    ///   - gender: Optional. the gender value from the social login provider
    ///   - provider: the social login provider from which the data is from (i.e google, facebook etc.)
    ///   - providerAccessToken: the access token provided by the social login provider
    ///   - completion: success callback with SocialLoginResponse, if the message value is "new_registration_required" the user has to be registered using registerSocialUser(completion:failure:), if the message value is "otp_sent" the users phone number is already present in the system and it needs to be verified by calling verifySocialOTP(otp:completion:failure:)
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
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

    /// Funtion to register a new social login user
    ///
    /// - Parameters:
    ///   - completion: success callback with RegistrationResponse, sends an otp to the passed in phone number, user is registered successfully if the success var is true, for a new user registration to verify the OTP the function verifyRegOTP should be called, and to resend the OTP the resendRegOTP should be called
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
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

    /// API call to  verify the OTP sent to the users phone number during registration, this function should be called only when the callback response message from registration is "User has successfully been registered."
    ///
    /// - Parameters:
    ///   - otp: the OTP sent to the users phone number during a new social login user registration
    ///   - completion: success callback with RegistrationResponse, otp has been verified successfully if the success varialble is true
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func verifyRegOTP(otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(!(verifyPhoneResponse!.message == "otp_sent"), "User phone no has been registerd previously should use method verifySocialOTP")
        assert(verifyPhoneResponse!.message == "new_registration_required" && registrationResponse != nil, "User should be registered first with method registerSocialUser")
        
        return UserManager.shared.verifyRegOTP(phone: phone!, otp: otp, completion: completion, failure: failure)
    }

    /// API call the resend the OTP to the phone number passed in the registerSocialUser api call
    ///
    /// - Parameters:
    ///   - completion: success callback with RegistrationResponse, a true value for the success variable indicates that the OTP has been resent
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func resendRegOTP(completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(!(verifyPhoneResponse!.message == "otp_sent"), "User phone no has been registerd previously should use method resendSocialOTP")
        assert(verifyPhoneResponse!.message == "new_registration_required" && registrationResponse != nil, "User should be registered first with method resendSocialOTP")
        return UserManager.shared.resendOTP(phone: phone!, completion: completion, failure: failure)
    }
    
    /// API call to  verify the OTP sent to the users phone number during verifyPhone api call, this function can be used for all the case other than "new_registration_required"
    ///
    /// - Parameters:
    ///   - otp: the OTP sent to the users phone number during after the verifyPhone call
    ///   - completion: success callback with SocialLoginResponse, otp has been verified successfully if the success varialble is true
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func verifySocialOTP(otp: String, completion: @escaping ((SocialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(verifyPhoneResponse!.message == "otp_sent", "This is a new registration verifyRegOTP method should be called")
        return UserManager.shared.verifySocialOTP(phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, otp: otp, completion: completion, failure: failure)
    }
    
    /// API call the resend the OTP to the phone number passed in the verifyPhone api call, this function can be used for all the case other than "new_registration_required"
    ///
    /// - Parameters:
    ///   - completion: success callback with SocialLoginResponse, a true value for the success variable indicates that the OTP has been resent
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func resendSocialOTP(completion: @escaping ((SocialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(verifyPhoneResponse != nil && verifyPhoneResponse!.message == "otp_sent", "This is a new registration resendRegOTP method should be called")
        return UserManager.shared.verifyPhone(phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, completion: completion, failure: failure)
    }

}
