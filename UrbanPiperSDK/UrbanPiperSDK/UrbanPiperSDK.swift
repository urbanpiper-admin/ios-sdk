//
//  UrbanPiperSDK.swift
//  UrbanPiperSDK
//
//  Created by Vid on 24/10/18.
//

import UIKit
import CoreLocation

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

    func startRegistration(phone: String) -> RegistrationBuilder {
        return RegistrationBuilder()
    }
    
    func startSocialRegistration() -> SocialRegBuilder {
        return SocialRegBuilder()
    }
    
    func startPasswordReset() -> ResetPasswordBuilder {
        return ResetPasswordBuilder()
    }
    
    func logout() {
        UserManager.shared.logout()
    }
    
    @discardableResult public func login(username: String, password: String, completion: @escaping ((LoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.login(username: username, password: password, completion: completion, failure: failure)
    }
    
    @discardableResult public func socialLogin(email: String, socialLoginProvider: SocialLoginProvider, accessToken: String,
                                               completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.socialLogin(email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, completion: completion, failure: failure)
    }
        
    @discardableResult @objc public func refreshUserInfo(completion: ((UserInfoResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserInfo(completion: completion, failure: failure)
    }

    @discardableResult public func refreshUserBizInfo(completion: ((UserBizInfoResponse?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserBizInfo(completion: completion, failure: failure)
    }

    @discardableResult @objc public func updateUserInfo(name: String, phone: String, email: String, gender: String?, anniversary: Date?, birthday: Date?,
                                                        completion: ((UserInfoUpdateResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        return UserManager.shared.updateUserInfo(name: name, phone: phone, email: email, gender: gender, completion: completion, failure: failure)
    }
    
    @discardableResult public func changePassword(phone: String, oldPassword: String, newPassword: String, completion: ((GenericResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword, completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func getDeliverableAddresses(locationId: Int, completion: ((UserAddressesResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getDeliverableAddresses(locationId: locationId, completion: completion, failure: failure)
    }

    @discardableResult @objc public func addAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.addAddress(address: address, completion: completion, failure: failure)
    }
    
    @discardableResult public func updateAddress(address: Address, completion: ((AddUpdateAddressResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.updateAddress(address: address, completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func deleteAddress(addressId: Int, completion: ((GenericResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.deleteAddress(addressId: addressId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getWalletTransactions(addressId: Int, completion: ((WalletTransactionResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getWalletTransactions(completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func getPastOrders(completion: ((PastOrdersResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getPastOrders(completion: completion, failure: failure)
    }

    @discardableResult @objc public func getPastOrderDetails(orderId: Int, completion: ((PastOrderDetailsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getPastOrderDetails(orderId: orderId, completion: completion, failure: failure)
    }

    @discardableResult @objc public func redeemReward(rewardId: Int, completion: ((RedeemRewardResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.redeemReward(rewardId: rewardId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getNotifications(completion: ((NotificationsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getNotifications(completion: completion, failure: failure)
    }

    @discardableResult @objc public func submitFeedback(name: String, orderId: String, rating: Double, choiceText: String?, comments: String?,
                                                  completion: ((GenericResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.submitFeedback(name: name, rating: rating, orderId: orderId, choiceText: choiceText, comments: comments, completion: completion, failure: failure)
    }

    @discardableResult public func getItemLikes(offset: Int = 0, limit: Int? = nil, completion: @escaping ((UserLikesResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.userLikes(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    @discardableResult public func likeItem(itemId: Int, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.likeItem(itemId: itemId, completion: completion, failure: failure)
    }
    
    @discardableResult public func unlikeItem(itemId: Int, completion: @escaping ((GenericResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.unlikeItem(itemId: itemId, completion: completion, failure: failure)
    }

}


//  MARK: General

extension UrbanPiperSDK {
    
    @discardableResult public func registerForFCMToken(token: String, completion: ((GenericResponse?) -> Void)? = nil,
                                                  failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.registerForFCMToken(token: token, completion: completion, failure: failure)
    }
    
    @discardableResult public func checkAppVersion(version: String, completion: ((VersionCheckResponse?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.checkAppVersion(username: UserManager.shared.currentUser?.username, version: version, completion: completion, failure: failure)
    }
    
    @discardableResult public func getNearestStore(lat: CLLocationDegrees, lng: CLLocationDegrees,
                                                   completion: @escaping ((StoreResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getNearestStore(CLLocationCoordinate2DMake(lat, lng), completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func getAllStores(completion: @escaping ((StoreListResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getAllStores(completion: completion, failure: failure)
    }
    
}


//  MARK: Catalogue

extension UrbanPiperSDK {
    
    @discardableResult public func getCategories(locationId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((CategoriesResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getCategories(locationId: locationId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getCategoryItems(categoryId: Int, locationId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getCategoryItems(categoryId: categoryId, locationID: locationId, completion: completion, failure: failure)
    }

    @discardableResult public func searchItems(query: String, locationId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((ItemsSearchResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.searchItems(query: query, locationID: locationId, offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    @discardableResult public func getFilterAndSortOptions(categoryid: Int, completion: @escaping ((CategoryOptionsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFilterAndSortOptions(id: categoryid, completion: completion, failure:failure)
    }

    @discardableResult public func getItemDetails(itemId: Int, locationId: Int, completion: @escaping ((Item?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getItemDetails(itemId: itemId, locationID: locationId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getFeaturedItems(locationId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(locationID: locationId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getAssociatedItems(itemId: Int, locationId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getFeaturedItems(itemIds: [itemId], locationID: locationId, completion: completion, failure: failure)
    }
}

//  MARK: Promotions

extension UrbanPiperSDK {
    
    @discardableResult @objc public func getRewards(completion: @escaping ((RewardsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getRewards(completion: completion, failure: failure)
    }
    
    @discardableResult public func getOffers(offset: Int = 0, limit: Int? = nil, completion: @escaping ((OffersAPIResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getOffers(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    @discardableResult public func getBanners(completion: @escaping ((BannersResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getBanners(completion: completion, failure: failure)
    }
    
}

//  MARK: Cart

extension UrbanPiperSDK {
    
    @discardableResult @objc public func reorder(orderId: Int, userLocation: CLLocationCoordinate2D, locationId: Int,
                                                 completion: @escaping ((ReorderResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.reorder(orderId: orderId, userLocation: userLocation, bizLocationId: locationId, completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func initiateOnlineWalletReload(totalAmount: Decimal,
                                                              completion: ((OnlinePaymentInitResponse?) -> Void)?,
                                                              failure: APIFailure?) -> URLSessionDataTask? {
        let paymentOption = PaymentOption.paymentGateway
        let purpose = OnlinePaymentPurpose.reload
        return APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption, purpose: purpose, totalAmount: totalAmount, bizLocationId: nil, completion: completion, failure: failure)
    }
    

    @discardableResult @objc public func verifyPayment(pid: String,
                                                       transactionId: String,
                                                       completion: @escaping ((OrderVerifyTxnResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.verifyPayment(pid: pid, orderId: OnlinePaymentPurpose.reload.rawValue, transactionId: transactionId, completion: completion, failure: failure)
    }
}
