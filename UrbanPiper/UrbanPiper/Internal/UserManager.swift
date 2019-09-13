//
//  UserManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit
import RxSwift
//import FirebaseInstanceID

//@objc internal protocol UserManagerDelegate {
//    
//    @objc optional func userInfoChanged()
//    @objc optional func userBizInfoChanged()
//}

public struct Simpl {
    public let isAuthorized: Bool
    public let isFirstTransaction: Bool
    public let buttonText: String?
    public let error: Error?
    
    public init(isAuthorized: Bool, isFirstTransaction: Bool, buttonText: String?, error: Error?) {
        self.isAuthorized = isAuthorized
        self.isFirstTransaction = isFirstTransaction
        self.buttonText = buttonText
        self.error = error
    }
}

internal typealias CompletionHandler<T> = (T?, UPError?) -> Void

internal class UserManager: NSObject {

    private struct KeychainAppUserKeys {
        static let AppUserKey: String = "KeyChainUserDataKey"
        static let UserBizInfoKey: String = "KeyChainBizInfoKey"
    }
    
//    private typealias WeakRefDataModelDelegate = WeakRef<UserManagerDelegate>

    @objc internal static private(set) var shared: UserManager = UserManager()

//    private var observers = [WeakRefDataModelDelegate]()
    
    private static let keychain: UPKeychainWrapper = UPKeychainWrapper(serviceName: Bundle.main.bundleIdentifier!)
    
    @objc internal private(set) var currentUser: User? {
        get {
            guard let userData = UserManager.keychain.data(forKey: KeychainAppUserKeys.AppUserKey) else { return nil}

            User.registerClass()
            Meta.registerClass()
            UserBizInfo.registerClass()
            UserBizInfo.registerClass(name: "UserBizInfo")
            UserBizInfo.registerClass(name: "BizObject")
            UserBizInfoResponse.registerClass()
            UserBizInfoResponse.registerClass(name: "BizInfo")
            JWT.registerClass()
            
            let obj = NSKeyedUnarchiver.unarchiveObject(with: userData)
            guard let user: User = obj as? User else { return nil }
            return user
        }
        set {
            defer {
                APIManager.shared.jwt = currentUser?.jwt
                
                DispatchQueue.main.async { [weak self] in
                    NotificationCenter.default.post(name: NSNotification.Name.userInfoChanged, object: nil)
//                    guard let manager = self else { return }
//                    manager.observers = manager.observers.filter { $0.value != nil }
//                    let _ = manager.observers.map { $0.value?.userInfoChanged?() }
                }
            }
            
            if let user = newValue {
                let isNewLogin = currentUser == nil
                saveToKeyChain(user: user)
                
                guard isNewLogin else { return }
                    DispatchQueue.main.async { [weak self] in
                        self?.refreshUserInfo(completion: nil)
                        self?.refreshUserBizInfo(completion: nil)
                    }
            } else {
                UserManager.keychain.removeObject(forKey: KeychainAppUserKeys.AppUserKey)
                URLCache.shared.removeAllCachedResponses()
                
                let cookieStore = HTTPCookieStorage.shared
                for cookie in cookieStore.cookies ?? [] {
                    cookieStore.deleteCookie(cookie)
                }
            }
        }
    }
    
    func saveToKeyChain(user: User) {
        let userData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserManager.keychain.set(userData, forKey: KeychainAppUserKeys.AppUserKey)
    }
    
    internal override init() {
        super.init()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.logout),
                                               name: .sessionExpired, object: nil)

        if !SharedPreferences.isNotFirstLaunch {
            // Remove Keychain items here
            
            // Update the flag indicator
            SharedPreferences.isNotFirstLaunch = true
            DispatchQueue.main.async { [weak self] in
                self?.logout()
            }
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.loginUserWithJWT()
        }
        
    }
    
//    @objc internal func addObserver(delegate: UserManagerDelegate) {
//        let weakRefDataModelDelegate: WeakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
//        observers.append(weakRefDataModelDelegate)
//    }
//    
//    
//    internal func removeObserver(delegate: UserManagerDelegate) {
//        guard let index = (observers.index { $0.value === delegate }) else { return }
//        observers.remove(at: index)
//    }
    
    func loginUserWithJWT() {
        guard let appUser = currentUser else { return }
        guard appUser.jwt == nil else {
            refreshToken()
            return
        }
        
        if let provider = appUser.provider {
            let upAPI = SocialAuthAPI.socialLogin(email: appUser.email, accessToken: appUser.accessToken!, socialLoginProvider: provider)
            let _ = APIManager.shared.apiDataTask(upAPI: upAPI, completion:
                { [weak self] (socialLoginResponse) in
                    guard let token = socialLoginResponse?.token else { return }
                    let user = User(jwtToken: token)
                    self?.currentUser = user
                    
                } as APICompletion<SocialLoginResponse>, failure: { [weak self] error in
                    guard let msg = error?.errorMessage, msg == "email_check_failed" else { return }
                    self?.logout()
            })
        } else {
            logout()
        }
    }
    
    func refreshToken() {
        guard let jwt = currentUser?.jwt else { return }
        guard !jwt.tokenExpired else {
            NotificationCenter.default.post(name: .sessionExpired, object: nil)
            UrbanPiper.sharedInstance().callback(.sessionExpired)
            return
        }
        guard jwt.shouldRefreshToken else { return }
        
        let upAPI = AuthAPI.refreshToken(token: jwt.token)
        let _ = APIManager.shared.apiDataTask(upAPI: upAPI, completion: { [weak self] (refreshTokenResponse) in
            guard let token = refreshTokenResponse?.token else { return }
            let user = self?.currentUser?.update(fromJWTToken: token)
            self?.currentUser = user
        } as APICompletion<RefreshTokenResponse>, failure: nil)
    }
    
    @objc internal func logout() {
        if let user = UserManager.shared.currentUser, user.phone != nil {
            AnalyticsManager.shared.track(event: .logout(phone: user.phone))
        }

        CartManager.shared.clearCart()

        UserManager.keychain.removeObject(forKey: KeychainAppUserKeys.AppUserKey)
        UserManager.keychain.removeObject(forKey: KeychainAppUserKeys.UserBizInfoKey)
        
        currentUser = nil
    }
    
}

//  MARK: API Calls

extension UserManager {
    
    @objc @discardableResult internal func refreshUserInfo(completion: APICompletion<UserInfoResponse>? = nil,
                                      failure: APIFailure? = nil) -> URLSessionDataTask? {
        guard let phoneNo = currentUser?.phone else {
            failure?(nil)
            return nil
        }
        
        let upAPI = UserAPI.userData(phone: phoneNo)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: { [weak self] (response) in
            guard let responseObject = response else { return }
            
            let user = self?.currentUser?.update(fromDictionary: responseObject.toDictionary())
            self?.currentUser = user
            
            completion?(response)
        } as APICompletion<UserInfoResponse> , failure: failure)
    }
    
    internal func refreshUserInfo() -> Observable<UserInfoResponse>? {
        guard let phoneNo = currentUser?.phone else { return nil }
        
        let upAPI = UserAPI.userData(phone: phoneNo)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (userInfoResponse) in
                
                let user = self?.currentUser?.update(fromDictionary: userInfoResponse.toDictionary())
                self?.currentUser = user
                
            })
        
    }
    
    @objc @discardableResult internal func updateUserInfo(name: String,
                                                        phone: String,
                                                        email: String,
                                                        gender: String? = nil,
                                                        aniversary: Date? = nil,
                                                        birthday: Date? = nil,
                                                        completion: APICompletion<UserInfoUpdateResponse>?,
                                                        failure: APIFailure?) -> URLSessionDataTask? {
        let upAPI = UserAPI.updateUserData(name: name, phone: phone, email: email, gender: gender, aniversary: aniversary, birthday: birthday)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion:
            { [weak self] (response) in
                AnalyticsManager.shared.track(event: .profileUpdated(phone: phone, pwdChanged: false))
                guard let responseObject = response, responseObject.success else { return }
                
                self?.updateCurrentUserInfo(name: name, phone: phone, email: email,
                                            gender: gender, aniversary: aniversary, birthday: birthday)
                
                completion?(response)
            } as APICompletion<UserInfoUpdateResponse> , failure: failure)
    }
    
    internal func updateUserInfo(name: String,
                                 phone: String,
                                 email: String,
                                 gender: String? = nil,
                                 aniversary: Date? = nil,
                                 birthday: Date? = nil) -> Observable<UserInfoUpdateResponse> {
        let upAPI = UserAPI.updateUserData(name: name, phone: phone, email: email, gender: gender, aniversary: aniversary, birthday: birthday)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (userInfoUpdateResponse) in
                AnalyticsManager.shared.track(event: .profileUpdated(phone: phone, pwdChanged: false))
                guard userInfoUpdateResponse.success else { return }
                self?.updateCurrentUserInfo(name: name, phone: phone, email: email,
                                            gender: gender, aniversary: aniversary, birthday: birthday)
            })
    }
    
    private func updateCurrentUserInfo(name: String,
                                       phone: String,
                                       email: String,
                                       gender: String? = nil,
                                       aniversary: Date? = nil,
                                       birthday: Date? = nil) {
        let user = currentUser
        
        user?.firstName = name
        user?.phone = phone
        user?.email = email
        if gender != nil {
            user?.gender = gender
        }
        if aniversary != nil {
            user?.anniversary = Int(aniversary!.timeIntervalSince1970 * 1000)
        }
        if birthday != nil {
            user?.birthday = Int(birthday!.timeIntervalSince1970 * 1000)
        }
        
        currentUser = user
    }
    
    
    
    @objc @discardableResult internal func changePassword(phone: String,
                               oldPassword: String,
                               newPassword: String,
                               completion: APICompletion<GenericResponse>?,
                               failure: APIFailure?) -> URLSessionDataTask? {
        guard currentUser != nil else { return nil }
        
        let upAPI = UserAPI.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion:
            { (genericResponse) in
                AnalyticsManager.shared.track(event: .profileUpdated(phone: phone, pwdChanged: true))
                completion?(genericResponse)
            } as APICompletion<GenericResponse>, failure: failure)
    }
    
    internal func changePassword(phone: String,
                                 oldPassword: String,
                                 newPassword: String) -> Observable<GenericResponse>? {
        guard currentUser != nil else { return nil }
        let upAPI = UserAPI.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribeOn(MainScheduler.instance)
            .do(onNext: { _ in
                AnalyticsManager.shared.track(event: .profileUpdated(phone: phone, pwdChanged: true))
            })
        
    }
    
    @objc @discardableResult internal func refreshUserBizInfo(completion: APICompletion<UserBizInfoResponse>? = nil, failure: APIFailure? = nil) -> URLSessionDataTask? {
        guard currentUser != nil else { return nil }
        
        let upAPI = UserBizInfoAPI.userBizInfo
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion:
            { [weak self] (info) in
            guard let user = self?.currentUser else { return }
            user.userBizInfoResponse = info
            
            self?.saveToKeyChain(user: user)
            AnalyticsManager.shared.track(event: .bizInfoUpdated)
            NotificationCenter.default.post(name: NSNotification.Name.userBizInfoChanged, object: nil)

            completion?(info)
        } as APICompletion<UserBizInfoResponse> , failure: failure)
    }
    
    internal func refreshUserBizInfo() -> Observable<UserBizInfoResponse>? {
        guard currentUser != nil else { return nil }

        let upAPI = UserBizInfoAPI.userBizInfo
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (userBizInfoResponse) in
                guard let user = self?.currentUser else { return }
                user.userBizInfoResponse = userBizInfoResponse
                
                self?.saveToKeyChain(user: user)
                AnalyticsManager.shared.track(event: .bizInfoUpdated)
                NotificationCenter.default.post(name: NSNotification.Name.userBizInfoChanged, object: nil)
        })
    }
}

//  MARK: FCM

extension UserManager {
    
    @discardableResult internal func registerForFCMMessaging(token: String, completion: APICompletion<GenericResponse>? = nil,
        failure: APIFailure? = nil) -> URLSessionDataTask {
        let upAPI = FCMAPI.registerForFCM(token: token)
        
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: nil as APICompletion<GenericResponse>?, failure: nil)
    }
    
    internal func registerForFCMMessaging(token: String) -> Observable<GenericResponse> {
        let upAPI = FCMAPI.registerForFCM(token: token)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

}

//  MARK: Normal Auth

extension UserManager {
    
    @discardableResult internal func login(phone: String,
                      password: String,
                      completion: @escaping APICompletion<LoginResponse>,
                      failure: @escaping APIFailure) -> URLSessionDataTask {
        
        let upAPI = AuthAPI.login(phone: phone, password: password)
        
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion:
            { [weak self] (loginResponse) in
                if let token = loginResponse?.token {
                    let user = User(jwtToken: token)
                    self?.currentUser = user
                    AnalyticsManager.shared.track(event: .loginSuccess(phone: phone))
                } else {
                    AnalyticsManager.shared.track(event: .loginFailed(phone: phone))
                }
                completion(loginResponse)
            } as APICompletion<LoginResponse>) { (error) in
                AnalyticsManager.shared.track(event: .loginFailed(phone: phone))
                failure(error)
        }
    }
    
    internal func login(phone: String,
                        password: String) -> Observable<LoginResponse> {
        let upAPI = AuthAPI.login(phone: phone, password: password)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (loginResponse) in
                if let token = loginResponse.token {
                    let user = User(jwtToken: token)
                    self?.currentUser = user
                    AnalyticsManager.shared.track(event: .loginSuccess(phone: phone))
                } else {
                    AnalyticsManager.shared.track(event: .loginFailed(phone: phone))
                }
            }, onError: { (error) in
                AnalyticsManager.shared.track(event: .loginFailed(phone: phone))
            })
    }
    
    @discardableResult internal func forgotPassword(phone: String,
                               completion: @escaping APICompletion<GenericResponse>,
                               failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = AuthAPI.forgotPassword(phone: phone)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }
    
    func forgotPassword(phone: String) -> Observable<GenericResponse> {
        let upAPI = AuthAPI.forgotPassword(phone: phone)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
    
    @discardableResult internal func resetPassword(phone: String,
                              otp: String,
                              password: String,
                              confirmPassword: String,
                              completion: @escaping ((GenericResponse?)-> Void),
                              failure: @escaping APIFailure) -> URLSessionDataTask {
        AnalyticsManager.shared.track(event: .passwordReset(phone: phone))
        let upAPI = AuthAPI.resetPassword(phone: phone, otp: otp, password: password, confirmPassword: confirmPassword)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }
    
    internal func resetPassword(phone: String,
                                otp: String,
                                password: String,
                                confirmPassword: String) -> Observable<GenericResponse> {
        AnalyticsManager.shared.track(event: .passwordReset(phone: phone))
        let upAPI = AuthAPI.resetPassword(phone: phone, otp: otp, password: password, confirmPassword: confirmPassword)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
    
    @discardableResult internal func registerUser(name: String,
                              phone: String,
                              email: String,
                              password: String,
                              referralObject: Referral?,
                              completion: @escaping (RegistrationResponse?) -> Void,
                              failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = AuthAPI.registerUser(name: name, phone: phone, email: email, password: password, referral: referralObject)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }
    
    internal func registerUser(name: String,
                               phone: String,
                               email: String,
                               password: String,
                               referral: Referral?) -> Observable<RegistrationResponse> {
        let upAPI = AuthAPI.registerUser(name: name, phone: phone, email: email, password: password, referral: referral)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
    
}

//  MARK: Social Auth

extension UserManager {
    
    @discardableResult internal func registerSocialUser(name: String,
                                          phone: String,
                                          email: String,
                                          gender: String? = nil,
                                          socialLoginProvider: SocialLoginProvider,
                                          accessToken: String,
                                          referralObject: Referral?,
                                          completion: @escaping APICompletion<RegistrationResponse>,
                                          failure: @escaping APIFailure) -> URLSessionDataTask {
        AnalyticsManager.shared.track(event: .socialAuthSignupStart(phone: phone, platform: socialLoginProvider.rawValue))
        let upAPI = AuthAPI.createSocialUser(name: name, phone: phone, email: email, gender: gender, accessToken: accessToken, referral: referralObject)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }
    
    internal func registerSocialUser(name: String,
                                     phone: String,
                                     email: String,
                                     gender: String? = nil,
                                     socialLoginProvider: SocialLoginProvider,
                                     accessToken: String,
                                     referral: Referral?) -> Observable<RegistrationResponse> {
        AnalyticsManager.shared.track(event: .socialAuthSignupStart(phone: phone, platform: socialLoginProvider.rawValue))
        let upAPI = AuthAPI.createSocialUser(name: name, phone: phone, email: email, gender: gender, accessToken: accessToken, referral: referral)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
    
    @discardableResult internal func socialLogin(email: String,
                            socialLoginProvider: SocialLoginProvider,
                            accessToken: String,
                            completion: @escaping APICompletion<SocialLoginResponse>,
                            failure: @escaping APIFailure) -> URLSessionDataTask {
        
        let upAPI = SocialAuthAPI.socialLogin(email: email, accessToken: accessToken, socialLoginProvider: socialLoginProvider)
        
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion:
            { [weak self] (socialLoginResponse) in
                if let token = socialLoginResponse?.token {
                    let user = User(jwtToken: token)
                    self?.currentUser = user
                }
                completion(socialLoginResponse)
            } as APICompletion<SocialLoginResponse>, failure: failure)
    }

    internal func socialLogin(email: String,
                              socialLoginProvider: SocialLoginProvider,
                              accessToken: String) -> Observable<SocialLoginResponse> {
        let upAPI = SocialAuthAPI.socialLogin(email: email, accessToken: accessToken, socialLoginProvider: socialLoginProvider)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (socialLoginResponse) in
                guard let token = socialLoginResponse.token else { return }
                let user = User(jwtToken: token)
                self?.currentUser = user
            })
    }
    
}


//  MARK: Mobile Verification

extension UserManager {
    
    @discardableResult internal func verifyPhone(phone: String,
                                                 email: String,
                                                 socialLoginProvider: SocialLoginProvider,
                                                 accessToken: String,
                                                 completion: @escaping APICompletion<SocialLoginResponse>,
                                                 failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = SocialAuthAPI.verifyPhone(phone: phone,
                                              email: email,
                                              accessToken: accessToken,
                                              socialLoginProvider: socialLoginProvider)
        
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }
    
    internal func verifyPhone(phone: String,
                              email: String,
                              socialLoginProvider: SocialLoginProvider,
                              accessToken: String) -> Observable<SocialLoginResponse> {
        let upAPI = SocialAuthAPI.verifyPhone(phone: phone,
                                              email: email,
                                              accessToken: accessToken,
                                              socialLoginProvider: socialLoginProvider)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
    
//  used only when "new_registration_required"
    @discardableResult internal func verifyRegOTP(phone: String,
                                   otp: String,
                                   completion: @escaping APICompletion<RegistrationResponse>,
                                   failure: @escaping APIFailure) -> URLSessionDataTask {
        
        let upAPI = AuthAPI.verifyRegOTP(phone: phone, pin: otp)
        
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion:
            { [weak self] (registrationResponse) in
                if let token = registrationResponse?.token {
                    self?.currentUser = User(jwtToken: token)
                }
                completion(registrationResponse)
            } as APICompletion<RegistrationResponse>, failure: failure)
    }
    
    internal func verifyRegOTP(phone: String,
                               otp: String) -> Observable<RegistrationResponse> {
        let upAPI = AuthAPI.verifyRegOTP(phone: phone, pin: otp)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (registrationResponse) in
                
                guard let token = registrationResponse.token else { return }
                self?.currentUser = User(jwtToken: token)
            })
        
    }
    
//  used in all the other cases
    @discardableResult internal func verifySocialOTP(phone: String,
                          email: String,
                          socialLoginProvider: SocialLoginProvider,
                          accessToken: String,
                          otp: String,
                          completion: @escaping APICompletion<SocialLoginResponse>,
                          failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = SocialAuthAPI.verifySocialOTP(phone: phone, email: email, accessToken: accessToken, socialLoginProvider: socialLoginProvider, otp: otp)
        
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion:
            { [weak self] (socialLoginResponse) in
                if let token = socialLoginResponse?.token {
                    let user = User(jwtToken: token)
                    self?.currentUser = user
                }
                completion(socialLoginResponse)
            } as APICompletion<SocialLoginResponse>, failure: failure)
    }
    
    internal func verifySocialOTP(phone: String,
                                  email: String,
                                  socialLoginProvider: SocialLoginProvider,
                                  accessToken: String,
                                  otp: String) -> Observable<SocialLoginResponse> {
        let upAPI = SocialAuthAPI.verifySocialOTP(phone: phone, email: email, accessToken: accessToken, socialLoginProvider: socialLoginProvider, otp: otp)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (socialLoginResponse) in
                guard let token = socialLoginResponse.token else { return }
                self?.currentUser = User(jwtToken: token)
            })
    }
    
    @discardableResult internal func resendOTP(phone: String,
                   completion: @escaping APICompletion<RegistrationResponse>,
                   failure: @escaping APIFailure) -> URLSessionDataTask {
        AnalyticsManager.shared.track(event: .resendOTP(phone: phone))
        let upAPI = AuthAPI.resendOTP(phone: phone)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }
    
    internal func resendOTP(phone: String) -> Observable<RegistrationResponse> {
        AnalyticsManager.shared.track(event: .resendOTP(phone: phone))
        let upAPI = AuthAPI.resendOTP(phone: phone)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
}
