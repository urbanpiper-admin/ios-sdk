//
//  MixpanelObserver.swift
//  UrbanPiper
//
//  Created by Vid on 16/10/18.
//

import UIKit
import Mixpanel

public class MixpanelObserver: AnalyticsEventObserver {
    
    var mixpanelToken: String?
    
    public init (mixpanelToken: String) {
        self.mixpanelToken = mixpanelToken
        Mixpanel.initialize(token: mixpanelToken)
    }
 
    public func track(event: AnalyticsEvent) {
        switch event {
        case .appLaunch(let theme):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().registerSuperProperties(["theme": theme,
                                                             "platform": "ios"])
            Mixpanel.mainInstance().track(event: "ppr-app-launched",
                                          properties: ["interval_of_day" : Date.currentHourRangeString])
        case .nearestStoreFound(let lat, let lng, let storeName):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-nearest-store-found",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "store": storeName])
        case .noStoreNearby(let lat, let lng, let addressString):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-no-stores-nearby",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "addr_str": addressString])
        case .nearestStoreClosedTemp(let lat, let lng, let storeName):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-nearest-store-closed-temp",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "store": storeName,
                                                       "date": Date().yyyymmddString,
                                                       "time": Date().hhmmaString])
        case .nearestStoreClosed(let lat, let lng, let storeName):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-nearest-store-closed",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "store": storeName,
                                                       "date": Date().yyyymmddString,
                                                       "time": Date().hhmmaString])
//        case .nearestStoreClosedToday(let lat, let lng, let storeName):
//            guard let token: String = mixpanelToken, token.count > 0 else { return }
//            Mixpanel.mainInstance().track(event: "ppr-nearest-store-closed",
//                                          properties: ["lat": lat,
//                                                       "lng": lng,
//                                                       "store": storeName,
//                                                       "date": Date().yyyymmddString,
//                                                       "time": Date().hhmmaString])
        case .itemSearch(let query, let storeName, let results):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-search",
                                          properties: ["query": query,
                                                       "store": storeName ?? "NA",
                                                       "search_results": results])
        case .couponSuccess(let discount, let couponCode, let isSuggested, let preSelected):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-coupon-applied",
                                          properties: ["success": true,
                                                       "discount": NSDecimalNumber(decimal:discount).doubleValue,
                                                       "coupon_code": couponCode,
                                                       "is_suggested": isSuggested,
                                                       "pre_selected": preSelected])
        case .couponFailed(let discount, let couponCode, let isSuggested, let preSelected):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-coupon-applied",
                                          properties: ["success": false,
                                                       "discount": NSDecimalNumber(decimal:discount).doubleValue,
                                                       "coupon_code": couponCode,
                                                       "is_suggested": isSuggested,
                                                       "pre_selected": preSelected])
        case .passwordReset(let phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-password-reset",
                                          properties: ["username": phone])
        case .loginSuccess(let phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": true,
                                                       "username": phone,
                                                       "social_auth": "NA"])
        case .loginFailed(let phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": false,
                                                       "username": phone,
                                                       "social_auth": "NA"])
        case .resendOTP(let phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-resend-otp",
                                          properties: ["username": phone])
        case .signupStart(let phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-start",
                                          properties: ["username": phone,
                                                       "social_auth": "NA"])
        case .signupComplete(let phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-complete",
                                          properties: ["username": phone,
                                                       "social_auth": "NA"])
        case .walletReloadInit(let amount, let paymentMode):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-wallet-reload-init",
                                          properties: ["amount": amount.doubleValue,
                                                       "payment_mode": paymentMode])
        case .successfulWalletReload(let amount, let paymentMode):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-wallet-reload-complete",
                                          properties: ["success": true,
                                                       "amount": amount.doubleValue,
                                                       "payment_mode": paymentMode])
        case .failedWalletReload(let amount, let paymentMode):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-wallet-reload-complete",
                                          properties: ["success":false,
                                                       "amount": amount.doubleValue,
                                                       "payment_mode": paymentMode])
        case .referralSent(let phone, let shareChannel, let shareLink):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-referral-sent",
                                          properties: ["username": phone,
                                                       "share_channel": shareChannel ?? "NA",
                                                       "share_link": shareLink ?? "NA"])
        case .logout(let phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-logout",
                                          properties: ["username": phone])
        case .cartInit:
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-cart-init")
        case .addToCart(let cartItem, let checkoutPageItemAdd, let itemDetailsPageItemAdd):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-add-to-cart",
                                          properties: ["item_title": cartItem.itemTitle,
                                                       "qty": cartItem.quantity,
                                                       "is_recommended": cartItem.isRecommendedItem,
                                                       "is_upsold": cartItem.isUpsoldItem,
                                                       "from_search": cartItem.isSearchItem,
                                                       "from_detail_scr": itemDetailsPageItemAdd,
                                                       "from_checkout": checkoutPageItemAdd])
        case .removeFromCart(let cartItem):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-remove-from-cart",
                                          properties: ["item_title": cartItem.itemTitle])
        case .productClicked(let item):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-view-details",
                                          properties: ["item_title": item.itemTitle])
        case .purchaseCompleted(_, let userWalletBalance, let checkoutBuilder, let isReorder):
            guard let token: String = mixpanelToken, let paymentOption = checkoutBuilder.paymentOption, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-order-placed",
                                          properties: ["payable_amt": NSDecimalNumber(decimal: checkoutBuilder.order?.payableAmount ?? Decimal.zero).doubleValue,
                                            "discount": NSDecimalNumber(decimal: checkoutBuilder.order?.discount?.value ?? Decimal.zero).doubleValue,
                                            "coupon": checkoutBuilder.couponCode ?? "NA",
                                            "interval_of_day": Date.currentHourRangeString,
                                            "reorder": isReorder,
                                            "taxes": NSDecimalNumber(decimal: checkoutBuilder.order?.itemTaxes ?? Decimal.zero).doubleValue,
                                            "wallet_credit_applied": checkoutBuilder.useWalletCredits,
                                            "wallet_credit_amt": NSDecimalNumber(decimal: userWalletBalance).doubleValue,
                                            "is_pickup": checkoutBuilder.deliveryOption == .pickUp,
                                            "payment_mode": paymentOption.rawValue])
        case .reorderInit:
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-reorder-init")
        case .itemLiked(let itemTitle):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-liked",
                                          properties: ["item_title": itemTitle])
        case .itemUnliked(let itemTitle):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-unliked",
                                          properties: ["item_title": itemTitle])
        case .feedbackSubmitted(let rating, let reason):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-feedback-submitted",
                                          properties: ["rating": rating,
                                                       "reason": reason ?? "NA"])
        case .checkoutInit(let payableAmt, let walletCreditsApplied):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-checkout-init",
                                          properties: ["payable_amt": NSDecimalNumber(decimal: payableAmt).doubleValue,
                                                       "wallet_credits_applied": walletCreditsApplied])
        case .profileUpdated(let phone, let pwdChanged):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-profile-updated",
                                          properties: ["username": phone,
                                                       "pwd_changed": pwdChanged])
        case .bannerClicked:
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-banner-clicked")
        case .addressSelected:
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-addr-selected")
        case .socialAuthSignupStart(let phone, let platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-start",
                                          properties: ["username": phone,
                                                       "social_auth": platform])
        case .socialAuthSignupComplete(let phone, let platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-complete",
                                          properties: ["username": phone,
                                                       "social_auth": platform])
        case .socialLoginSuccess(let phone, let platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": true,
                                                       "username": phone,
                                                       "social_auth": platform])
        case .socialLoginFailed(let phone, let platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": false,
                                                       "username": phone,
                                                       "social_auth": platform])
        case .bizInfoUpdated:
            guard let user = UserManager.shared.currentUser, let userBizInfo = user.userBizInfoResponse?.userBizInfos?.last,
                let token: String = mixpanelToken, token.count > 0 else { return }
            let mixpanel = Mixpanel.mainInstance()
            mixpanel.identify(distinctId: user.phone)
            mixpanel.identify(distinctId: mixpanel.distinctId)
            
            var properties: Properties = ["$email": user.email,
                                          "balance": userBizInfo.balance.doubleValue,
                                          "$name": user.firstName] as [String : MixpanelType]
            
            if let val = userBizInfo.lastOrderDateString {
                properties["last_order_dt"] = val
            }
            
            if let val = userBizInfo.cardNumbers.first {
                properties["cardNumber"] = val
            }
            
            if let val = userBizInfo.totalOrderValue {
                let decimalNumber = val as NSDecimalNumber
                properties["total_order_value"] = decimalNumber.floatValue
            }
            
            if let val = userBizInfo.numOfOrders {
                properties["num_of_orders"] = val
            }
            
            if let val = userBizInfo.daysSinceLastOrder {
                properties["days_since_last_order"] = val
            }
            
            mixpanel.people.set(properties: properties)
            
        }
    }
    
}
