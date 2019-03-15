//
//  AppsFlyerObserver.swift
//  UrbanPiper
//
//  Created by Vid on 16/10/18.
//

import UIKit
import AppsFlyerLib

internal class AppsFlyerObserver: AnalyticsEventObserver {
    
    var appsFlyerDevAppid: String?
    var appsFlyerDevKey: String?

    
    public init (appsFlyerDevAppid: String, appsFlyerDevKey: String) {
//        guard let devKey: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevKey,
//            let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevAppid else { return }
        AppsFlyerTracker.shared().appleAppID = appsFlyerDevAppid
        AppsFlyerTracker.shared().appsFlyerDevKey = appsFlyerDevKey
    }
    
    func track(event: AnalyticsEvent) {
        switch event {
        case .appLaunch(_):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackAppLaunch()
        case .addToCart(let cartItem, _, _):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventAddToCart,
                               withValues: [AFEventParamContentId: cartItem.id,
                                            AFEventParamPrice: cartItem.totalAmount,
                                            AFEventParamQuantity : cartItem.quantity,
                                            AFEventParamCurrency: "INR"])
        case .productClicked(let item):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            let itemPrice: Decimal
            if let price = item.itemPrice, price != 0 {
                itemPrice = price
            } else if let options: [ItemOption] = item.optionGroups?.first?.options, let optionPrice: Decimal = ((options.compactMap { $0.price }).sorted { $0 < $1 }).first, optionPrice > 0 {
                itemPrice = optionPrice
            } else {
                itemPrice = Decimal.zero
            }
            
            tracker.trackEvent(AFEventContentView,
                               withValues: [AFEventParamContentId: item.id,
                                            AFEventParamPrice: itemPrice,
                                            AFEventParamContentType: "item_view",
                                            AFEventParamContent: item.itemTitle,
                                            AFEventParamCurrency: "INR"])
        case .purchaseCompleted(_,_,let checkoutBuilder, _):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventPurchase,
                               withValues: [AFEventParamContentId: "",
                                            AFEventParamContentType: "",
                                            AFEventParamRevenue: checkoutBuilder.order?.payableAmount ?? Decimal.zero,
                                            AFEventParamCurrency: "INR"])
            break
        case .checkoutInit:
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventInitiatedCheckout,
                               withValues: [AFEventParamQuantity: CartManager.shared.cartCount])
        default: break
        }
    }
    
}
