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
        return RegistrationBuilder(phone: phone)
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
    
    @discardableResult public func socialLogin(email: String, socialLoginProvider: SocialLoginProvider, accessToken: String, completion: @escaping ((socialLoginResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return UserManager.shared.socialLogin(email: email, socialLoginProvider: socialLoginProvider, accessToken: accessToken, completion: completion, failure: failure)
    }
        
    @discardableResult public func refreshUserInfo(completion: ((UserInfoResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserInfo(completion: completion, failure: failure)
    }

    @discardableResult public func refreshUserBizInfo(completion: ((BizInfo?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask? {
        return UserManager.shared.refreshUserBizInfo(completion: completion, failure: failure)
    }

    @discardableResult public func updateUserInfo(name: String, phone: String, email: String, gender: String?, anniversary: Date?, birthday: Date?, completion: ((UserInfoUpdateResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        return UserManager.shared.updateUserInfo(name: name, phone: phone, email: email, gender: gender, completion: completion, failure: failure)
    }
    
    @discardableResult public func changePassword(phone: String, oldPassword: String, newPassword: String, completion: ((GenericResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        return UserManager.shared.changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword, completion: completion, failure: failure)
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

    @discardableResult public func getPastOrders(completion: ((MyOrdersResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchOrderHistory(completion: completion, failure: failure)
    }

    @discardableResult public func getOrderDetails(orderId: Int, completion: ((MyOrderDetailsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchOrderDetails(orderId: orderId, completion: completion, failure: failure)
    }

    @discardableResult public func redeemReward(rewardId: Int, completion: ((RedeemRewardResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.redeemReward(rewardId: rewardId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getNotifications(completion: ((NotificationsResponse?) -> Void)?, failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchNotificationsList(completion: completion, failure: failure)
    }

}


//  MARK: General

extension UrbanPiperSDK {
    
    @discardableResult public func registerForFCMMessaging(token: String, completion: ((GenericResponse?) -> Void)? = nil,
                                                           failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.registerForFCMMessaging(token: token, completion: completion, failure: failure)
    }
    
    @discardableResult public func checkForUpdate(version: String, completion: ((VersionCheckResponse?) -> Void)? = nil, failure: APIFailure? = nil) -> URLSessionDataTask {
        return APIManager.shared.checkForUpgrade(username: UserManager.shared.currentUser?.username, version: version, completion: completion, failure: failure)
    }
    
    @discardableResult public func getNearestStore(lat: CLLocationDegrees, lng: CLLocationDegrees, completion: @escaping ((StoreResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchNearestStore(CLLocationCoordinate2DMake(lat, lng), completion: completion, failure: failure)
    }
    
    @discardableResult public func getAllStores(completion: @escaping ((StoreLocatorResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchAllStores(completion: completion, failure: failure)
    }
    
    @discardableResult public func getRewards(completion: @escaping ((RewardsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.getRewards(completion: completion, failure: failure)
    }
    
    @discardableResult public func getCoupons(offset: Int = 0, limit: Int? = nil, completion: @escaping ((OffersAPIResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.availableCoupons(offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    @discardableResult public func getBanners(completion: @escaping ((BannersResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchBannersList(completion: completion, failure: failure)
    }
    
}


//  MARK: Catalogue

extension UrbanPiperSDK {
    
    @discardableResult public func getCategories(locationId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((CategoriesResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchCategoriesList(locationId: locationId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getCategoryItems(categoryId: Int, locationId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchCategoryItems(categoryId: categoryId, locationID: locationId, completion: completion, failure: failure)
    }

    @discardableResult public func searchItems(query: String, locationId: Int?, offset: Int = 0, limit: Int? = nil, completion: @escaping ((ItemsSearchResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchCategoryItems(for: query, locationID: locationId, offset: offset, limit: limit ?? Constants.fetchLimit, completion: completion, failure: failure)
    }
    
    @discardableResult public func getFilterAndSortOptions(categoryid: Int, completion: @escaping ((CategoryOptionsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchCategoryOptions(id: categoryid, completion: completion, failure:failure)
    }

    @discardableResult public func getItemDetails(itemId: Int, locationId: Int, completion: @escaping ((ItemObject?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.fetchItemDetails(itemId: itemId, locationID: locationId, completion: completion, failure: failure)
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

    @discardableResult public func getFeaturedItems(locationId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.featuredItems(locationID: locationId, completion: completion, failure: failure)
    }
    
    @discardableResult public func getAssociatedItems(itemId: Int, locationId: Int, completion: @escaping ((CategoryItemsResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask {
        return APIManager.shared.featuredItems(itemIds: [itemId], locationID: locationId, completion: completion, failure: failure)
    }
}
