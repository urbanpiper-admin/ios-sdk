//
//  MixpanelObserver.swift
//  UrbanPiper
//
//  Created by Vid on 16/10/18.
//

import Mixpanel
import UIKit

public class MixpanelObserver: AnalyticsEventObserver {
    var mixpanelToken: String?

    public init(mixpanelToken: String) {
        self.mixpanelToken = mixpanelToken
        Mixpanel.initialize(token: mixpanelToken)
    }

    public func track(event: AnalyticsEvent) {
        switch event {
        case let .appLaunch(theme):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().registerSuperProperties(["theme": theme,
                                                             "platform": "ios"])
            Mixpanel.mainInstance().track(event: "ppr-app-launched",
                                          properties: ["interval_of_day": Date.currentHourRangeString])
        case let .nearestStoreFound(lat, lng, storeName):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-nearest-store-found",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "store": storeName])
        case let .noStoreNearby(lat, lng, addressString):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-no-stores-nearby",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "addr_str": addressString])
        case let .nearestStoreClosedTemp(lat, lng, storeName):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-nearest-store-closed-temp",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "store": storeName,
                                                       "date": Date().yyyymmddString,
                                                       "time": Date().hhmmaString])
        case let .nearestStoreClosed(lat, lng, storeName):
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
        case let .itemSearch(query, storeName, results):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-search",
                                          properties: ["query": query,
                                                       "store": storeName ?? "NA",
                                                       "search_results": results])
        case let .couponSuccess(discount, couponCode, isSuggested, preSelected):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-coupon-applied",
                                          properties: ["success": true,
                                                       "discount": discount,
                                                       "coupon_code": couponCode,
                                                       "is_suggested": isSuggested,
                                                       "pre_selected": preSelected])
        case let .couponFailed(discount, couponCode, isSuggested, preSelected):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-coupon-applied",
                                          properties: ["success": false,
                                                       "discount": discount,
                                                       "coupon_code": couponCode,
                                                       "is_suggested": isSuggested,
                                                       "pre_selected": preSelected])
        case let .passwordReset(phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-password-reset",
                                          properties: ["username": phone])
        case let .loginSuccess(phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": true,
                                                       "username": phone,
                                                       "social_auth": "NA"])
        case let .loginFailed(phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": false,
                                                       "username": phone,
                                                       "social_auth": "NA"])
        case let .resendOTP(phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-resend-otp",
                                          properties: ["username": phone])
        case let .signupStart(phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-start",
                                          properties: ["username": phone,
                                                       "social_auth": "NA"])
        case let .signupComplete(phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-complete",
                                          properties: ["username": phone,
                                                       "social_auth": "NA"])
        case let .walletReloadInit(amount, paymentMode):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-wallet-reload-init",
                                          properties: ["amount": amount,
                                                       "payment_mode": paymentMode])
        case let .successfulWalletReload(amount, paymentMode):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-wallet-reload-complete",
                                          properties: ["success": true,
                                                       "amount": amount,
                                                       "payment_mode": paymentMode])
        case let .failedWalletReload(amount, paymentMode):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-wallet-reload-complete",
                                          properties: ["success": false,
                                                       "amount": amount,
                                                       "payment_mode": paymentMode])
        case let .referralSent(phone, shareChannel, shareLink):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-referral-sent",
                                          properties: ["username": phone,
                                                       "share_channel": shareChannel ?? "NA",
                                                       "share_link": shareLink ?? "NA"])
        case let .logout(phone):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-logout",
                                          properties: ["username": phone])
        case .cartInit:
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-cart-init")
        case let .addToCart(cartItem, checkoutPageItemAdd, itemDetailsPageItemAdd):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-add-to-cart",
                                          properties: ["item_title": cartItem.itemTitle,
                                                       "qty": cartItem.quantity,
                                                       "is_recommended": cartItem.isRecommendedItem,
                                                       "is_upsold": cartItem.isUpsoldItem,
                                                       "from_search": cartItem.isSearchItem,
                                                       "from_detail_scr": itemDetailsPageItemAdd,
                                                       "from_checkout": checkoutPageItemAdd])
        case let .removeFromCart(cartItem):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-remove-from-cart",
                                          properties: ["item_title": cartItem.itemTitle])
        case let .productClicked(item):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-view-details",
                                          properties: ["item_title": item.itemTitle])
        case let .purchaseCompleted(_, userWalletBalance, checkoutBuilder, isReorder):
            guard let token: String = mixpanelToken, let paymentOption = checkoutBuilder.paymentOption, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-order-placed",
                                          properties: ["payable_amt": checkoutBuilder.order?.payableAmount ?? Double.zero,
                                                       "discount": checkoutBuilder.order?.discount?.value ?? Double.zero,
                                                       "coupon": checkoutBuilder.couponCode ?? "NA",
                                                       "interval_of_day": Date.currentHourRangeString,
                                                       "reorder": isReorder,
                                                       "taxes": checkoutBuilder.order?.itemTaxes ?? Double.zero,
                                                       "wallet_credit_applied": checkoutBuilder.useWalletCredits,
                                                       "wallet_credit_amt": userWalletBalance,
                                                       "is_pickup": checkoutBuilder.deliveryOption == .pickUp,
                                                       "payment_mode": paymentOption.rawValue])
        case .reorderInit:
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-reorder-init")
        case let .itemLiked(itemTitle):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-liked",
                                          properties: ["item_title": itemTitle])
        case let .itemUnliked(itemTitle):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-item-unliked",
                                          properties: ["item_title": itemTitle])
        case let .feedbackSubmitted(rating, reason):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-feedback-submitted",
                                          properties: ["rating": rating,
                                                       "reason": reason ?? "NA"])
        case let .checkoutInit(payableAmt, walletCreditsApplied):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-checkout-init",
                                          properties: ["payable_amt": payableAmt,
                                                       "wallet_credits_applied": walletCreditsApplied])
        case let .profileUpdated(phone, pwdChanged):
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
        case let .socialAuthSignupStart(phone, platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-start",
                                          properties: ["username": phone,
                                                       "social_auth": platform])
        case let .socialAuthSignupComplete(phone, platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-signup-complete",
                                          properties: ["username": phone,
                                                       "social_auth": platform])
        case let .socialLoginSuccess(phone, platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": true,
                                                       "username": phone,
                                                       "social_auth": platform])
        case let .socialLoginFailed(phone, platform):
            guard let token: String = mixpanelToken, token.count > 0 else { return }
            Mixpanel.mainInstance().track(event: "ppr-login",
                                          properties: ["success": false,
                                                       "username": phone,
                                                       "social_auth": platform])
        case .bizInfoUpdated:
            guard let user = UserManager.shared.currentUser, let userBizInfo = user.userBizInfoResponse?.userBizInfos.last,
                let token: String = mixpanelToken, token.count > 0 else { return }
            let mixpanel = Mixpanel.mainInstance()
            mixpanel.identify(distinctId: user.phone)
            mixpanel.identify(distinctId: mixpanel.distinctId)

            var properties: Properties = ["$email": user.email,
                                          "balance": userBizInfo.balance,
                                          "$name": user.firstName] as [String: MixpanelType]

            if let val = userBizInfo.lastOrderDateString {
                properties["last_order_dt"] = val
            }

            if let val = userBizInfo.cardNumbers.first {
                properties["cardNumber"] = val
            }
            
            properties["total_order_value"] = userBizInfo.totalOrderValue
            properties["num_of_orders"] = userBizInfo.numOfOrders
            properties["days_since_last_order"] = userBizInfo.daysSinceLastOrder

            mixpanel.people.set(properties: properties)
        }
    }
}
