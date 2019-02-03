//
//  AppUserDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit
import FirebaseInstanceID

@objc public protocol AppUserDataModelDelegate {
    
    @objc optional func userInfoChanged()
    @objc optional func userBizInfoChanged()
}

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

public typealias CompletionHandler<T> = (T?, UPError?) -> Void

public class AppUserDataModel: UrbanPiperDataModel {

    private struct KeychainAppUserKeys {
        static let AppUserKey: String = "KeyChainUserDataKey"
        static let BizInfoKey: String = "KeyChainBizInfoKey"
    }
    
    private typealias WeakRefDataModelDelegate = WeakRef<AppUserDataModelDelegate>

    @objc public static private(set) var shared: AppUserDataModel = AppUserDataModel()

    private var observers = [WeakRefDataModelDelegate]()
    
    private static let keychain: UPKeychainWrapper = UPKeychainWrapper(serviceName: Bundle.main.bundleIdentifier!)
    
    @objc public private(set) var appUserData: User? {
        get {
            guard let userData = AppUserDataModel.keychain.data(forKey: KeychainAppUserKeys.AppUserKey) else { return nil}
            Meta.registerClassNameWhiteLabel()
            Meta.registerClassNameUrbanPiperSDK()
            BizObject.registerClassNameWhiteLabel()
            BizObject.registerClassNameUrbanPiperSDK()
            BizInfo.registerClassNameWhiteLabel()
            BizInfo.registerClassNameUrbanPiperSDK()

            User.registerClassName()
            let obj = NSKeyedUnarchiver.unarchiveObject(with: userData)
            guard let user: User = obj as? User else { return nil }
            return user
        }
        set {
            defer {
                APIManager.shared.updateHeaders(jwt: validAppUserData?.jwt)
                
                DispatchQueue.main.async { [weak self] in
                    if newValue != nil {
                        self?.registerForFCMMessaging()
                    } else {
                        self?.unRegisterForFCMMessaging()
                    }
                }
            }
            
            if let user = newValue {
                if appUserData == nil {
                    defer {
                        refreshUserData()
                    }
                }
                
                let userData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
                AppUserDataModel.keychain.set(userData, forKey: KeychainAppUserKeys.AppUserKey)
                observers = observers.filter { $0.value != nil }
                let _ = observers.map { $0.value?.userInfoChanged?() }
            } else {
                AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.AppUserKey)
                URLCache.shared.removeAllCachedResponses()
                
                let cookieStore = HTTPCookieStorage.shared
                for cookie in cookieStore.cookies ?? [] {
                    cookieStore.deleteCookie(cookie)
                }
                observers = observers.filter { $0.value != nil }
                let _ = observers.map { $0.value?.userInfoChanged?() }
                return
            }
        }
    }
    
    @objc public private(set) var bizInfo: BizInfo? {
        get {
            guard let bizInfoData = AppUserDataModel.keychain.data(forKey: KeychainAppUserKeys.BizInfoKey) else { return nil}
            Meta.registerClassNameWhiteLabel()
            Meta.registerClassNameUrbanPiperSDK()
            BizObject.registerClassNameWhiteLabel()
            BizObject.registerClassNameUrbanPiperSDK()
            BizInfo.registerClassNameUrbanPiperSDK()
            
            BizInfo.registerClassName()
            BizInfo.registerClassNameWhiteLabel()

            let obj = NSKeyedUnarchiver.unarchiveObject(with: bizInfoData)
            guard let bizInfo: BizInfo = obj as? BizInfo else { return nil }
            return bizInfo
        }
        set {
            guard let info = newValue else {
                AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.BizInfoKey)
                observers = observers.filter { $0.value != nil }
                let _ = observers.map { $0.value?.userBizInfoChanged?() }
                return
            }
            
            let bizInfoData: Data = NSKeyedArchiver.archivedData(withRootObject: info)
            AppUserDataModel.keychain.set(bizInfoData, forKey: KeychainAppUserKeys.BizInfoKey)
            
            observers = observers.filter { $0.value != nil }
            let _ = observers.map { $0.value?.userBizInfoChanged?() }
        }
    }
    
    @objc public var validAppUserData: User? {
//        guard let user = appUserData, user.userStatus == .valid else { return nil }
        return appUserData
    }
        
    public override init() {
        super.init()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.logout),
                                               name: .upSDKTokenExpired, object: nil)
        
        DispatchQueue.main.async { [weak self] in
            self?.refreshUserData()
            
            self?.loginUserWithJWT()
        }
        
    }
    
    @objc public func addObserver(delegate: AppUserDataModelDelegate) {
        let weakRefDataModelDelegate: WeakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
        observers.append(weakRefDataModelDelegate)
    }
    
    
    public func removeObserver(delegate: AppUserDataModelDelegate) {
        guard let index = (observers.index { $0.value === delegate }) else { return }
        observers.remove(at: index)
    }
    
    func loginUserWithJWT() {
        guard let appUser = validAppUserData, appUser.jwt == nil else {
            refreshToken()
            return
        }
        
        let dataTask: URLSessionDataTask
        if appUser.provider != nil {
            dataTask = APIManager.shared.checkForUser(email: appUser.email,
                                                  socialLoginProvider: appUser.provider!,
                                                  accessToken: appUser.accessToken!,
                                                  completion:
                { [weak self] (user) in
                    guard user?.jwt != nil else { return }
                    self?.appUserData = user
                    
                }, failure: { [weak self] error in
                    guard let msg = error?.errorMessage, msg == "email_check_failed" else { return }
                    self?.logout()
            })
        } else {
            dataTask = APIManager.shared.login(username: appUser.phone, password: appUser.password!, completion: { [weak self] (user) in
                guard user?.jwt != nil else { return }
                self?.appUserData = user
            }, failure: { [weak self] error in
                guard let msg = error?.errorMessage, msg == "email_check_failed" else { return }
                self?.logout()
            })
        }
        super.addDataTask(dataTask: dataTask)
    }
    
    func refreshToken() {
        guard let jwt = validAppUserData?.jwt else { return }
        guard !jwt.tokenExpired else {
            NotificationCenter.default.post(name: .upSDKTokenExpired, object: nil)
            return
        }
        guard jwt.shouldRefreshToken else { return }
        
        let dataTask = APIManager.shared.refreshToken(token: jwt.token, completion: { [weak self] (newToken) in
            guard let token = newToken else { return }
            let user = self?.validAppUserData?.update(fromJWTToken: token)
            self?.appUserData = user
        }, failure: nil)
        addDataTask(dataTask: dataTask)
    }
    
    @objc public func logout() {
        if let user = AppUserDataModel.shared.validAppUserData {
            AnalyticsManager.shared.track(event: .logout(phone: user.phone))
        }

        CartManager.shared.clearCart()
        CartManager.shared.lastOrder = nil
        CartManager.shared.couponCodeToApply = nil

        DeliveryLocationDataModel.shared.deliveryLocation = nil
        DeliveryLocationDataModel.shared.deliveryAddress = nil

        OrderingStoreDataModel.shared.nearestStoreResponse = nil
        UserDefaults.standard.removeObject(forKey: "defaultAddress")

        AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.AppUserKey)
        AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.BizInfoKey)

        APIManager.shared.lastRegisteredFCMToken = nil
        
        AddressDataModel.shared.userAddressesResponse = nil
        
        UserDefaults.standard.removeObject(forKey: "deliverySlots")
        UserDefaults.standard.removeObject(forKey: "deliverySlotsEnabled")
        UserDefaults.standard.removeObject(forKey: "feedback_config")
        UserDefaults.standard.removeObject(forKey: "referral_share_lbl")
        UserDefaults.standard.removeObject(forKey: "referral_ui_lbl")
        UserDefaults.standard.removeObject(forKey: "use_point_of_delivery")
        UserDefaults.standard.removeObject(forKey: "payment_options")

        UserDefaults.standard.removeObject(forKey: "NextLocationUpdateDate")

        UserDefaults.standard.removeObject(forKey: "authUserResponse")

        UserDefaults.standard.removeObject(forKey: PlacesSearchUserDefaultKeys.selectedPlacesDataKey)
        UserDefaults.standard.removeObject(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
        
        appUserData = nil
        bizInfo = nil        
    }
    
}

//  MARK: API Calls

extension AppUserDataModel {
    
    @objc public func refreshUserData(completion: (([String: Any]?) -> Void)? = nil,
                                      failure: APIFailure? = nil) {
        guard let phoneNo = validAppUserData?.phone else {
            failure?(nil)
            return
        }
        
        let dataTask: URLSessionDataTask = APIManager.shared.refreshUserData(phone: phoneNo, completion: { [weak self] (response) in
            guard let responseObject = response else { return }
            
            let user = self?.validAppUserData?.update(fromDictionary: responseObject)
            self?.appUserData = user
            
            completion?(response)
        }, failure: failure)
        
        addDataTask(dataTask: dataTask)
    }
    
    @objc public func updateUserInfo(name: String,
                               phone: String,
                               email: String,
                               gender: String? = nil,
                               anniversary: Date? = nil,
                               birthday: Date? = nil,
                               completion: (([String: Any]?) -> Void)?,
                               failure: APIFailure?) {
        let dataTask: URLSessionDataTask = APIManager.shared.updateUserInfo(name: name,
                                                                            phone: phone,
                                                                            email: email,
                                                                            gender: gender,
                                                                            anniversary: anniversary,
                                                                            birthday: birthday,
                                                                            completion: { [weak self] (response) in
                                                                                AnalyticsManager.shared.track(event: .profileUpdated(phone: phone, pwdChanged: false))
                                                                                guard let responseObject = response else { return }

                                                                                let user = self?.validAppUserData?.update(fromDictionary: responseObject)
                                                                                self?.appUserData = user

                                                                                completion?(response)
            }, failure: failure)
        
        addDataTask(dataTask: dataTask)
    }
    
    @objc public func updatePassword(phone: String,
                               oldPassword: String,
                               newPassword: String,
                               completion: (([String: Any]?) -> Void)?,
                               failure: APIFailure?) {
        
        let dataTask: URLSessionDataTask = APIManager.shared.updatePassword(phone: phone,
                                         oldPassword: oldPassword,
                                         newPassword: newPassword,
                                         completion: { (response) in
                                            AnalyticsManager.shared.track(event: .profileUpdated(phone: phone, pwdChanged: true))
                                            completion?(response)
            }, failure: failure)
        
        addDataTask(dataTask: dataTask)
    }
    
    @objc public func updateBizInfo(completion: ((BizInfo?) -> Void)? = nil, failure: APIFailure? = nil) {
        guard validAppUserData != nil else {
            failure?(nil)
            return
        }
        
        let dataTask: URLSessionDataTask = APIManager.shared.updateBizInfo(completion: { [weak self] (info) in
            self?.bizInfo = info
            AnalyticsManager.shared.track(event: .bizInfoUpdated)
            completion?(info)
        }, failure: failure)
        
        addDataTask(dataTask: dataTask)
    }
    
}

//  MARK: FCM

extension AppUserDataModel {
    
    public func registerForFCMMessaging() {
        InstanceID.instanceID().instanceID(handler: { (result, error) in
            guard let fcmToken = result?.token else { return }
            guard let dataTask: URLSessionDataTask = APIManager.shared.registerForFCMMessaging(token: fcmToken, completion: nil, failure: nil) else { return }
            self.addDataTask(dataTask: dataTask)
        })
    }
    
    public func unRegisterForFCMMessaging() {
        guard let dataTask: URLSessionDataTask = APIManager.shared.unRegisterForFCMMessaging(completion: nil, failure: nil) else { return }
        addDataTask(dataTask: dataTask)
    }
}

//  MARK: Normal Auth

extension AppUserDataModel {
    
    public func login(username: String,
                      password: String,
                      completion: @escaping ((User?) -> Void),
                      failure: @escaping APIFailure) {
        let dataTask: URLSessionDataTask = APIManager.shared.login(username: username, password: password, completion: { [weak self] (appUser) in
            if appUser?.jwt != nil {
                self?.appUserData = appUser
                AnalyticsManager.shared.track(event: .loginSuccess(phone: username))
            } else {
                AnalyticsManager.shared.track(event: .loginFailed(phone: username))
            }
            completion(appUser)
        }) { (error) in
            failure(error)
        }
        
        addDataTask(dataTask: dataTask)
    }
    
    public func forgotPassword(phone: String,
                               completion: @escaping (Bool, Error?)-> Void) {
        let dataTask: URLSessionDataTask = APIManager.shared.forgotPassword(phone: phone, completion: { (data) in
            guard let dictionary: [String: Any] = data, let statusString: String = dictionary["status"] as? String, statusString == "success" else {
                completion(false, nil)
                return
            }
            completion(true, nil)
        }) { (error) in
            completion(false, error)
        }
        
        addDataTask(dataTask: dataTask)
    }
    
    public func resetPassword(phone: String,
                              otp: String,
                              password: String,
                              confirmPassword: String,
                              completion: @escaping (Bool, Error?)-> Void) {
        AnalyticsManager.shared.track(event: .passwordReset(phone: phone))
        let dataTask: URLSessionDataTask = APIManager.shared.resetPassword(phone: phone,
                                        otp: otp,
                                        password: password,
                                        confirmPassword: confirmPassword,
                                        completion: { (data) in
                                            guard let dictionary: [String: Any] = data, let statusString: String = dictionary["status"] as? String, statusString == "success" else {
                                                completion(false, nil)
                                                return
                                            }
                                            completion(true, nil)
        }) { (error) in
            completion(false, error)
        }
        
        addDataTask(dataTask: dataTask)
    }
    
    public func createUser(name: String,
                              phone: String,
                              email: String,
                              password: String,
                              referralObject: Referral?,
                              completion: @escaping (CardAPIResponse?) -> Void,
                              failure: @escaping APIFailure) {
        let dataTask: URLSessionDataTask = APIManager.shared.createUser(name: name,
                                                                        phone: phone,
                                                                        email: email,
                                                                        password: password,
                                                                        referralObject: referralObject,
                                                                        completion: { (cardAPIResponse) in
//                                        user.message = cardAPIResponse?.message
//                                        user.password = password

                                        completion(cardAPIResponse)

        }) { (error) in
            failure(error)
        }
        
        addDataTask(dataTask: dataTask)
    }
    
}

//  MARK: Social Auth

extension AppUserDataModel {
    
    public func registerNewSocialAuthUser(name: String,
                                          phone: String,
                                          email: String,
                                          gender: String? = nil,
                                          socialLoginProvider: SocialLoginProvider,
                                          accessToken: String,
                                          referralObject: Referral?,
                                          completion: @escaping ((CardAPIResponse?) -> Void),
                                          failure: @escaping APIFailure) {
        AnalyticsManager.shared.track(event: .socialAuthSignupStart(phone: phone, platform: socialLoginProvider.rawValue))
        let dataTask: URLSessionDataTask = APIManager.shared.createSocialUser(name: name,
                                                                              phone: phone,
                                                                              email: email,
                                                                              gender: gender,
                                                                              accessToken: accessToken,
                                                                              referralObject: referralObject,
                                                                              completion: { (cardApiResponse) in
//                                                                                let userStatus = UserStatus(rawValue: cardAPIResponse.message)
//                                                                                user?.message = UserStatus.registrationSuccessfullVerifyOTP.rawValue
                                                                                completion(cardApiResponse)
        }) { (error) in
            failure(error)
        }
        
        addDataTask(dataTask: dataTask)
    }
    
    public func checkForUser(email: String,
                             socialLoginProvider: SocialLoginProvider,
                             accessToken: String,
                             completion: @escaping ((User?) -> Void),
                             failure: @escaping APIFailure) {
        let dataTask: URLSessionDataTask = APIManager.shared.checkForUser(email: email,
                                                                          socialLoginProvider: socialLoginProvider,
                                                                          accessToken: accessToken,
                                                                          completion: { [weak self] (appUser) in
//                                                                            if let status = appUser?.userStatus, (status == .registrationRequired) {
//                                                                                self?.registerNewSocialAuthUser(user: user, completion: completion)
//                                                                            } else {
                                                                                if let user = appUser, user.jwt != nil {
                                                                                    self?.appUserData = user
                                                                                }
                                                                                completion(appUser)
//                                                                            }
        }, failure: { (error) in
            failure(error)
        })
        addDataTask(dataTask: dataTask)
    }
}


//  MARK: Mobile Verification

extension AppUserDataModel {
    
    public func checkPhoneNumber(phone: String,
                                 email: String,
                                 socialLoginProvider: SocialLoginProvider,
                                 accessToken: String,
                                 completion: @escaping ((User?) -> Void),
                                 failure: @escaping APIFailure) {
        let dataTask: URLSessionDataTask = APIManager.shared.checkPhoneNumber(phone: phone,
                                                                              email: email,
                                                                              socialLoginProvider: socialLoginProvider,
                                                                              accessToken: accessToken,
                                                                              completion: { appUser in
                                                                                completion(appUser)
            }, failure: { (error) in
                failure(error)
        })
        
        addDataTask(dataTask: dataTask)
    }
    
//  used only when "new_registration_required"
    public func verifyMobileNumber(phone: String,
                                   otp: String,
                                   completion: @escaping ((CardAPIResponse?) -> Void),
                                   failure: @escaping APIFailure) {
        let dataTask: URLSessionDataTask = APIManager.shared.verifyMobile(phone: phone, pin: otp, completion: { (cardAPIResponse) in
            completion(cardAPIResponse)
        }, failure: { (error) in
            failure(error)
        })
        
        addDataTask(dataTask: dataTask)
    }
//  used in all the other cases
    public func verifyOTP(phone: String,
                          email: String,
                          socialLoginProvider: SocialLoginProvider,
                          accessToken: String,
                          otp: String,
                          completion: @escaping ((User?) -> Void),
                          failure: @escaping APIFailure) {
        let dataTask: URLSessionDataTask = APIManager.shared.verifyOTP(phone: phone,
                                                                       email: email,
                                                                       socialLoginProvider: socialLoginProvider,
                                                                       accessToken: accessToken,
                                                                       otp: otp,
                                                                       completion: { [weak self] (appUser) in
                                                                        if let user = appUser, user.jwt != nil {
                                                                            self?.appUserData = user
                                                                        }
                                                                        completion(appUser)
            }, failure: { (error) in
                failure(error)
        })

        addDataTask(dataTask: dataTask)
    }
    
    public func resendOTP(phone: String,
                   completion: @escaping ((CardAPIResponse?) -> Void),
                   failure: @escaping APIFailure) {
        AnalyticsManager.shared.track(event: .resendOTP(phone: phone))
        let dataTask: URLSessionDataTask = APIManager.shared.resendOTP(phone: phone,
                                                   completion: { (cardAPIResponse) in
                                                    completion(cardAPIResponse)
        }, failure: { (error) in
            failure(error)
        })
        
        addDataTask(dataTask: dataTask)
    }
    
}

//  App State Management

extension AppUserDataModel {
    
    @objc open override func appWillEnterForeground() {
        loginUserWithJWT()
    }
    
    @objc open override func appDidEnterBackground() {
    }
}

//  Reachability

extension AppUserDataModel {
    
    @objc open override func networkIsAvailable() {
        loginUserWithJWT()
    }
    
}
