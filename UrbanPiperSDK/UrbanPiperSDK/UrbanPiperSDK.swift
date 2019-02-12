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
    
    func startRegistration(phone: String) -> RegistrationBuilder {
        return RegistrationBuilder(phone: phone)
    }
    
    func startSocialRegistration() -> SocialRegBuilder {
        return SocialRegBuilder()
    }
    
    func startPasswordReset() -> ResetPasswordBuilder {
        return ResetPasswordBuilder()
    }

    func getUser() -> User? {
        return UserManager.shared.currentUser
    }
    
    func logout() {
        UserManager.shared.logout()
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
    
    @discardableResult public func getDeliverableAddresses(locationId: Int, completion: ((UserAddressesResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.userSavedDeliverableAddresses(locationId: locationId, completion: completion, failure: failure)
    }

    @discardableResult public func addAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.addAddress(address: address, completion: completion, failure: failure)
    }
    
    @discardableResult public func updateAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.updateAddress(address: address, completion: completion, failure: failure)
    }
    
    @discardableResult public func deleteAddress(addressId: Int, completion: ((GenericResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.deleteAddress(addressId: addressId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getWalletTransactions(addressId: Int, completion: ((WalletTransactionResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchWalletTransactions(completion: completion, failure: failure)
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

//  MARK: FCM

extension UrbanPiperSDK {
    
    @discardableResult public func registerForFCMMessaging(token: String, completion: ((GenericResponse?) -> Void)? = nil,
                                                           failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.registerForFCMMessaging(token: token, completion: completion, failure: failure)
    }
    
    @discardableResult public func unRegisterForFCMMessaging(token: String, completion: ((GenericResponse?) -> Void)? = nil,
                                                             failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.unRegisterForFCMMessaging(token: token, completion: completion, failure: failure)
    }
}

