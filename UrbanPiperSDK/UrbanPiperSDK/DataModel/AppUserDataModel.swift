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
    
    @objc func refreshAppUserUI(isRefreshing: Bool)
    @objc func refreshBizInfoUI(isRefreshing: Bool, isFirstUpdate: Bool)

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

public typealias CompletionHandler<T> = (T?, Error?) -> Void

public class AppUserDataModel: UrbanPiperDataModel {

    private struct KeychainAppUserKeys {
        static let AppUserKey = "KeyChainUserDataKey"
        static let BizInfoKey = "KeyChainBizInfoKey"
    }
    
    @objc static let userDataUpdateTimeInterval = 5
    @objc static public var nextUserDataUpdateDate: Date?
        
    private typealias WeakRefDataModelDelegate = WeakRef<AppUserDataModelDelegate>

    @objc public static private(set) var shared = AppUserDataModel()

    private var observers = [WeakRefDataModelDelegate]()
    
    private static let keychain = UPKeychainWrapper(serviceName: Bundle.main.bundleIdentifier!)
    
    @objc public var appUserData: User? {
        get {
//            debugPrint(AppUserDataModel.keychain.getAllKeyChainItemsOfClass(kSecClassGenericPassword as String))
            guard let userData = AppUserDataModel.keychain.data(forKey: KeychainAppUserKeys.AppUserKey) else { return nil}
            Meta.registerClassNameWhiteLabel()
            BizObject.registerClassNameWhiteLabel()
            BizInfo.registerClassNameWhiteLabel()

            User.registerClassName()
            let obj = NSKeyedUnarchiver.unarchiveObject(with: userData)
            guard let user = obj as? User else { return nil }
            return user
        }
        set {
            guard let user = newValue else {
                AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.AppUserKey)
                APIManager.shared.updateHeaders()
                unRegisterForFCMMessaging()
                URLCache.shared.removeAllCachedResponses()
                
                let cookieStore = HTTPCookieStorage.shared
                for cookie in cookieStore.cookies ?? [] {
                    cookieStore.deleteCookie(cookie)
                }
                observers = observers.filter { $0.value != nil }
                let _ = observers.map { $0.value?.refreshAppUserUI(isRefreshing: false) }
                return
            }
            
            if let oldUserData = appUserData, oldUserData.userStatus == .valid, user.userStatus != .valid {
                return
            }
            
            User.registerClassName()
            let userData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
            AppUserDataModel.keychain.set(userData, forKey: KeychainAppUserKeys.AppUserKey)
            APIManager.shared.updateHeaders()
            observers = observers.filter { $0.value != nil }
            let _ = observers.map { $0.value?.refreshAppUserUI(isRefreshing: false) }
            
            DispatchQueue.main.async { [weak self] in
                self?.registerForFCMMessaging()
                self?.updateUserBizInfo()
            }
        }
    }
    
    @objc public var bizInfo: BizInfo? {
        get {
            guard let bizInfoData = AppUserDataModel.keychain.data(forKey: KeychainAppUserKeys.BizInfoKey) else { return nil}
            Meta.registerClassNameWhiteLabel()
            BizObject.registerClassNameWhiteLabel()
            BizInfo.registerClassNameWhiteLabel()
            BizInfo.registerClassName()

            let obj = NSKeyedUnarchiver.unarchiveObject(with: bizInfoData)
            guard let bizInfo = obj as? BizInfo else { return nil }
            return bizInfo
        }
        set {
            guard let info = newValue else {
                AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.BizInfoKey)
                observers = observers.filter { $0.value != nil }
                let _ = observers.map { $0.value?.refreshBizInfoUI(isRefreshing: false, isFirstUpdate: false) }
                return
            }
            
            BizInfo.registerClassName()
            let isFirstUpdate = bizInfo == nil
            let bizInfoData: Data = NSKeyedArchiver.archivedData(withRootObject: info)
            AppUserDataModel.keychain.set(bizInfoData, forKey: KeychainAppUserKeys.BizInfoKey)
            
            observers = observers.filter { $0.value != nil }
            let _ = observers.map { $0.value?.refreshBizInfoUI(isRefreshing: false, isFirstUpdate: isFirstUpdate) }
        }
    }
    
    @objc public var validAppUserData: User? {
        guard let user = appUserData, user.userStatus == .valid, user.isValid else { return nil }
        return user
    }
        
    public override init() {
        super.init()
        
        DispatchQueue.main.async { [weak self] in
            self?.registerForFCMMessaging()
        }
        
        updateUserData()
    }
    
    public func addObserver(delegate: AppUserDataModelDelegate) {
        let weakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
        observers.append(weakRefDataModelDelegate)
    }
    
    
    public func removeObserver(delegate: AppUserDataModelDelegate) {
        guard let index = (observers.index { $0.value === delegate }) else { return }
        observers.remove(at: index)
    }
    
    @objc public func reset() {
        CartManager.shared.clearCart()
        DeliveryLocationDataModel.deliveryLocation = nil
        DeliveryLocationDataModel.deliveryAddress = nil
        OrderingStoreDataModel.nearestStoreResponse = nil
        UserDefaults.standard.removeObject(forKey: "defaultAddress")
        appUserData = nil
        bizInfo = nil
        AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.AppUserKey)
        AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.BizInfoKey)
        APIManager.shared.updateHeaders()
        APIManager.shared.lastRegisteredFCMToken = nil
        
        UserDefaults.standard.removeObject(forKey: "deliverySlots")
        UserDefaults.standard.removeObject(forKey: "deliverySlotsEnabled")
        UserDefaults.standard.removeObject(forKey: "feedback_config")
        UserDefaults.standard.removeObject(forKey: "referral_share_lbl")
        UserDefaults.standard.removeObject(forKey: "referral_ui_lbl")
        UserDefaults.standard.removeObject(forKey: "use_point_of_delivery")
        UserDefaults.standard.removeObject(forKey: "payment_options")

        UserDefaults.standard.removeObject(forKey: "NextLocationUpdateDate")
        UserDefaults.standard.removeObject(forKey: PlacesSearchUserDefaultKeys.selectedPlacesDataKey)
        UserDefaults.standard.removeObject(forKey: OrderPaymentDataModel.defaultAddressDefaultsKey)

    }
    
}

//  MARK: API Calls

extension AppUserDataModel {
    
    @objc func updateUserData(isForcedRefresh: Bool = false) {
        let nextUserDataUpdateDate = AppUserDataModel.nextUserDataUpdateDate
        let now = Date()
        let shouldRefreshUserData = nextUserDataUpdateDate == nil || nextUserDataUpdateDate! <= now || isForcedRefresh
        
        guard shouldRefreshUserData else { return }

        AppUserDataModel.nextUserDataUpdateDate = Calendar.current.date(byAdding: .minute,
                                                                        value: Int(AppUserDataModel.userDataUpdateTimeInterval),
                                                                        to: Date())
    }
    
    @objc fileprivate func updateUserBizInfo() {
        guard validAppUserData != nil else { return }
        
        let dataTask = APIManager.shared.fetchBizInfo(completion: nil, failure: nil)
        addOrCancelDataTask(dataTask: dataTask)
    }
    
}

//  MARK: FCM

extension AppUserDataModel {
    
    public func registerForFCMMessaging() {
        guard let fcmToken = InstanceID.instanceID().token() else { return }
        guard let dataTask = APIManager.shared.registerForFCMMessaging(token: fcmToken, completion: nil, failure: nil) else { return }
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func unRegisterForFCMMessaging() {
        guard let dataTask = APIManager.shared.unRegisterForFCMMessaging(completion: nil, failure: nil) else { return }
        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  MARK: Normal Auth

extension AppUserDataModel {
    
    public func login(user: User, password: String, completion: @escaping CompletionHandler<User>) {
        let dataTask = APIManager.shared.login(user: user,
                                               password: password,
                                               completion: { (appUser) in
                                                guard let appUserData = appUser else {
                                                    completion(nil, nil)
                                                    return
                                                }
                                                appUserData.password = password
                                                appUserData.message = UserStatus.valid.rawValue
                                                if appUserData.isValid {
                                                    AppUserDataModel.shared.appUserData = appUserData
                                                }
                                                completion(appUserData, nil)
        }) { (error) in
            completion(nil, error)
        }
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func forgotPassword(countryCode: String,
                        phoneNumber: String,
                        completion: @escaping (Bool, Error?)-> Void) {
        let dataTask = APIManager.shared.forgotPassword(countryCode: countryCode,
                                         phoneNumber: phoneNumber,
                                         completion: { (data) in
                                            guard let dictionary = data, let statusString = dictionary["status"] as? String, statusString == "success" else {
                                                completion(false, nil)
                                                return
                                            }
                                            completion(true, nil)
        }) { (error) in
            completion(false, error)
        }
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func resetPassword(countryCode: String,
                       phoneNumber: String,
                       otp: String,
                       password: String,
                       confirmPassword: String,
                       completion: @escaping (Bool, Error?)-> Void) {
        let dataTask = APIManager.shared.resetPassword(countryCode: countryCode,
                                        phoneNumber: phoneNumber,
                                        otp: otp,
                                        password: password,
                                        confirmPassword: confirmPassword,
                                        completion: { (data) in
                                            guard let dictionary = data, let statusString = dictionary["status"] as? String, statusString == "success" else {
                                                completion(false, nil)
                                                return
                                            }
                                            completion(true, nil)
        }) { (error) in
            completion(false, error)
        }
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func createAccount(user: User,
                       password: String,
                       completion: @escaping CompletionHandler<CardAPIResponse>) {
        let dataTask = APIManager.shared.createUser(user: user,
                                     password: password,
                                     completion: { (cardAPIResponse) in
                                        user.message = UserStatus.verifyPhoneNumber.rawValue
                                        user.password = password
                                        if user.isValid {
                                            AppUserDataModel.shared.appUserData = user
                                        }

                                        completion(cardAPIResponse, nil)

        }) { (error) in
            completion(nil, error)
        }
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
}

//  MARK: Social Auth

extension AppUserDataModel {
    
    public func registerNewSocialAuthUser(user: User!, completion: @escaping CompletionHandler<User>) {
        let dataTask = APIManager.shared.createSocialUser(user: user, completion: { (cardAPIResponse) in
            user?.message = UserStatus.registrationSuccessfullVerifyOTP.rawValue
            completion(user, nil)
        }) { (error) in
            completion(nil, error)
        }
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func checkForUser(user: User, completion: @escaping CompletionHandler<User>) {
        let dataTask = APIManager.shared.checkForUser(user: user,
                                                      completion: { [weak self] (appUser) in
                                                        if let status = appUser?.userStatus, status == .registrationRequired {
                                                            self?.registerNewSocialAuthUser(user: user, completion: completion)
                                                        } else {
                                                            if let success = appUser?.success, success {
                                                                appUser?.message = UserStatus.valid.rawValue
                                                                if let userVal = appUser, userVal.isValid {
                                                                    AppUserDataModel.shared.appUserData = userVal
                                                                }
                                                            }
                                                            completion(appUser, nil)
                                                        }
            }, failure: { (error) in
                completion(nil, error)
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
}


//  MARK: Mobile Verification

extension AppUserDataModel {
    
    public func checkPhoneNumber(user: User, completion: @escaping CompletionHandler<User>) {
        let dataTask = APIManager.shared.checkPhoneNumber(user: user,
                                                          completion: { [weak self] (appUser) in
                                                            if let status = appUser?.userStatus, status == .registrationRequired {
                                                                self?.registerNewSocialAuthUser(user: user, completion: completion)
                                                                return
                                                            } else if let userVal = appUser, userVal.isValid {
                                                                AppUserDataModel.shared.appUserData = userVal
                                                            }
                                                            completion(appUser, nil)
        }, failure: { (error) in
            completion(nil, error)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
//  used only when "new_registration_required"
    public func verifyMobileNumber(user: User, otp: String, completion: @escaping CompletionHandler<CardAPIResponse>) {
        let dataTask = APIManager.shared.verifyMobile(user: user, pin: otp, completion: { (cardAPIResponse) in
            if let response = cardAPIResponse, response.success {
                user.message = UserStatus.valid.rawValue
                if user.isValid {
                    AppUserDataModel.shared.appUserData = user
                }
            }
            completion(cardAPIResponse, nil)
        }, failure: { (error) in
            completion(nil, error)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
//  used in all the other cases
    public func verifyOTP(user: User,
                   otp: String,
                   completion: @escaping CompletionHandler<User>) {
        let dataTask = APIManager.shared.verifyOTP(user: user,
                                                   otp: otp,
                                                   completion: { (appUser) in
                                                    if let response = appUser, response.success {
                                                        appUser?.message = UserStatus.valid.rawValue
                                                        if let userVal = appUser, userVal.isValid {
                                                            AppUserDataModel.shared.appUserData = userVal
                                                        }
                                                    }
                                                    completion(appUser, nil)
            }, failure: { (error) in
                completion(nil, error)
        })

        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func resendOTP(user: User,
                   completion: @escaping CompletionHandler<CardAPIResponse>) {
        let dataTask = APIManager.shared.resendOTP(user: user,
                                                   completion: { (cardAPIResponse) in
                                                    completion(cardAPIResponse, nil)
        }, failure: { (error) in
            completion(nil, error)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
}

//  App State Management

extension AppUserDataModel {
    
    @objc open override func appWillEnterForeground() {
        guard validAppUserData != nil else { return }
    
        guard bizInfo == nil else { return }
        updateUserBizInfo()
    }
    
    @objc open override func appDidEnterBackground() {
    }
}

//  Reachability

extension AppUserDataModel {
    
    @objc open override func networkIsAvailable() {
        
        guard validAppUserData != nil else { return }
       
        guard bizInfo == nil else { return }
        updateUserBizInfo()
    }
}
