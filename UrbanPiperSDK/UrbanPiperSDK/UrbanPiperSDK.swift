//
//  UrbanPiperSDK.swift
//  UrbanPiperSDK
//
//  Created by Vid on 24/10/18.
//

import UIKit

public class UrbanPiperSDK: NSObject {

    @objc public static private(set) var shared: UrbanPiperSDK!
    
    private init(language: Language = .english, bizId: String, apiUsername: String, apiKey: String) {
        super.init()
        APIManager.initializeManager(language: language, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, jwt: UserManager.shared.currentUser?.jwt)
    }
    
    public class func intialize(language: Language? = .english, bizId: String, apiUsername: String, apiKey: String) {
        shared = UrbanPiperSDK(language: language!, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey)
    }
    
    public func change(language: Language) {
        APIManager.shared.language = language
    }

}

//  MARK: User Methods

public extension UrbanPiperSDK {

    func getUser() -> User? {
        return UserManager.shared.currentUser
    }
    
    func getUserBizInfo() -> BizInfo? {
        return UserManager.shared.bizInfo
    }
    
    @discardableResult public func refreshUserData(completion: ((UserInfoResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserData(completion: completion, failure: failure)
    }
    
    @discardableResult public func updateUserInfo(name: String, phone: String, email: String, gender: String?, anniversary: Date?, birthday: Date?, completion: ((UserInfoUpdateResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        return UserManager.shared.updateUserInfo(name: name, phone: phone, email: email, gender: gender, completion: completion, failure: failure)
    }
    
    @discardableResult public func changePassword(phone: String, oldPassword: String, newPassword: String, completion: ((GenericResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword, completion: completion, failure: failure)
    }
    
    @discardableResult public func updateUserBizInfo(completion: ((BizInfo?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.updateUserBizInfo(completion: completion, failure: failure)
    }

}

//  MARK: Login

extension UrbanPiperSDK {
    
    @discardableResult public func login(username: String, password: String, completion: @escaping ((LoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.login(username: username, password: password, completion: completion, failure: failure)
    }
    
    @discardableResult public func socialLogin(email: String, socialLoginProvider: SocialLoginProvider, accessToken: String, completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.socialLogin(email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, completion: completion, failure: failure)
    }

}


//  MARK: Account Creation

extension UrbanPiperSDK {
 
    @discardableResult public func registerUser(name: String, phone: String, email: String, password: String, referralObject: Referral?, completion: @escaping (RegistrationResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.registerUser(name: name, phone: phone, email: email, password: password, referralObject: referralObject, completion: completion, failure: failure)
    }
    
    @discardableResult public func registerSocialUser(name: String, phone: String, email: String, gender: String?, socialLoginProvider: SocialLoginProvider, accessToken: String, referralObject: Referral?, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.registerSocialUser(name: name, phone: phone, email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, referralObject: referralObject, completion: completion, failure: failure)
    }

    @discardableResult public func verifyPhone(phone: String, email: String, socialLoginProvider: SocialLoginProvider, accessToken: String, completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.verifyPhone(phone: phone, email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, completion: completion, failure: failure)
    }

}

//  MARK: Registration OTP

extension UrbanPiperSDK {
    
    @discardableResult public func verifyPhone(_ phone: String, otp: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.verifyPhone(phone, otp: otp, completion: completion, failure: failure)
    }
    
    @discardableResult public func verifySocialOTP(phone: String, email: String, socialLoginProvider: SocialLoginProvider, accessToken: String, otp: String, completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.verifySocialOTP(phone: phone, email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, otp: otp, completion: completion, failure: failure)
    }
    
    @discardableResult public func resendOTP(phone: String, completion: @escaping ((RegistrationResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.resendOTP(phone: phone, completion: completion, failure: failure)
    }
    
}

//  MARK: Forgot Password

extension UrbanPiperSDK {
    
    @discardableResult public func forgotPassword(phone: String, completion: @escaping (GenericResponse?) -> Void, failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.forgotPassword(phone: phone, completion: completion, failure: failure)
    }
    
    @discardableResult public func resetPassword(phone: String, otp: String, password: String, confirmPassword: String, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.resetPassword(phone: phone, otp: otp, password: password, confirmPassword: confirmPassword, completion: completion, failure: failure)
    }
    
}

//  MARK: FCM

extension UrbanPiperSDK {
    
    @discardableResult public func registerForFCMMessaging(token: String, completion: (([String: Any]?) -> Void)? = nil,
                                                           failure: APIFailure? = nil) -> URLSessionDataTask {
        return UserManager.shared.registerForFCMMessaging(token: token, completion: completion, failure: failure)
    }
    
    @discardableResult public func unRegisterForFCMMessaging(token: String, completion: (([String: Any]?) -> Void)? = nil,
                                                             failure: APIFailure? = nil) -> URLSessionDataTask {
        return UserManager.shared.unRegisterForFCMMessaging(token: token, completion: completion, failure: failure)
    }
}

