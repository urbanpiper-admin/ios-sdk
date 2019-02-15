//
//  SocialRegBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

public class SocialRegBuilder: NSObject {
    
    public private(set) var name: String?
    public private(set) var phone: String?
    public private(set) var email: String?
    public private(set) var gender: String?
    public private(set) var provider: SocialLoginProvider?
    public private(set) var providerAccessToken: String?

    private var verifyPhoneResponse: socialLoginResponse?
    private var registrationResponse: RegistrationResponse?

    internal override init() {
    }

    @discardableResult public func verifyPhone(name: String, phone: String, email: String, gender: String?, provider: SocialLoginProvider, providerAccessToken: String, completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
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

    @discardableResult public func registerSocialUser(completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        return UserManager.shared.registerSocialUser(name: name!, phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, referralObject: nil, completion: { [weak self] (response) in
            self?.registrationResponse = response
            completion(response)
            }, failure: failure)
    }

    @discardableResult public func verifyRegOTP(otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(!(verifyPhoneResponse!.message == "otp_sent"), "User phone no has been registerd previously should use method verifySocialOTP")
        assert(verifyPhoneResponse!.message == "new_registration_required" && registrationResponse != nil, "User should be registered first with method registerSocialUser")
        
        return UserManager.shared.verifyRegOTP(phone: phone!, otp: otp, completion: completion, failure: failure)
    }

    @discardableResult public func resendRegOTP(completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(!(verifyPhoneResponse!.message == "otp_sent"), "User phone no has been registerd previously should use method resendSocialOTP")
        assert(verifyPhoneResponse!.message == "new_registration_required" && registrationResponse != nil, "User should be registered first with method resendSocialOTP")
        return UserManager.shared.resendOTP(phone: phone!, completion: completion, failure: failure)
    }
    
    @discardableResult public func verifySocialOTP(otp: String, completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(verifyPhoneResponse!.message == "otp_sent", "This is a new registration verifyRegOTP method should be called")
        return UserManager.shared.verifySocialOTP(phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, otp: otp, completion: completion, failure: failure)
    }
    
    @discardableResult public func resendSocialOTP(completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        assert(verifyPhoneResponse != nil, "verifyPhone method should be called first")
        assert(verifyPhoneResponse != nil && verifyPhoneResponse!.message == "otp_sent", "This is a new registration resendRegOTP method should be called")
        return UserManager.shared.verifyPhone(phone: phone!, email: email!, socialLoginProvider: provider!, accessToken: providerAccessToken!, completion: completion, failure: failure)
    }

}
