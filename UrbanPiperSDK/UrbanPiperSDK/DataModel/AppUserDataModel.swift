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
    
    @objc optional func refreshAppUserUI(isRefreshing: Bool)
    @objc optional func handleUserAPI(error: UPError?)

    @objc optional func refreshUpdateAppUserUI(isRefreshing: Bool)
    @objc optional func handleUpdateUserAPI(error: UPError?)

    @objc optional func refreshUpdatePasswordUI(isRefreshing: Bool)
    @objc optional func handleUpdatePasswordAPI(error: UPError?)
    
    @objc optional func refreshBizInfoUI(isRefreshing: Bool, isFirstUpdate: Bool)
    @objc optional func handleBizInfoAPI(error: UPError?)

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
        static let AppUserKey: String = "KeyChainUserDataKey"
        static let BizInfoKey: String = "KeyChainBizInfoKey"
    }
    
    @objc static let userDataUpdateTimeInterval = 5
    @objc static public var nextUserDataUpdateDate: Date?
        
    private typealias WeakRefDataModelDelegate = WeakRef<AppUserDataModelDelegate>

    @objc public static private(set) var shared: AppUserDataModel = AppUserDataModel()

    private var observers = [WeakRefDataModelDelegate]()
    
    private static let keychain: UPKeychainWrapper = UPKeychainWrapper(serviceName: Bundle.main.bundleIdentifier!)
    
    @objc public var appUserData: User? {
        get {
//            debugPrint(AppUserDataModel.keychain.getAllKeyChainItemsOfClass(kSecClassGenericPassword as String))
            guard let userData = AppUserDataModel.keychain.data(forKey: KeychainAppUserKeys.AppUserKey) else { return nil}
            Meta.registerClassNameWhiteLabel()
            BizObject.registerClassNameWhiteLabel()
            BizInfo.registerClassNameWhiteLabel()

            User.registerClassName()
            let obj = NSKeyedUnarchiver.unarchiveObject(with: userData)
            guard let user: User = obj as? User else { return nil }
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
                let _ = observers.map { $0.value?.refreshAppUserUI?(isRefreshing: false) }
                return
            }
            
            if let oldUserData = appUserData, oldUserData.userStatus == .valid, user.userStatus != .valid {
                return
            } else if let oldUserData = appUserData, oldUserData.userStatus != .valid, user.userStatus == .valid {
                DispatchQueue.main.async { [weak self] in
                    self?.fetchUserData()
                }
            }
            
            User.registerClassName()
            let userData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
            AppUserDataModel.keychain.set(userData, forKey: KeychainAppUserKeys.AppUserKey)
            APIManager.shared.updateHeaders()
            observers = observers.filter { $0.value != nil }
            let _ = observers.map { $0.value?.refreshAppUserUI?(isRefreshing: false) }
            
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
            guard let bizInfo: BizInfo = obj as? BizInfo else { return nil }
            return bizInfo
        }
        set {
            guard let info = newValue else {
                AppUserDataModel.keychain.removeObject(forKey: KeychainAppUserKeys.BizInfoKey)
                observers = observers.filter { $0.value != nil }
                let _ = observers.map { $0.value?.refreshBizInfoUI?(isRefreshing: false, isFirstUpdate: false) }
                return
            }
            
            BizInfo.registerClassName()
            let isFirstUpdate = bizInfo == nil
            let bizInfoData: Data = NSKeyedArchiver.archivedData(withRootObject: info)
            AppUserDataModel.keychain.set(bizInfoData, forKey: KeychainAppUserKeys.BizInfoKey)
            
            observers = observers.filter { $0.value != nil }
            let _ = observers.map { $0.value?.refreshBizInfoUI?(isRefreshing: false, isFirstUpdate: isFirstUpdate) }
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
            self?.fetchUserData()
        }
        
    }
    
    public func addObserver(delegate: AppUserDataModelDelegate) {
        let weakRefDataModelDelegate: WeakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
        observers.append(weakRefDataModelDelegate)
    }
    
    
    public func removeObserver(delegate: AppUserDataModelDelegate) {
        guard let index = (observers.index { $0.value === delegate }) else { return }
        observers.remove(at: index)
    }
    
    @objc public func reset() {
        CartManager.shared.clearCart()
        DeliveryLocationDataModel.shared.deliveryLocation = nil
        DeliveryLocationDataModel.shared.deliveryAddress = nil
        OrderingStoreDataModel.shared.nearestStoreResponse = nil
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
        UserDefaults.standard.removeObject(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)

    }
    
}

//  MARK: API Calls

extension AppUserDataModel {
    
    @objc public func fetchUserData(isForcedRefresh: Bool = false) {
        guard let phoneNo = validAppUserData?.phone else { return }
        let nextUserDataUpdateDate = AppUserDataModel.nextUserDataUpdateDate
        let now: Date = Date()
        let shouldRefreshUserData = nextUserDataUpdateDate == nil || nextUserDataUpdateDate! <= now || isForcedRefresh
        
        guard shouldRefreshUserData else { return }

        AppUserDataModel.nextUserDataUpdateDate = Calendar.current.date(byAdding: .minute,
                                                                        value: Int(AppUserDataModel.userDataUpdateTimeInterval),
                                                                        to: Date())

        let _ = observers.map { $0.value?.refreshAppUserUI?(isRefreshing: true) }
        
        let dataTask: URLSessionTask = APIManager.shared.userInfo(phone: phoneNo, completion: { [weak self] (response) in
            guard let dataModel = self, let user = dataModel.appUserData, let responseObject = response else { return }
            dataModel.observers = dataModel.observers.filter { $0.value != nil }
            let _ = dataModel.observers.map { $0.value?.refreshAppUserUI?(isRefreshing: false) }

            user.update(fromDictionary: responseObject)
            dataModel.appUserData = user
        }, failure: { [weak self] (upError) in
            guard let dataModel = self else { return }
            dataModel.observers = dataModel.observers.filter { $0.value != nil }
            let _ = dataModel.observers.map { $0.value?.handleUserAPI?(error: upError) }
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func updateUserInfo(name: String,
                               phone: String,
                               email: String,
                               gender: String? = nil,
                               anniversary: Date? = nil,
                               birthday: Date? = nil) {
        let _ = observers.map { $0.value?.refreshUpdateAppUserUI?(isRefreshing: true) }
        
        let dataTask: URLSessionTask = APIManager.shared.updateUserInfo(name: name,
                                         phone: phone,
                                         email: email,
                                         gender: gender,
                                         anniversary: anniversary,
                                         birthday: birthday,
                                         completion: { [weak self] (response) in
                                            guard let dataModel = self, let user = dataModel.appUserData, let responseObject = response else { return }
                                            dataModel.observers = dataModel.observers.filter { $0.value != nil }
                                            let _ = dataModel.observers.map { $0.value?.refreshUpdateAppUserUI?(isRefreshing: false) }
                                            
                                            user.update(fromDictionary: responseObject)
                                            dataModel.appUserData = user

            }, failure: { [weak self] (upError) in
                guard let dataModel = self else { return }
                dataModel.observers = dataModel.observers.filter { $0.value != nil }
                let _ = dataModel.observers.map { $0.value?.handleUpdateUserAPI?(error: upError) }
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func updatePassword(phone: String,
                               oldPassword: String,
                               newPassword: String) {
        
        let _ = observers.map { $0.value?.refreshUpdatePasswordUI?(isRefreshing: true) }
        let dataTask: URLSessionTask = APIManager.shared.updatePassword(phone: phone,
                                         oldPassword: oldPassword,
                                         newPassword: newPassword,
                                         completion: { [weak self] (response) in
                                            
                                            guard let dataModel = self, let user = dataModel.appUserData, let responseObject = response else { return }
                                            dataModel.observers = dataModel.observers.filter { $0.value != nil }
                                            let _ = dataModel.observers.map { $0.value?.refreshUpdatePasswordUI?(isRefreshing: false) }
                                            
                                            user.password = newPassword
                                            dataModel.appUserData = user
            }, failure: { [weak self] (upError) in
                guard let dataModel = self else { return }
                dataModel.observers = dataModel.observers.filter { $0.value != nil }
                let _ = dataModel.observers.map { $0.value?.handleUpdatePasswordAPI?(error: upError) }
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    @objc public func updateUserBizInfo() {
        guard validAppUserData != nil else { return }
        
        let dataTask: URLSessionTask = APIManager.shared.fetchBizInfo(completion: nil, failure: nil)
        addOrCancelDataTask(dataTask: dataTask)
    }
    
}

//  MARK: FCM

extension AppUserDataModel {
    
    public func registerForFCMMessaging() {
        guard let fcmToken = InstanceID.instanceID().token() else { return }
        guard let dataTask: URLSessionTask = APIManager.shared.registerForFCMMessaging(token: fcmToken, completion: nil, failure: nil) else { return }
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func unRegisterForFCMMessaging() {
        guard let dataTask: URLSessionTask = APIManager.shared.unRegisterForFCMMessaging(completion: nil, failure: nil) else { return }
        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  MARK: Normal Auth

extension AppUserDataModel {
    
    public func login(user: User, password: String, completion: @escaping CompletionHandler<User>) {
        let dataTask: URLSessionTask = APIManager.shared.login(user: user,
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
        let dataTask: URLSessionTask = APIManager.shared.forgotPassword(countryCode: countryCode,
                                         phoneNumber: phoneNumber,
                                         completion: { (data) in
                                            guard let dictionary: [String: Any] = data, let statusString: String = dictionary["status"] as? String, statusString == "success" else {
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
        let dataTask: URLSessionTask = APIManager.shared.resetPassword(countryCode: countryCode,
                                        phoneNumber: phoneNumber,
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
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func createAccount(user: User,
                       password: String,
                       completion: @escaping CompletionHandler<CardAPIResponse>) {
        let dataTask: URLSessionTask = APIManager.shared.createUser(user: user,
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
        let dataTask: URLSessionTask = APIManager.shared.createSocialUser(user: user, completion: { (cardAPIResponse) in
            user?.message = UserStatus.registrationSuccessfullVerifyOTP.rawValue
            completion(user, nil)
        }) { (error) in
            completion(nil, error)
        }
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func checkForUser(user: User, completion: @escaping CompletionHandler<User>) {
        let dataTask: URLSessionTask = APIManager.shared.checkForUser(user: user,
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
        let dataTask: URLSessionTask = APIManager.shared.checkPhoneNumber(user: user,
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
        let dataTask: URLSessionTask = APIManager.shared.verifyMobile(user: user, pin: otp, completion: { (cardAPIResponse) in
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
        let dataTask: URLSessionTask = APIManager.shared.verifyOTP(user: user,
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
        let dataTask: URLSessionTask = APIManager.shared.resendOTP(user: user,
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
        fetchUserData()
    }
    
    @objc open override func appDidEnterBackground() {
    }
}

//  Reachability

extension AppUserDataModel {
    
    @objc open override func networkIsAvailable() {
        guard validAppUserData != nil else { return }
        fetchUserData()
    }
    
}
