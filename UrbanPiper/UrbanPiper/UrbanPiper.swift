//
//  UrbanPiper.swift
//  UrbanPiper
//
//  Created by Vid on 24/10/18.
//

import UIKit
import CoreLocation

/// The primary class for integrating UrbanPiper in your app
public class UrbanPiper: NSObject {

    static internal(set) var shared: UrbanPiper!
    internal var callback:  (SDKEvent) -> Void
    
    /// Returns the shared instance that was initialized
    ///
    /// - Returns: returns the shared UrbanPiper instance
    @objc public static func sharedInstance() -> UrbanPiper {
        assert(shared != nil, "UrbanPiper has not been initialized, call initialize(bizId:apiUsername:apiKey) to initialize the SDK ")
        return shared
    }
    
    internal init(language: Language = .english, bizId: String, apiUsername: String, apiKey: String, session: URLSession? = nil, callback: @escaping (SDKEvent) -> Void) {
        self.callback = callback
        super.init()
        APIManager.initializeManager(language: language, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, jwt: UserManager.shared.currentUser?.jwt)
        guard let testSession = session else { return }
        APIManager.shared.session = testSession
    }
    
    /// Intializes the UrbanPiper, the initialized instance of the SDK is accessible via the static func sharedInstance()
    ///
    /// - Parameters:
    ///   - language: Optional. Default - english. The `Language` the server should send the data
    ///   - bizId: your business id from urbanpiper
    ///   - apiUsername: your api username from urbanpiper
    ///   - apiKey: your api key from urbanpiper
    ///   - callback: callback notifies about the `SDKEvent` that should be handled by the app
    public class func intialize(language: Language? = .english, bizId: String, apiUsername: String, apiKey: String, callback: @escaping (SDKEvent) -> Void) {
        shared = UrbanPiper(language: language!, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, callback: callback)
    }
    
    /// Change the `Language` of the data being returned from the server after the SDK has been initialized
    ///
    /// - Parameter language: The new `Language` the server should send the data
    public func change(language: Language) {
        APIManager.shared.language = language
    }
    
    /// The `Language` value that is sent to the server as part of the api call header
    ///
    /// - Returns: Current `Language` set in the SDK
    public func currentLanguage() -> Language {
        return APIManager.shared.language
    }

}

//  MARK: User

public extension UrbanPiper {

    /// Function returns the the saved `User` object for a logged in user and nil for a guest user
    ///
    /// - Returns: An instance of `User`
    @objc public func getUser() -> User? {
        return UserManager.shared.currentUser
    }

    /// Function returns a new instance of the helper class `RegistrationBuilder` that contains the api calls to perform a user registration
    ///
    /// - Returns: An instance of `RegistrationBuilder`
    public func startRegistration() -> RegistrationBuilder {
        return RegistrationBuilder()
    }
    
    /// Function returns a new instance of the helper class `SocialRegBuilder` that contains the api calls to perform a social user registration
    ///
    /// - Returns: An instance of `SocialRegBuilder`
    public func startSocialRegistration() -> SocialRegBuilder {
        return SocialRegBuilder()
    }
    
    /// Function returns a new instance of the helper class `ResetPasswordBuilder` that contains the api calls to perform a password reset
    ///
    /// - Returns: An instance of `ResetPasswordBuilder`
    public func startPasswordReset() -> ResetPasswordBuilder {
        return ResetPasswordBuilder()
    }
    
    /// Function to logout the user and remove all the user related data from memory and persistant storage
    public func logout() {
        UserManager.shared.logout()
    }
    
    /// API call to Log-in a registered user
    ///
    /// - Parameters:
    ///   - phone: Phone number provided by the user the user, should include the country code i.e (+91)
    ///   - password: Password provided by the user, should be atleast 6 chars long
    ///   - completion: `APICompletion` with `LoginResponse`, if the `LoginResponse.message` variable is "userbiz_phone_not_validated" the user's phone number has to verified by calling the `RegistrationBuilder.verifyRegOTP(...)`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func login(phone: String, password: String, completion: @escaping ((LoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.login(phone: phone, password: password, completion: completion, failure: failure)
    }
    
    /// API call to login an social login user
    ///
    /// - Parameters:
    ///   - email: The email id from the social login provider
    ///   - socialLoginProvider: The user selected `SocialLoginProvider`
    ///   - accessToken: The access token from the social login provider
    ///   - completion: `APICompletion` with `SocialLoginResponse`, if the value `SocialLoginResponse.message` variable is "phone_number_required" the user's phone number needs to be verified by calling the `SocialRegBuilder.verifyPhone(...)`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func socialLogin(email: String, socialLoginProvider: SocialLoginProvider, accessToken: String,
                                               completion: @escaping ((SocialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.socialLogin(email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, completion: completion, failure: failure)
    }
        
    /// API call to retrieve the updated user info from the server, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `UserInfoResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func refreshUserInfo(completion: ((UserInfoResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserInfo(completion: completion, failure: failure)
    }

    /// API call to retrieve the user's updated biz info (i.e. balance, points) from the server, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `UserBizInfoResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @objc @discardableResult public func refreshUserBizInfo(completion: ((UserBizInfoResponse?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserBizInfo(completion: completion, failure: failure)
    }

    /// API call to update the user info in the server, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - name: The new name string provided by user
    ///   - email: Optional. New email string provided by the user, this value cannot be changed for a social login user
    ///   - gender: Optional. New gender string provided by the user
    ///   - anniversary: Optional. New anniversary date provided by the user
    ///   - birthday: Optional. New birthday date provided by the user
    ///   - completion: `APICompletion` with `UserInfoUpdateResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func updateUserInfo(name: String? = nil, email: String? = nil, gender: String? = nil, aniversary: Date? = nil, birthday: Date? = nil,
                                                        completion: ((UserInfoUpdateResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }
        
        if user.provider != nil {
            assert(email == nil, "The email id cannot be changed for a social login user")
            guard email == nil else { return  nil }
        }
        
        return UserManager.shared.updateUserInfo(name: name ?? user.firstName, phone: user.phone, email: email ?? user.email, gender: gender, aniversary: aniversary, birthday: birthday, completion: completion, failure: failure)
    }
    
    /// API call to change the password of the user, the password cannot be changed for a social login user, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - phone: Phone number of the user
    ///   - oldPassword: Current password of the user
    ///   - newPassword: New password entered by the user
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @objc @discardableResult public func changePassword(phone: String, oldPassword: String, newPassword: String, completion: ((GenericResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }

        assert(user.provider == nil, "Password cannot be changed for a social login user")
        guard user.provider == nil else { return  nil }

        return UserManager.shared.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword, completion: completion, failure: failure)
    }
    
    /// Get the user's saved deliverable address for the provided store id, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - storeId: The store id from the nearest store to user's location `Store.bizLocationId`
    ///   - completion: `APICompletion` with `UserAddressesResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func getDeliverableAddresses(storeId: Int, completion: ((UserAddressesResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getDeliverableAddresses(storeId: storeId, completion: completion, failure: failure)
    }

    /// API call to add a new address to the user's saved addresses, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - address: The user's new address to be added
    ///   - completion: `APICompletion` with `AddUpdateAddressResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func addAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.addAddress(address: address, completion: { (addUpdateAddressResponse) in
            if UrbanPiper.sharedInstance().responds(to: Selector(("addAddress:"))) {
                let newAddress = address
                newAddress.id = addUpdateAddressResponse?.addressId

                UrbanPiper.sharedInstance().performSelector(onMainThread: Selector(("addAddress:")), with: newAddress, waitUntilDone: false)
            }
            completion?(addUpdateAddressResponse)
        }, failure: failure)
    }
    
    /// API call to update the user's address, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - address: The user's updated address
    ///   - completion: `APICompletion` with `AddUpdateAddressResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func updateAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.updateAddress(address: address, completion: completion, failure: failure)
    }
    
    /// API call to delete the user's address, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - addressId: The id of the address to be deleted
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func deleteAddress(addressId: Int, completion: ((GenericResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.deleteAddress(addressId: addressId, completion: { (genericResponse) in
            if UrbanPiper.sharedInstance().responds(to: Selector(("deleteAddress:"))) {
                UrbanPiper.sharedInstance().performSelector(onMainThread: Selector(("deleteAddress:")), with: addressId, waitUntilDone: false)
            }
            completion?(genericResponse)
        }, failure: failure)
    }
    
    /// Get the user's wallet transactions, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - offset: The Pagination offset
    ///   - limit: The Pagination limit
    ///   - completion: `APICompletion` with `WalletTransactionResponse` containing the list of user's wallet `Transaction` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getWalletTransactions(offset: Int = 0, limit: Int? = nil, completion: ((WalletTransactionResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getWalletTransactions(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    /// Get the user's past orders, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `PastOrdersResponse` containing the list of user's `PastOrder` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func getPastOrders(completion: ((PastOrdersResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getPastOrders(completion: completion, failure: failure)
    }

    /// Get the user's past order details, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - orderId: The past order id for which the details are to be retrieved
    ///   - completion: `APICompletion` with `PastOrderDetailsResponse` containing the details of the provided past order id
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func getPastOrderDetails(orderId: Int, completion: ((PastOrderDetailsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getPastOrderDetails(orderId: orderId, completion: completion, failure: failure)
    }

    /// API call to reedem the reward available from the `getRewards(...)` API call, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - rewardId: The reward id to be reedemed
    ///   - completion: `APICompletion` with `RedeemRewardResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func redeemReward(rewardId: Int, completion: ((RedeemRewardResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.redeemReward(rewardId: rewardId, completion: completion, failure: failure)
    }
    
    /// Get the list of user's notfications, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `NotificationsResponse` containing the list of user's Notification `Message` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getNotifications(completion: ((NotificationsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getNotifications(completion: completion, failure: failure)
    }

    /// Use this method to submit the feedback for an completed order, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - name: Name of the user
    ///   - orderId: The order id for which the feedback is to submitted
    ///   - rating: The rating provided by the user
    ///   - choiceText: The choice text selected by the user, feedback options are available in `Biz.feedbackConfig`
    ///   - comments: The comments provided by the user
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func submitFeedback(name: String, rating: Double, orderId: Int, choiceText: String?, comments: String?,
                                                  completion: ((GenericResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.submitFeedback(name: name, rating: rating, orderId: orderId, choiceText: choiceText, comments: comments, completion: completion, failure: failure)
    }

    /// Get the items that where liked by the user, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - offset: The Pagination offset
    ///   - limit: The Pagination limit
    ///   - completion: `APICompletion` with `UserLikesResponse` containing the user's `Like` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getItemLikes(offset: Int = 0, limit: Int? = nil, completion: @escaping ((UserLikesResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.userLikes(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    /// API call to like an item, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - itemId: The item id to be liked
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func likeItem(itemId: Int, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.likeItem(itemId: itemId, completion: completion, failure: failure)
    }
    
    /// API call to unlike an item, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - itemId: The item id to unlike
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func unlikeItem(itemId: Int, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.unlikeItem(itemId: itemId, completion: completion, failure: failure)
    }

    /// API call to initate a wallet reload, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - amount: The amount to be reloaded into the wallet
    ///   - completion: `APICompletion` with `PaymentInitResponse`, the response contains the payment gateway details
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
    
    /// API call to verify the wallet reload completed using a payment gateway
    ///
    /// - Parameters:
    ///   - pid: The payment id from the payment completion response of payment gateway
    ///   - transactionId: The transcation id from the `initWalletReload(...)` response
    ///   - completion: `APICompletion` with `OrderVerifyTxnResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func verifyWalletReload(paymentId: String,
                                                       transactionId: String,
                                                       completion: @escaping ((OrderVerifyTxnResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.verifyPayment(pid: paymentId, orderId: OnlinePaymentPurpose.reload.rawValue, transactionId: transactionId, completion: completion, failure: failure)
    }

}


//  MARK: General

extension UrbanPiper {
    
    /// Register the fcm token in urbanpiper server to receive the push notifications
    ///
    /// - Parameters:
    ///   - token: The token from google's FirebaseMessaging
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func registerFCMToken(token: String, completion: ((GenericResponse?) -> Void)? = nil,
                                                    failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.registerForFCMToken(token: token, completion: completion, failure: failure)
    }
    
    /// API call to  perform an version check with the urbanpiper server to indi
    ///
    /// - Parameters:
    ///   - version: The current version of the app
    ///   - completion: `APICompletion` with `VersionCheckResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func checkAppVersion(version: String, completion: ((VersionCheckResponse?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.checkAppVersion(username: UserManager.shared.currentUser?.username, version: version, completion: completion, failure: failure)
    }
    
    /// API call used to get the nearest store to the provided lat lng
    ///
    /// - Parameters:
    ///   - lat: User's location latitude
    ///   - lng: User's location longitude
    ///   - completion: `APICompletion` with `StoreResponse` containing the Biz details and the nearest store
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getNearestStore(lat: CLLocationDegrees, lng: CLLocationDegrees,
                                                   completion: @escaping ((StoreResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getNearestStore(CLLocationCoordinate2DMake(lat, lng), completion: completion, failure: failure)
    }
    
    /// Get all the stores registered for the business
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with StoreListResponse containing the business stores as a list of `Store` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func getAllStores(completion: @escaping ((StoreListResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getAllStores(completion: completion, failure: failure)
    }
    
}


//  MARK: Catalogue

extension UrbanPiper {
    
    /// Get the list of categories set up for the business
    ///
    /// - Parameters:
    ///   - storeId: Optional. the nearest store id
    ///   - offset: Pagination offset
    ///   - limit: Pagination limit
    ///   - completion: `APICompletion` with a list of categories set up for the business
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getCategories(storeId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((CategoriesResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getCategories(storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Get the items for a given category
    ///
    /// - Parameters:
    ///   - categoryId: category id to retrieve the items for
    ///   - storeId: Optional. the store id from the nearest store
    ///   - filterBy: An array of `FilterOption` selected by the user from `getFilterAndSortOptions(...)` api call
    ///   - sortBy: A sort option string selected by the user from `getFilterAndSortOptions(...)` api call
    ///   - offset: Pagination offset
    ///   - limit: Pagination limit
    ///   - completion: `APICompletion` with `CategoryItemsResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getCategoryItems(categoryId: Int, storeId: Int?, filterBy: [FilterOption]? = nil, sortBy: String? = nil, offset: Int = 0, limit: Int? = nil,
                                                    completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getCategoryItems(categoryId: categoryId, storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit, sortKey: sortBy, filterOptions: filterBy, completion: completion, failure: failure)
    }

    /// API call to search items for a keyword
    ///
    /// - Parameters:
    ///   - query: The user entered keyword to filter the items by
    ///   - storeId: The store id from the nearest store
    ///   - offset: Pagination offset
    ///   - limit: Pagination limit
    ///   - completion: `APICompletion` with the list of items for a the query
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func searchItems(query: String, storeId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((ItemsSearchResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.searchItems(query: query, storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    /// Get the filter and sort options for a category
    ///
    /// - Parameters:
    ///   - categoryid: Category id for which the filter and sort options are to retrieved
    ///   - completion: `APICompletion` with `CategoryOptionsResponse` containing the list of `FilterOption` objects and a list of sort options
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getFilterAndSortOptions(categoryId: Int, completion: @escaping ((CategoryOptionsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFilterAndSortOptions(id: categoryId, completion: completion, failure:failure)
    }

    /// Get the item details for a given item id
    ///
    /// - Parameters:
    ///   - itemId: Item id to retrieve the item details for
    ///   - storeId: Optional. The store id of the nearest store
    ///   - completion: `APICompletion` with `Item` object containing the item details of the provided item id
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getItemDetails(itemId: Int, storeId: Int?, completion: @escaping ((Item?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getItemDetails(itemId: itemId, storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Get the list of featured items
    ///
    /// - Parameters:
    ///   - storeId: Store id of the nearest store
    ///   - completion: `APICompletion` with a list of featured items
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getFeaturedItems(storeId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Get the list of associated items for the provided item id
    ///
    /// - Parameters:
    ///   - itemId: The item id to retrieve the associated items for
    ///   - storeId: Store id of the nearest store
    ///   - completion: `APICompletion` with `CategoryItemsResponse` containing the list of `Item` objects associated with the given item id
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getAssociatedItems(itemId: Int, storeId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(itemIds: [itemId], storeId: storeId, completion: completion, failure: failure)
    }
}

//  MARK: Promotions

extension UrbanPiper {
    
    /// Get the list of rewards from the server
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `RewardsResponse` containing the list of `Reward` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func getRewards(completion: @escaping ((RewardsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.getRewards(completion: completion, failure: failure)
    }
    
    /// Get the list of offers from the server
    ///
    /// - Parameters:
    ///   - offset: Pagination offset
    ///   - limit: Pagination limit
    ///   - completion: `APICompletion` with a list of `Coupon` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getOffers(offset: Int = 0, limit: Int? = nil, completion: @escaping ((OffersAPIResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getOffers(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    /// Get the list of banners from the server
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `BannersResponse` containing the list of `BannerImage` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getBanners(completion: @escaping ((BannersResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getBanners(completion: completion, failure: failure)
    }
    
}

//  MARK: Cart

extension UrbanPiper {
    
    /// Function returns a new instance of the helper class `CheckoutBuilder` that contains the api calls to place an order
    ///
    /// - Returns: An instance of CheckoutBuilder
    public func startCheckout() -> CheckoutBuilder {
        return CheckoutBuilder()
    }
    
    /// Returns a list of items added to the cart
    ///
    /// - Returns: An instance of an array that contains the list of items added to the cart
    public func getCartItems() -> [CartItem] {
        return CartManager.shared.cartItems
    }
    
    /// Returns the total item quantity of the cart
    ///
    /// - Returns: Return an int value
    public func getCartCount() -> Int {
        return CartManager.shared.cartCount
    }
    
    /// Returns the item quantity added to the cart for a given item id
    ///
    /// - Parameter itemId: Item id to get the cart quantity for
    /// - Returns: Returns an int value
    public func getItemCountFor(itemId: Int) -> Int {
        return CartManager.shared.cartCount(for: itemId)
    }
    
    /// The total value of the cart factoring the item quantities and the options selected
    ///
    /// - Returns: Returns an Decimal value representing the total value of the cart
    @objc public func getCartValue() -> Decimal {
        return CartManager.shared.cartValue
    }
    
    /// Function call to add an cart item to the cart with the quantity to be added and the notes for the item
    ///
    /// - Parameters:
    ///   - cartItem: The cart item to be added
    ///   - quantity: The quantity of the item to be added
    ///   - notes: The notes for the item to be added
    /// - Throws: Throws the error "itemQuantityNotAvaialble" if the quantity to be added + the current item quantity exceeds the variable value `Item.currentStock` in `Item` object, the associated value of the enum returns the max item quanity that can be added.
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
    ///   - itemId: The id of the item to remove
    ///   - quantity: The quantity to reduce from the item
    public func removeItemFromCart(itemId: Int, quantity: Int) {
        CartManager.shared.remove(itemId: itemId, quantity: quantity)
    }
    
    /// API call to clear all the items in the cart
    @objc public func clearCart() {
        CartManager.shared.clearCart()
    }
    
    /// API call to  retrieve the item related to the cart ids provided
    ///
    /// - Parameters:
    ///   - itemIds: An array of item id from the cart
    ///   - storeId: The store id from the nearest store
    ///   - completion: `APICompletion` with `CategoryItemsResponse` containing the list of `Item` objects related to the cart ids passed
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getRelatedItemsForCart(itemIds: [Int], storeId: Int, completion: ((CategoryItemsResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(itemIds: itemIds, storeId: storeId, completion: completion, failure: failure)
    }
    
    /// Perform a reorder of an past order
    ///
    /// - Parameters:
    ///   - orderId: The id of the past order to be reordered
    ///   - lat: Latitude of the user's location
    ///   - lng: Longitude of the user's location
    ///   - storeId: The store id of the nearest store
    ///   - completion: `APICompletion` with a list of items that are avaialble and unavaialble at the passed in store id
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func reorder(orderId: Int, lat: CLLocationDegrees, lng: CLLocationDegrees, storeId: Int,
                                                 completion: @escaping ((ReorderResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        return APIManager.shared.reorder(orderId: orderId, userLocation: CLLocationCoordinate2D(latitude: lat, longitude: lng),
                                         storeId: storeId, completion: completion, failure: failure)
    }
    
}
