//
//  UrbanPiperSDK.swift
//  UrbanPiperSDK
//
//  Created by Vid on 24/10/18.
//

import UIKit
import CoreLocation

/// The primary class for integrating UrbanPiperSDK in your app
public class UrbanPiperSDK: NSObject {

    static private(set) var shared: UrbanPiperSDK!
    internal var callback:  (SDKEvent) -> Void
    
    /// Returns the shared instance that was initialized
    ///
    /// - Returns: Instance of UrbanPiperSDK
    @objc public static func sharedInstance() -> UrbanPiperSDK {
        assert(shared != nil, "UrbanPiperSDK has not been initialized, call initialize(bizId:apiUsername:apiKey) to initialize the SDK ")
        return shared
    }
    
    private init(language: Language = .english, bizId: String, apiUsername: String, apiKey: String, callback: @escaping (SDKEvent) -> Void) {
        self.callback = callback
        super.init()
        APIManager.initializeManager(language: language, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, jwt: UserManager.shared.currentUser?.jwt)
        
        if let mixpanelToken = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, mixpanelToken.count > 0 {
            let mixpanelObserver = MixpanelObserver(mixpanelToken: mixpanelToken)
            AnalyticsManager.shared.addObserver(observer: mixpanelObserver)
        }
        
        let plistPath: String = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        var googleServiceInfoPlist: [String: Any] = NSDictionary(contentsOfFile: plistPath) as! [String: Any]
        if let trackingId: String = googleServiceInfoPlist["TRACKING_ID"] as? String, trackingId.count > 0 {
            let gaObserver = GAObserver(gaTrackingId: trackingId)
            AnalyticsManager.shared.addObserver(observer: gaObserver)
        }
        
        if let appsFlyerDevAppid: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevAppid, let appsFlyerDevKey: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevKey {
            let appsFlyerObserver = AppsFlyerObserver(appsFlyerDevAppid: appsFlyerDevAppid, appsFlyerDevKey: appsFlyerDevKey)
            AnalyticsManager.shared.addObserver(observer: appsFlyerObserver)
        }
    }
    
    /// Intializes the UrbanPiperSDK, the initialized instance of the SDK is accessible via the static func sharedInstance()
    ///
    /// - Parameters:
    ///   - language: Optional. Default - english. a value from the Language enum
    ///   - bizId: your business id from urbanpiper
    ///   - apiUsername: your api username from urbanpiper
    ///   - apiKey: your api key from urbanpiper
    ///   - callback: callback notifies about the events that should be handled by the app, the list of events can be found in the SDKEvent enum
    public class func intialize(language: Language? = .english, bizId: String, apiUsername: String, apiKey: String, callback: @escaping (SDKEvent) -> Void) {
        shared = UrbanPiperSDK(language: language!, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, callback: callback)
    }
    
    /// API call to  change the language of the SDK after the SDK has been initialized
    ///
    /// - Parameter language: a value from the Language enum
    public func change(language: Language) {
        APIManager.shared.language = language
    }
    
    /// Returns the language in the SDK
    ///
    /// - Returns: Language enum
    public func currentLanguage() -> Language {
        return APIManager.shared.language
    }

}

//  MARK: User functions

public extension UrbanPiperSDK {

    /// Returns the saved User object for a logged in user and nil for a guest user
    ///
    /// - Returns: Returns an instance of User
    @objc public func getUser() -> User? {
        return UserManager.shared.currentUser
    }

    /// Returns a helper class that contains the api calls to perform a user registration
    ///
    /// - Returns: Returns an instance of RegistrationBuilder
    public func startRegistration() -> RegistrationBuilder {
        return RegistrationBuilder()
    }
    
    /// Returns a helper class that contains the api calls to perform a social user registration
    ///
    /// - Returns: Returns an instance of SocialRegBuilder
    public func startSocialRegistration() -> SocialRegBuilder {
        return SocialRegBuilder()
    }
    
    /// Returns a helper class that contains the api calls to perform a password reset
    ///
    /// - Returns: Returns an instance of ResetPasswordBuilder
    public func startPasswordReset() -> ResetPasswordBuilder {
        return ResetPasswordBuilder()
    }
    
    /// API call to  logout the user
    public func logout() {
        UserManager.shared.logout()
    }
    
    /// Use this function to Log-in the user if the user has been registered previously by passing in the username and password
    ///
    /// - Parameters:
    ///   - username: phone number provided by the user the user, should include the country code i.e (+91)
    ///   - password: password provided by the user, should be atleast 6 chars long
    ///   - completion: success callback with a LoginResponse object, if the message value is "userbiz_phone_not_validated" then the users phone number has verified by calling the verifyRegOtp in the RegistrationBuilder accessible by the startRegistration
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func login(username: String, password: String, completion: @escaping ((LoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.login(username: username, password: password, completion: completion, failure: failure)
    }
    
    /// Use this function to perform a social login with the data from the social login providers, if the value message varible is "phone_number_required" the user has to be registered, to register a social login user call "startSocialRegistration"
    ///
    /// - Parameters:
    ///   - email: the email id from the social login provider
    ///   - socialLoginProvider: a value from the SocialLoginProvider enum
    ///   - accessToken: the access token provided by the social login provider
    ///   - completion: success callback with an instance of SocialLoginResponse, the social login is successful if the var success in the socialLoginResponse is true else the user needs to be registered using the startSocialRegistration function
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func socialLogin(email: String, socialLoginProvider: SocialLoginProvider, accessToken: String,
                                               completion: @escaping ((SocialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.socialLogin(email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, completion: completion, failure: failure)
    }
        
    /// Fetches the user info from the server, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - completion: success callback with an instance of UserInfoResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func refreshUserInfo(completion: ((UserInfoResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserInfo(completion: completion, failure: failure)
    }

    /// Fetches the users biz info (balance, points) for the server, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - completion: success callback with an instance of UserBizInfoResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @objc @discardableResult public func refreshUserBizInfo(completion: ((UserBizInfoResponse?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserBizInfo(completion: completion, failure: failure)
    }

    /// Use this function to update the user details by setting the relevant parameters,
    ///
    /// - Parameters:
    ///   - name: the name string provided by user
    ///   - email: the email string provided by the user, this value cannot be changed for a social login user
    ///   - gender: the gender value provided by the user
    ///   - anniversary: the anniversay value provided by the user
    ///   - birthday: the birthday value provided by the user
    ///   - completion: success callback with the UserInfoUpdateResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func updateUserInfo(name: String, email: String? = nil, gender: String? = nil, anniversary: Date? = nil, birthday: Date? = nil,
                                                        completion: ((UserInfoUpdateResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }
        assert(user.provider != nil && email == nil, "The email id cannot be changed for a social login user")
        guard user.provider != nil && email == nil else { return  nil }
        return UserManager.shared.updateUserInfo(name: name, phone: user.phone, email: email ?? user.email, gender: gender, completion: completion, failure: failure)
    }
    
    /// Use this function to change the password of a logged in user, the password cannot be changed for a social login user, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - phone: the phone number of the user
    ///   - oldPassword: the current password of the user
    ///   - newPassword: the new password entered by the user
    ///   - completion: success callback with the GenericResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @objc @discardableResult public func changePassword(phone: String, oldPassword: String, newPassword: String, completion: ((GenericResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }

        assert(user.provider == nil, "Password cannot be changed for a social login user")
        guard user.provider == nil else { return  nil }

        return UserManager.shared.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword, completion: completion, failure: failure)
    }
    
    /// Get the deliverable address for the provided store id, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - storeId: the store id can be obtained from the getNearestStore(lat:lng) function
    ///   - completion: success callback with UserAddressesResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func getDeliverableAddresses(storeId: Int, completion: ((UserAddressesResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getDeliverableAddresses(storeId: storeId, completion: completion, failure: failure)
    }

    /// Use this function to add a new address to the users saved address list, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - address: the new address to add
    ///   - completion: success callback with AddUpdateAddressResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func addAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.addAddress(address: address, completion: { (addUpdateAddressResponse) in
            let newAddress = address
            newAddress.id = addUpdateAddressResponse?.addressId
            AddressDataModel.shared.userAddressesResponse?.addresses.insert(address, at: 0)
            completion?(addUpdateAddressResponse)
        }, failure: failure)
    }
    
    /// Use this function to update a given address, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - address: the address to update
    ///   - completion: success callback with AddUpdateAddressResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func updateAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.updateAddress(address: address, completion: completion, failure: failure)
    }
    
    /// Use this funtion to delete an address, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - addressId: the id of the address to be deleted
    ///   - completion: success callback with GenericResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func deleteAddress(addressId: Int, completion: ((GenericResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.deleteAddress(addressId: addressId, completion: { (genericResponse) in
            if let addresses = AddressDataModel.shared.userAddressesResponse?.addresses {
                AddressDataModel.shared.userAddressesResponse?.addresses = addresses.filter { $0.id != addressId }
            }
            completion?(genericResponse)
        }, failure: failure)
    }
    
    /// Get the users wallet transactions, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - completion: success callback with a list of wallet transactions
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getWalletTransactions(completion: ((WalletTransactionResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getWalletTransactions(completion: completion, failure: failure)
    }
    
    /// Get the users past orders, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - completion: success callback with the list of past orders
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func getPastOrders(completion: ((PastOrdersResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getPastOrders(completion: completion, failure: failure)
    }

    /// Get the users past order details, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - orderId: the past order id
    ///   - completion: success callback with the details on the provided past order id
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func getPastOrderDetails(orderId: Int, completion: ((PastOrderDetailsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getPastOrderDetails(orderId: orderId, completion: completion, failure: failure)
    }

    /// Use this function to reedem the reward from the getRewards() fucntion, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - rewardId: the reward id to be reedemed
    ///   - completion: success callback with the RedeemRewardResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func redeemReward(rewardId: Int, completion: ((RedeemRewardResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.redeemReward(rewardId: rewardId, completion: completion, failure: failure)
    }
    
    /// Get the list of users notfications, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - completion: success callback with a list of users notifications
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getNotifications(completion: ((NotificationsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getNotifications(completion: completion, failure: failure)
    }

    /// Use this method to submit the feedback to an completed order, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - name: name of the user
    ///   - orderId: the order id for which the feedback is to submitted
    ///   - rating: the rating provided by the user
    ///   - choiceText: the choice text selected by the user
    ///   - comments: the comments to the user
    ///   - completion: success callback with the GenericResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func submitFeedback(name: String, rating: Double, orderId: String, choiceText: String?, comments: String?,
                                                  completion: ((GenericResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.submitFeedback(name: name, rating: rating, orderId: orderId, choiceText: choiceText, comments: comments, completion: completion, failure: failure)
    }

    /// Get the items that where liked by the user, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - offset: the pagination offset
    ///   - limit: the pagination limit
    ///   - completion: success response with the list of user likes
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getItemLikes(offset: Int = 0, limit: Int? = nil, completion: @escaping ((UserLikesResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.userLikes(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    /// Use this function to like an item, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - itemId: the item id to be liked
    ///   - completion: success callback with a GenericResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func likeItem(itemId: Int, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.likeItem(itemId: itemId, completion: completion, failure: failure)
    }
    
    /// Use this function to unlike an item, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - itemId: the item id to unlike
    ///   - completion: success callback with a GenericResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func unlikeItem(itemId: Int, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.unlikeItem(itemId: itemId, completion: completion, failure: failure)
    }

    /// This funtion is used to initate a user wallet reload, user needs to be logged in to call this function
    ///
    /// - Parameters:
    ///   - amount: the amount to be reloaded into the wallet
    ///   - completion: success callback with PaymentInitResponse, the response contains the payment gateway details
    ///   - failure: Return an instance of URLSessionDataTask
    @discardableResult @objc public func initWalletReload(amount: Decimal,
                                                          completion: ((PaymentInitResponse?) -> Void)?,
                                                          failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let paymentOption = PaymentOption.paymentGateway
        let purpose = OnlinePaymentPurpose.reload
        return APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption, purpose: purpose, totalAmount: amount, storeId: nil, completion: completion, failure: failure)
    }
    
    /// Use this function to verify a wallet reload completed using a payment gateway
    ///
    /// - Parameters:
    ///   - pid: the payment id for the payment gateway
    ///   - transactionId: the transcation id from the initWalletReload response
    ///   - completion: success callback with OrderVerifyTxnResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func verifyWalletReload(pid: String,
                                                       transactionId: String,
                                                       completion: @escaping ((OrderVerifyTxnResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.verifyPayment(pid: pid, orderId: OnlinePaymentPurpose.reload.rawValue, transactionId: transactionId, completion: completion, failure: failure)
    }

}


//  MARK: General

extension UrbanPiperSDK {
    
    /// Register the fcm token in urbanpiper server to receive the push notifications
    ///
    /// - Parameters:
    ///   - token: the token from google's FirebaseMessaging
    ///   - completion: success callback with a GenericResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func registerForFCMToken(token: String, completion: ((GenericResponse?) -> Void)? = nil,
                                                  failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.registerForFCMToken(token: token, completion: completion, failure: failure)
    }
    
    /// API call to  perform an version check with the urbanpiper server to indi
    ///
    /// - Parameters:
    ///   - version: the current version of the app
    ///   - completion: success callback with VersionCheckResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func checkAppVersion(version: String, completion: ((VersionCheckResponse?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.checkAppVersion(username: UserManager.shared.currentUser?.username, version: version, completion: completion, failure: failure)
    }
    
    /// API call used to get the nearest store to the provided lat lng
    ///
    /// - Parameters:
    ///   - lat: user location latitude
    ///   - lng: user location longitude
    ///   - completion: success callback with the Biz details and the nearest store
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getNearestStore(lat: CLLocationDegrees, lng: CLLocationDegrees,
                                                   completion: @escaping ((StoreResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getNearestStore(CLLocationCoordinate2DMake(lat, lng), completion: completion, failure: failure)
    }
    
    /// Get all the stores registered for the business
    ///
    /// - Parameters:
    ///   - completion: success callback with a list of stores registered to the business
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func getAllStores(completion: @escaping ((StoreListResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getAllStores(completion: completion, failure: failure)
    }
    
}


//  MARK: Catalogue

extension UrbanPiperSDK {
    
    /// Get the list of categories set up for the business
    ///
    /// - Parameters:
    ///   - storeId: Optional. the nearest store id
    ///   - offset: pagination offset
    ///   - limit: pagination limit
    ///   - completion: success callback with a list of categories set up for the business
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getCategories(storeId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((CategoriesResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getCategories(storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Get the items for a given category
    ///
    /// - Parameters:
    ///   - categoryId: category id to retrive the items for
    ///   - storeId: Optional. the store id from the nearest store
    ///   - offset: pagination offset
    ///   - limit: pagination limit
    ///   - completion: success callback with CategoryItemsResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getCategoryItems(categoryId: Int, storeId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getCategoryItems(categoryId: categoryId, storeId: storeId, completion: completion, failure: failure)
    }

    /// API call to  search items for a provided keyword
    ///
    /// - Parameters:
    ///   - query: the keyword to search for
    ///   - storeId: the store id from the nearest store
    ///   - offset: pagination offset
    ///   - limit: pagination limit
    ///   - completion: success callback with the list of items for a the query
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func searchItems(query: String, storeId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((ItemsSearchResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.searchItems(query: query, storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    /// Get the filter and sort options for a category
    ///
    /// - Parameters:
    ///   - categoryid: category id for which the filter and sort options are to retrived
    ///   - completion: success callback with a list of filter and sort options
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getFilterAndSortOptions(categoryid: Int, completion: @escaping ((CategoryOptionsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFilterAndSortOptions(id: categoryid, completion: completion, failure:failure)
    }

    /// Get the item details for a given item id
    ///
    /// - Parameters:
    ///   - itemId: item id to retrive the item details for
    ///   - storeId: the store id of the nearest store
    ///   - completion: success callback with the details of the provided item id
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getItemDetails(itemId: Int, storeId: Int, completion: @escaping ((Item?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getItemDetails(itemId: itemId, storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Get the list of featured items
    ///
    /// - Parameters:
    ///   - storeId: store id of the nearest store
    ///   - completion: success callback with a list of featured items
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getFeaturedItems(storeId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Get the list of associated items for the provided item id
    ///
    /// - Parameters:
    ///   - itemId: the item id to retrive the assiciated items for
    ///   - storeId: store id of the nearest store
    ///   - completion: success callback with a list of items associated with the given item id
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getAssociatedItems(itemId: Int, storeId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(itemIds: [itemId], storeId: storeId, completion: completion, failure: failure)
    }
}

//  MARK: Promotions

extension UrbanPiperSDK {
    
    /// Get the list of rewards from the server
    ///
    /// - Parameters:
    ///   - completion: success callback return witha a list of rewards
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func getRewards(completion: @escaping ((RewardsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getRewards(completion: completion, failure: failure)
    }
    
    /// Get the list of offers from the server
    ///
    /// - Parameters:
    ///   - offset: pagination offset
    ///   - limit: pagination limit
    ///   - completion: success callback with a list of offers
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getOffers(offset: Int = 0, limit: Int? = nil, completion: @escaping ((OffersAPIResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getOffers(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    /// Get the list of banners from the server
    ///
    /// - Parameters:
    ///   - completion: success callback with the list of banners
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getBanners(completion: @escaping ((BannersResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getBanners(completion: completion, failure: failure)
    }
    
}

//  MARK: Cart

extension UrbanPiperSDK {
    
    /// Returns a helper class that contains the api calls to place an order
    ///
    /// - Returns: Returns an instance of CheckoutBuilder
    public func startCheckout() -> CheckoutBuilder {
        return CheckoutBuilder()
    }
    
    /// Returns a list of items added to the cart
    ///
    /// - Returns: Returns an instance of an array that contains the list of items adde to the cart
    public func cartItems() -> [CartItem] {
        return CartManager.shared.cartItems
    }
    
    /// Returns the item quantity added to the cart for a given item id
    ///
    /// - Parameter itemId: item id to get the cart quantity for
    /// - Returns: Returns an int value
    public func getItemCountFor(itemId: Int) -> Int {
        return CartManager.shared.cartCount(for: itemId)
    }
    
    /// The total value of the cart factoring item quanities and the options selected
    ///
    /// - Returns: Returns an Decimal value representing the total value of the cart
    @objc public func cartValue() -> Decimal {
        return CartManager.shared.cartValue
    }
    
    /// API call to  add an cart item to the cart with the item quantity to be added and the notes for the item
    ///
    /// - Parameters:
    ///   - cartItem: the cart item to be added
    ///   - quantity: the quantity of the item to be added
    ///   - notes: the notes for the item to be added
    /// - Throws: this method throws the error "maxOrderableQuantityAdded" when an item is added more than the avaialble stock
    @objc public func addItemToCart(cartItem: CartItem, quantity: Int, notes: String? = nil) throws {
        do {
            try CartManager.shared.add(cartItem: cartItem, quantity: quantity, notes: notes)
        } catch {
            throw error
        }
    }
    
    /// Fuction to reduce the item quantity by the passed in quantity from cart
    ///
    /// - Parameters:
    ///   - itemId: the id of the item to remove
    ///   - quantity: the quantity to reduce from the item
    public func removeItemFromCart(itemId: Int, quantity: Int) {
        CartManager.shared.remove(itemId: itemId, quantity: quantity)
    }
    
    /// API call to  clear all the items in the cart
    @objc public func clearCart() {
        CartManager.shared.clearCart()
    }
    
    /// API call to  retrive the item related to the cart ids provided
    ///
    /// - Parameters:
    ///   - itemIds: an array of item id from the cart
    ///   - storeId: the store id from the nearest store
    ///   - completion: success callback with the a list of items related to the cart ids passed
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func getRelatedItemsForCart(itemIds: [Int], storeId: Int, completion: ((CategoryItemsResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(itemIds: itemIds, storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Perform a reorder of an past order
    ///
    /// - Parameters:
    ///   - orderId: the id to the past order to reorder
    ///   - lat: latitude of the users location
    ///   - lng: longitude of the users location
    ///   - storeId: the store id of the nearest store
    ///   - completion: success callback with a list of items that are avaialble and unavaialble at the passed in store id
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func reorder(orderId: Int, lat: CLLocationDegrees, lng: CLLocationDegrees, storeId: Int,
                                                 completion: @escaping ((ReorderResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.reorder(orderId: orderId, userLocation: CLLocationCoordinate2D(latitude: lat, longitude: lng),
                                         storeId: storeId, completion: completion, failure: failure)
    }
    
}
