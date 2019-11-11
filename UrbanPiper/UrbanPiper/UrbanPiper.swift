//
//  UrbanPiper.swift
//  UrbanPiper
//
//  Created by Vid on 24/10/18.
//

import CoreLocation
import RxSwift
import UIKit

/// The primary class for integrating UrbanPiper in your app
public class UrbanPiper: NSObject {    
    static var shared: UrbanPiper!
    internal var callback: (SDKEvent) -> Void

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
        SharedPreferences.language = language
        APIManager.initializeManager(bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, jwt: UserManager.shared.currentUser?.jwt)
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
        shared = UrbanPiper(language: language ?? .english, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, callback: callback)
    }

    /// Change the `Language` of the data being returned from the server after the SDK has been initialized
    ///
    /// - Parameter language: The new `Language` the server should send the data
    public func change(language: Language) {
        SharedPreferences.language = language
    }

    /// The `Language` value that is sent to the server as part of the api call header
    ///
    /// - Returns: Current `Language` set in the SDK
    public func currentLanguage() -> Language {
        SharedPreferences.language
    }
}

//  MARK: User

public extension UrbanPiper {
    /// Function returns the the saved `User` object for a logged in user and nil for a guest user
    ///
    /// - Returns: An instance of `User`
    @objc func getUser() -> User? {
        UserManager.shared.currentUser
    }

    /// Function returns a new instance of the helper class `RegistrationBuilder` that contains the api calls to perform a user registration
    ///
    /// - Returns: An instance of `RegistrationBuilder`
    func startRegistration() -> RegistrationBuilder {
        RegistrationBuilder()
    }

    /// Function returns a new instance of the helper class `SocialRegBuilder` that contains the api calls to perform a social user registration
    ///
    /// - Returns: An instance of `SocialRegBuilder`
    func startSocialRegistration() -> SocialRegBuilder {
        SocialRegBuilder()
    }

    /// Function returns a new instance of the helper class `ResetPasswordBuilder` that contains the api calls to perform a password reset
    ///
    /// - Returns: An instance of `ResetPasswordBuilder`
    func startPasswordReset() -> ResetPasswordBuilder {
        ResetPasswordBuilder()
    }

    /// Function to logout the user and remove all the user related data from memory and persistant storage
    func logout() {
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
    @discardableResult func login(phone: String, password: String, completion: @escaping APICompletion<LoginResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        UserManager.shared.login(phone: phone, password: password, completion: completion, failure: failure)
    }

    func login(phone: String, password: String) -> Observable<LoginResponse> {
        UserManager.shared.login(phone: phone, password: password)
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
    @discardableResult func socialLogin(name: String?, email: String?, socialLoginProvider: SocialLoginProvider, accessToken: String,
                                        completion: @escaping APICompletion<SocialLoginResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        UserManager.shared.socialLogin(name: name, email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, completion: completion, failure: failure)
    }

    func socialLogin(name: String?, email: String?, socialLoginProvider: SocialLoginProvider, accessToken: String) -> Observable<SocialLoginResponse> {
        UserManager.shared.socialLogin(name: name, email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken)
    }

    /// API call to retrieve the updated user info from the server, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `UserInfoResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func refreshUserInfo(completion: APICompletion<UserInfoResponse>?, failure: APIFailure?) -> URLSessionDataTask? {
        UserManager.shared.refreshUserInfo(completion: completion, failure: failure)
    }

    func refreshUserInfo() -> Observable<UserInfoResponse>? {
        UserManager.shared.refreshUserInfo()
    }

    /// API call to retrieve the user's updated biz info (i.e. balance, points) from the server, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `UserBizInfoResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @objc @discardableResult func refreshUserBizInfo(completion: APICompletion<UserBizInfoResponse>? = nil, failure: APIFailure? = nil) -> URLSessionDataTask? {
        UserManager.shared.refreshUserBizInfo(completion: completion, failure: failure)
    }

    func refreshUserBizInfo() -> Observable<UserBizInfoResponse>? {
        UserManager.shared.refreshUserBizInfo()
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
    @discardableResult @objc func updateUserInfo(name: String? = nil, email: String? = nil, gender: String? = nil, aniversary: Date? = nil, birthday: Date? = nil,
                                                 completion: APICompletion<UserInfoUpdateResponse>?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }

        if user.provider != nil {
            assert(email == nil, "The email id cannot be changed for a social login user")
            guard email == nil else { return nil }
        }

        return UserManager.shared.updateUserInfo(name: name ?? user.firstName, phone: user.phone, email: email ?? user.email, gender: gender, aniversary: aniversary, birthday: birthday, completion: completion, failure: failure)
    }

    func updateUserInfo(name: String? = nil, email: String? = nil, gender: String? = nil, aniversary: Date? = nil, birthday: Date? = nil) -> Observable<UserInfoUpdateResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }

        if user.provider != nil {
            assert(email == nil, "The email id cannot be changed for a social login user")
            guard email == nil else { return nil }
        }

        return UserManager.shared.updateUserInfo(name: name ?? user.firstName, phone: user.phone, email: email ?? user.email, gender: gender, aniversary: aniversary, birthday: birthday)
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
    @objc @discardableResult func changePassword(phone: String, oldPassword: String, newPassword: String, completion: APICompletion<GenericResponse>?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }

        assert(user.provider == nil, "Password cannot be changed for a social login user")
        guard user.provider == nil else { return nil }

        return UserManager.shared.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword, completion: completion, failure: failure)
    }

    func changePassword(phone: String, oldPassword: String, newPassword: String) -> Observable<GenericResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard let user = getUser() else { return nil }

        assert(user.provider == nil, "Password cannot be changed for a social login user")
        guard user.provider == nil else { return nil }

        return UserManager.shared.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword)
    }

    /// Get the user's saved deliverable address for the provided store id, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - storeId: The store id from the nearest store to user's location `Store.bizLocationid`
    ///   - completion: `APICompletion` with `UserAddressesResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func getDeliverableAddresses(storeId: String?, completion: APICompletion<UserAddressesResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.deliverableAddresses(storeId: storeId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getDeliverableAddresses(storeId: String?) -> Observable<UserAddressesResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.deliverableAddresses(storeId: storeId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to add a new address to the user's saved addresses, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - address: The user's new address to be added
    ///   - completion: `APICompletion` with `AddUpdateAddressResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func addAddress(address: Address, completion: APICompletion<AddUpdateAddressResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.addAddress(address: address)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func addAddress(address: Address) -> Observable<AddUpdateAddressResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.addAddress(address: address)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to update the user's address, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - address: The user's updated address
    ///   - completion: `APICompletion` with `AddUpdateAddressResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult func updateAddress(address: Address, completion: APICompletion<AddUpdateAddressResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.updateAddress(address: address)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func updateAddress(address: Address) -> Observable<AddUpdateAddressResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.updateAddress(address: address)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to delete the user's address, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - addressId: The id of the address to be deleted
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func deleteAddress(addressId: Int, completion: APICompletion<GenericResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.deleteAddress(addressId: addressId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func deleteAddress(addressId: Int) -> Observable<GenericResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = UserAPI.deleteAddress(addressId: addressId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the user's wallet transactions, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - offset: The Pagination offset
    ///   - limit: The Pagination limit
    ///   - completion: `APICompletion` with `WalletTransactionResponse` containing the list of user's wallet `Transaction` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult func getWalletTransactions(offset: Int = 0, limit: Int? = nil, completion: APICompletion<WalletTransactionResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = WalletAPI.walletTransactions(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getWalletTransactions(offset: Int = 0, limit: Int? = nil) -> Observable<WalletTransactionResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = WalletAPI.walletTransactions(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the user's past orders, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `PastOrdersResponse` containing the list of user's `PastOrder` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func getPastOrders(offset: Int = 0,
                                                limit: Int = 20,
                                                completion: APICompletion<PastOrdersResponse>?,
                                                failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = PastOrdersAPI.pastOrders(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getPastOrders(offset: Int = 0,
                       limit: Int? = nil) -> Observable<PastOrdersResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = PastOrdersAPI.pastOrders(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the user's past order details, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - orderId: The past order id for which the details are to be retrieved
    ///   - completion: `APICompletion` with `PastOrderDetailsResponse` containing the details of the provided past order id
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func getPastOrderDetails(orderId: Int, completion: APICompletion<PastOrderDetailsResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = PastOrdersAPI.pastOrderDetails(orderId: orderId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getPastOrderDetails(orderId: Int) -> Observable<PastOrderDetailsResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = PastOrdersAPI.pastOrderDetails(orderId: orderId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to reedem the reward available from the `getRewards(...)` API call, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - rewardId: The reward id to be reedemed
    ///   - completion: `APICompletion` with `RedeemRewardResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func redeemReward(rewardId: Int, completion: APICompletion<RedeemRewardResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = RewardsAPI.reedemRewards(rewardId: rewardId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func redeemReward(rewardId: Int) -> Observable<RedeemRewardResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = RewardsAPI.reedemRewards(rewardId: rewardId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the list of user's notfications, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `NotificationsResponse` containing the list of user's Notification `Message` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult func getNotifications(offset: Int = 0,
                                             limit: Int? = nil,
                                             completion: APICompletion<NotificationsResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = NotificationsAPI.notifications(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getNotifications(offset: Int = 0,
                          limit: Int? = nil) -> Observable<NotificationsResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = NotificationsAPI.notifications(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
    @discardableResult @objc func submitFeedback(name: String, rating: Double, orderId: Int, choiceText: String?, comments: String?,
                                                 completion: APICompletion<GenericResponse>?, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = FeedbackAPI.submitFeedback(name: name, rating: rating, orderId: orderId, choiceText: choiceText, comments: comments)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func submitFeedback(name: String, rating: Double, orderId: Int, choiceText: String?, comments: String?) -> Observable<GenericResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = FeedbackAPI.submitFeedback(name: name, rating: rating, orderId: orderId, choiceText: choiceText, comments: comments)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the items that where liked by the user, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - offset: The Pagination offset
    ///   - limit: The Pagination limit
    ///   - completion: `APICompletion` with `UserLikesResponse` containing the user's `Like` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult func getItemLikes(offset _: Int = 0, limit _: Int? = nil, completion: @escaping APICompletion<UserLikesResponse>, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ItemLikesAPI.userLikes
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getItemLikes(offset _: Int = 0, limit _: Int? = nil) -> Observable<UserLikesResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ItemLikesAPI.userLikes
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to like an item, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - itemId: The item id to be liked
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult func likeItem(itemId: Int, completion: @escaping APICompletion<GenericResponse>, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ItemLikesAPI.likeItem(itemId: itemId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func likeItem(itemId: Int) -> Observable<GenericResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ItemLikesAPI.likeItem(itemId: itemId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to unlike an item, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - itemId: The item id to unlike
    ///   - completion: `APICompletion` with `GenericResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult func unlikeItem(itemId: Int, completion: @escaping APICompletion<GenericResponse>, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ItemLikesAPI.unlikeItem(itemId: itemId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func unlikeItem(itemId: Int) -> Observable<GenericResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ItemLikesAPI.unlikeItem(itemId: itemId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to initate a wallet reload, user needs to be logged in to make this call
    ///
    /// - Parameters:
    ///   - amount: The amount to be reloaded into the wallet
    ///   - completion: `APICompletion` with `PaymentInitResponse`, the response contains the payment gateway details
    ///   - failure: Return an instance of URLSessionDataTask
    @discardableResult @objc func initWalletReload(amount: Double,
                                                   completion: APICompletion<PaymentInitResponse>?,
                                                   failure: APIFailure?) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let paymentOption = PaymentOption.paymentGateway
        let upAPI = PaymentsAPI.initiateWalletReload(paymentOption: paymentOption, totalAmount: amount)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func initWalletReload(amount: Double) -> Observable<PaymentInitResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let paymentOption = PaymentOption.paymentGateway
        let upAPI = PaymentsAPI.initiateWalletReload(paymentOption: paymentOption, totalAmount: amount)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to verify the wallet reload completed using a payment gateway
    ///
    /// - Parameters:
    ///   - pid: The payment id from the payment completion response of payment gateway
    ///   - transactionId: The transcation id from the `initWalletReload(...)` response
    ///   - completion: `APICompletion` with `OrderVerifyTxnResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc func verifyWalletReload(paymentId: String,
                                                     transactionId: String,
                                                     completion: @escaping APICompletion<OrderVerifyTxnResponse>, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = PaymentsAPI.verifyPayment(pid: paymentId, orderId: OnlinePaymentPurpose.reload.rawValue, transactionId: transactionId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func verifyWalletReload(paymentId: String, transactionId: String) -> Observable<OrderVerifyTxnResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = PaymentsAPI.verifyPayment(pid: paymentId, orderId: OnlinePaymentPurpose.reload.rawValue, transactionId: transactionId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
    @discardableResult public func registerFCMToken(token: String, completion: APICompletion<GenericResponse>? = nil,
                                                    failure: APIFailure? = nil) -> URLSessionDataTask {
        let upAPI = FCMAPI.registerForFCM(token: token)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func registerFCMToken(token: String) -> Observable<GenericResponse> {
        let upAPI = FCMAPI.registerForFCM(token: token)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// API call to  perform an version check with the urbanpiper server to indi
    ///
    /// - Parameters:
    ///   - version: The current version of the app
    ///   - completion: `APICompletion` with `VersionCheckResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func checkAppVersion(version: String, completion: APICompletion<VersionCheckResponse>? = nil, failure: APIFailure? = nil) -> URLSessionDataTask {
        let upAPI = VersionCheckAPI.checkVersion(username: UserManager.shared.currentUser?.username, version: version)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func checkAppVersion(version: String) -> Observable<VersionCheckResponse> {
        let upAPI = VersionCheckAPI.checkVersion(username: UserManager.shared.currentUser?.username, version: version)
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
                                                   completion: @escaping APICompletion<StoreResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = StoreAPI.nearestStore(coordinates: CLLocationCoordinate2DMake(lat, lng))
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    @discardableResult public func getNearestStore(lat: CLLocationDegrees, lng: CLLocationDegrees) -> Observable<StoreResponse> {
        let upAPI = StoreAPI.nearestStore(coordinates: CLLocationCoordinate2DMake(lat, lng))
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get all the stores registered for the business
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with StoreListResponse containing the business stores as a list of `Store` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func getAllStores(completion: @escaping APICompletion<StoreListResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = StoreAPI.stores
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    public func getAllStores() -> Observable<StoreListResponse> {
        let upAPI = StoreAPI.stores
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
    @discardableResult public func getCategories(storeId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping APICompletion<CategoriesResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = CategoriesAPI.categories(storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getCategories(storeId: Int?, offset: Int = 0, limit: Int? = nil) -> Observable<CategoriesResponse> {
        let upAPI = CategoriesAPI.categories(storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
                                                    completion: @escaping APICompletion<CategoryItemsResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = ItemsAPI.categoryItems(categoryId: categoryId, storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit, sortKey: sortBy, filterOptions: filterBy)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getCategoryItems(categoryId: Int, storeId: Int?, filterBy: [FilterOption]? = nil, sortBy: String? = nil, offset: Int = 0, limit: Int? = nil) -> Observable<CategoryItemsResponse> {
        let upAPI = ItemsAPI.categoryItems(categoryId: categoryId, storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit, sortKey: sortBy, filterOptions: filterBy)
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
    @discardableResult public func searchItems(query: String, storeId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping APICompletion<ItemsSearchResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = ItemsAPI.searchItems(query: query, storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func searchItems(query: String, storeId: Int?, offset: Int = 0, limit: Int? = nil) -> Observable<ItemsSearchResponse> {
        let upAPI = ItemsAPI.searchItems(query: query, storeId: storeId, offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the filter and sort options for a category
    ///
    /// - Parameters:
    ///   - categoryid: Category id for which the filter and sort options are to retrieved
    ///   - completion: `APICompletion` with `CategoryOptionsResponse` containing the list of `FilterOption` objects and a list of sort options
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getFilterAndSortOptions(categoryId: Int, completion: @escaping APICompletion<CategoryOptionsResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = ItemsAPI.filterAndSortOptions(categoryId: categoryId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getFilterAndSortOptions(categoryId: Int) -> Observable<CategoryOptionsResponse> {
        let upAPI = ItemsAPI.filterAndSortOptions(categoryId: categoryId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the item details for a given item id
    ///
    /// - Parameters:
    ///   - itemId: Item id to retrieve the item details for
    ///   - storeId: Optional. The store id of the nearest store
    ///   - completion: `APICompletion` with `Item` object containing the item details of the provided item id
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getItemDetails(itemId: Int, storeId: Int?, completion: @escaping APICompletion<Item>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = ItemsAPI.itemDetails(itemId: itemId, storeId: storeId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getItemDetails(itemId: Int, storeId: Int?) -> Observable<Item> {
        let upAPI = ItemsAPI.itemDetails(itemId: itemId, storeId: storeId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the list of featured items
    ///
    /// - Parameters:
    ///   - storeId: Store id of the nearest store
    ///   - completion: `APICompletion` with a list of featured items
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getFeaturedItems(storeId: Int, completion: @escaping APICompletion<CategoryItemsResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = ItemsAPI.featuredItems(storeId: storeId, offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getFeaturedItems(storeId: Int) -> Observable<CategoryItemsResponse> {
        let upAPI = ItemsAPI.featuredItems(storeId: storeId, offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the list of associated items for the provided item id
    ///
    /// - Parameters:
    ///   - itemId: The item id to retrieve the associated items for
    ///   - storeId: Store id of the nearest store
    ///   - completion: `APICompletion` with `CategoryItemsResponse` containing the list of `Item` objects associated with the given item id
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getAssociatedItems(itemId: Int, storeId: Int, completion: @escaping APICompletion<CategoryItemsResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = ItemsAPI.associatedItems(itemId: itemId, storeId: storeId, offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getAssociatedItems(itemId: Int, storeId: Int) -> Observable<CategoryItemsResponse> {
        let upAPI = ItemsAPI.associatedItems(itemId: itemId, storeId: storeId, offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
    @discardableResult @objc public func getRewards(completion: @escaping APICompletion<RewardsResponse>, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = RewardsAPI.rewards(offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getRewards() -> Observable<RewardsResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = RewardsAPI.rewards(offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the list of offers from the server
    ///
    /// - Parameters:
    ///   - offset: Pagination offset
    ///   - limit: Pagination limit
    ///   - completion: `APICompletion` with a list of `Coupon` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getOffers(offset: Int = 0, limit: Int? = nil, completion: @escaping APICompletion<OffersAPIResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = OffersAPI.offers(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getOffers(offset: Int = 0, limit: Int? = nil) -> Observable<OffersAPIResponse> {
        let upAPI = OffersAPI.offers(offset: offset, limit: limit ?? Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    /// Get the list of banners from the server
    ///
    /// - Parameters:
    ///   - completion: `APICompletion` with `BannersResponse` containing the list of `BannerImage` objects
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func getBanners(completion: @escaping APICompletion<BannersResponse>, failure: @escaping APIFailure) -> URLSessionDataTask {
        let upAPI = BannersAPI.banners
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getBanners() -> Observable<BannersResponse> {
        let upAPI = BannersAPI.banners
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
}

//  MARK: Cart

extension UrbanPiper {
    /// Function returns a new instance of the helper class `CheckoutBuilder` that contains the api calls to place an order
    ///
    /// - Returns: An instance of CheckoutBuilder
    public func startCheckout() -> CheckoutBuilder {
        CheckoutBuilder()
    }

    /// Returns a list of items added to the cart
    ///
    /// - Returns: An instance of an array that contains the list of items added to the cart
    public func getCartItems() -> [CartItem] {
        CartManager.shared.cartItems
    }

    /// Returns the total item quantity of the cart
    ///
    /// - Returns: Return an int value
    public func getCartCount() -> Int {
        CartManager.shared.cartCount
    }

    /// Returns the item quantity added to the cart for a given item id
    ///
    /// - Parameter itemId: Item id to get the cart quantity for
    /// - Returns: Returns an int value
    public func getItemCountFor(itemId: Int) -> Int {
        CartManager.shared.cartCount(for: itemId)
    }

    /// The total value of the cart factoring the item quantities and the options selected
    ///
    /// - Returns: Returns an Decimal value representing the total value of the cart
    @objc public func getCartValue() -> Double {
        CartManager.shared.cartValue
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
    @discardableResult public func getRelatedItemsForCart(itemIds: [Int], storeId: Int, completion: APICompletion<CategoryItemsResponse>?, failure: APIFailure?) -> URLSessionDataTask {
        let upAPI = ItemsAPI.relatedItems(itemIds: itemIds, storeId: storeId, offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func getRelatedItemsForCart(itemIds: [Int], storeId: Int) -> Observable<CategoryItemsResponse> {
        let upAPI = ItemsAPI.relatedItems(itemIds: itemIds, storeId: storeId, offset: 0, limit: Constants.fetchLimit)
        return APIManager.shared.apiObservable(upAPI: upAPI)
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
                                                 completion: @escaping APICompletion<ReorderResponse>, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ReorderAPI.reorder(orderId: orderId, userLocation: CLLocationCoordinate2D(latitude: lat, longitude: lng), storeId: storeId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    func reorder(orderId: Int, lat: CLLocationDegrees, lng: CLLocationDegrees, storeId: Int) -> Observable<ReorderResponse>? {
        assert(getUser() != nil, "The user has to logged in to call this function")
        guard getUser() != nil else { return nil }

        let upAPI = ReorderAPI.reorder(orderId: orderId, userLocation: CLLocationCoordinate2D(latitude: lat, longitude: lng), storeId: storeId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }
}
