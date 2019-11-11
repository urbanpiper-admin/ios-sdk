//
//  AppsFlyerObserver.swift
//  UrbanPiper
//
//  Created by Vid on 16/10/18.
//

import AppsFlyerLib
import RxSwift
import UIKit

public class AppsFlyerObserver: AppAnalyticsEventObserver, SDKAnalyticsEventObserver {
    var appsFlyerDevAppid: String?
    var appsFlyerDevKey: String?
    var disposeBag: DisposeBag = DisposeBag()

    @discardableResult public init(appsFlyerDevAppid: String, appsFlyerDevKey: String) {
        AppsFlyerTracker.shared().appleAppID = appsFlyerDevAppid
        AppsFlyerTracker.shared().appsFlyerDevKey = appsFlyerDevKey

        AnalyticsManager.shared.appAnalyticsSubject
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] event in
                self?.track(event: event)
            })
            .disposed(by: disposeBag)

        AnalyticsManager.shared.sdkAnalyticsSubject
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] event in
                self?.track(event: event)
            })
            .disposed(by: disposeBag)
    }

    public func track(event: AppAnalyticsEvent) {
        switch event {
        case .appLaunch:
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackAppLaunch()
        case let .productClicked(item):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            let itemPrice: Double
            if item.itemPrice != 0 {
                itemPrice = item.itemPrice
            } else if let options: [OptionGroupOption] = item.optionGroups?.first?.options, let optionPrice = ((options.compactMap { $0.price }).sorted { $0 < $1 }).first, optionPrice > 0 {
                itemPrice = optionPrice
            } else {
                itemPrice = Double.zero
            }

            tracker.trackEvent(AFEventContentView,
                               withValues: [AFEventParamContentId: item.id as Any,
                                            AFEventParamPrice: itemPrice,
                                            AFEventParamContentType: "item_view",
                                            AFEventParamContent: item.itemTitle as Any,
                                            AFEventParamCurrency: "INR"])
        case .checkoutInit:
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventInitiatedCheckout,
                               withValues: [AFEventParamQuantity: CartManager.shared.cartCount])
        default: break
        }
    }

    public func track(event: SDKAnalyticsEvent) {
        switch event {
        case let .addToCart(cartItem, _, _):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            tracker.trackEvent(AFEventAddToCart,
                               withValues: [AFEventParamContentId: cartItem.id as Any,
                                            AFEventParamPrice: cartItem.totalAmount,
                                            AFEventParamQuantity: cartItem.quantity,
                                            AFEventParamCurrency: "INR"])
        case let .purchaseCompleted(_, _, checkoutBuilder, _):
            guard let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() else { return }
            let payableAmount = NSDecimalNumber(value: checkoutBuilder.order?.payableAmount ?? Double.zero)

            tracker.trackEvent(AFEventPurchase,
                               withValues: [AFEventParamContentId: "",
                                            AFEventParamContentType: "",
                                            AFEventParamRevenue: payableAmount,
                                            AFEventParamCurrency: "INR"])
        default: break
        }
    }
}
