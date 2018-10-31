//
//  AppsFlyerObserver.swift
//  UrbanPiperSDK
//
//  Created by Vid on 16/10/18.
//

import UIKit
import AppsFlyerLib

class AppsFlyerObserver: AnalyticsObserver {
    
    override func initializeTracker() {
        guard let devKey: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevKey,
            let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevAppid else { return }
        AppsFlyerTracker.shared().appleAppID = appId
        AppsFlyerTracker.shared().appsFlyerDevKey = devKey
    }
    
    override func track(event: AnalyticsEvent) {
        switch event {
        case .appLaunch(_):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackAppLaunch()
        case .addToCart(let item, _, _):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventAddToCart,
                               withValues: [AFEventParamContentId: item.id,
                                            AFEventParamPrice: item.totalAmount,
                                            AFEventParamQuantity : item.quantity,
                                            AFEventParamCurrency: "INR"])
        case .productClicked(let item):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventContentView,
                               withValues: [AFEventParamContentId: item.id,
                                            AFEventParamPrice: item.totalAmount,
                                            AFEventParamContentType: "item_view",
                                            AFEventParamContent: item.itemTitle,
                                            AFEventParamCurrency: "INR"])
        case .purchaseCompleted(_, let orderPaymentDataModel, _):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventPurchase,
                               withValues: [AFEventParamContentId: "",
                                            AFEventParamContentType: "",
                                            AFEventParamRevenue: orderPaymentDataModel.itemsTotalPrice,
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
