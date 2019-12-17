//
//  AnalyticsManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 13/03/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import CoreLocation
import RxSwift
import UIKit

public protocol AppAnalyticsEventObserver: AnyObject {
    func track(event: AppAnalyticsEvent)
}

protocol SDKAnalyticsEventObserver: AnyObject {
    func track(event: SDKAnalyticsEvent)
}

public enum AppAnalyticsEvent {
    case appLaunch(theme: String)
    case nearestStoreFound(lat: CLLocationDegrees, lng: CLLocationDegrees, storeName: String)
    case noStoreNearby(lat: CLLocationDegrees, lng: CLLocationDegrees, addressString: String)
    case nearestStoreClosedTemp(lat: CLLocationDegrees, lng: CLLocationDegrees, storeName: String)
    case nearestStoreClosed(lat: CLLocationDegrees, lng: CLLocationDegrees, storeName: String)
    case itemSearch(query: String, storeName: String?, results: [String: Any])
    case couponSuccess(discount: Double, couponCode: String, isSuggested: Bool, preSelected: Bool)
    case couponFailed(discount: Double, couponCode: String, isSuggested: Bool, preSelected: Bool)
    case signupComplete(phone: String) // Unimplemented
    case walletReloadInit(amount: Double, paymentMode: String)
    case successfulWalletReload(amount: Double, paymentMode: String)
    case failedWalletReload(amount: Double, paymentMode: String)
    case referralSent(phone: String, shareChannel: String?, shareLink: String?)
    case productClicked(item: Item)
    case reorderInit(amount: Double)
    case itemLiked(itemTitle: String)
    case itemUnliked(itemTitle: String)
    case feedbackSubmitted(rating: Double, reason: String?)
    case checkoutInit(payableAmt: Double, walletCreditsApplied: Bool)
    case bannerClicked
    case addressSelected
    case socialAuthSignupComplete(phone: String, platform: String) // Unimplemented
    case socialLoginSuccess(phone: String, platform: String) // Unimplemented
    case socialLoginFailed(phone: String, platform: String) // Unimplemented
}

public enum SDKAnalyticsEvent {
    case passwordReset(phone: String)
    case loginSuccess(phone: String)
    case loginFailed(phone: String)
    case resendOTP(phone: String)
    case signupStart(phone: String)
    case signupComplete(phone: String) // Unimplemented
    case logout(phone: String)
    case cartInit
    case addToCart(item: CartItem, checkoutPageItemAdd: Bool, itemDetailsPageItemAdd: Bool)
    case removeFromCart(item: CartItem)
    case purchaseCompleted(orderID: Int, userWalletBalance: Double, checkoutBuilder: CheckoutBuilder, isReorder: Bool)
    case profileUpdated(phone: String, pwdChanged: Bool)
    case socialAuthSignupStart(phone: String, platform: String)
    case socialAuthSignupComplete(phone: String, platform: String) // Unimplemented
    case socialLoginSuccess(phone: String, platform: String) // Unimplemented
    case socialLoginFailed(phone: String, platform: String) // Unimplemented
    case bizInfoUpdated
}

public class AnalyticsManager: NSObject {
    @objc public static let shared: AnalyticsManager = AnalyticsManager()
    internal var appAnalyticsSubject = PublishSubject<AppAnalyticsEvent>()
    internal var sdkAnalyticsSubject = PublishSubject<SDKAnalyticsEvent>()

    public func track(event: AppAnalyticsEvent) {
        #if !DEBUG
            appAnalyticsSubject.onNext(event)
        #endif
    }

    public func track(event: SDKAnalyticsEvent) {
        #if !DEBUG
            sdkAnalyticsSubject.onNext(event)
        #endif
    }

    @objc public func initiateWalletReload(amount: Double, paymentMode: String) {
        track(event: .walletReloadInit(amount: amount, paymentMode: paymentMode))
    }

    @objc public func walletReloadSuccess(amount: Double, paymentMode: String) {
        track(event: .successfulWalletReload(amount: amount, paymentMode: paymentMode))
    }

    @objc public func walletReloadFailed(amount: Double, paymentMode: String) {
        track(event: .failedWalletReload(amount: amount, paymentMode: paymentMode))
    }

    @objc public func reorderInit(amount: Double) {
        track(event: .reorderInit(amount: amount))
    }

    @objc public func feedbackSubmitted(rating: Float, reason: String?) {
        track(event: .feedbackSubmitted(rating: Double(rating), reason: reason))
    }
}
