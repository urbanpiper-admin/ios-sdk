//
//  GAObserver.swift
//  UrbanPiper
//
//  Created by Vid on 16/10/18.
//

import GoogleAnalyticsSDK
import RxSwift
import UIKit

public class GAObserver: AppAnalyticsEventObserver, SDKAnalyticsEventObserver {
    var gaTrackingId: String?
    var disposeBag: DisposeBag = DisposeBag()

    @discardableResult public init(gaTrackingId: String) {
        self.gaTrackingId = gaTrackingId

        let gai: GAI = GAI.sharedInstance()
        gai.tracker(withTrackingId: gaTrackingId)

        gai.trackUncaughtExceptions = true

        gai.logger.logLevel = .error

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
        case .nearestStoreFound:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: nil,
                                                                   label: "nearest-store-found",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .noStoreNearby:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: nil,
                                                                   label: "no-stores-nearby",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .nearestStoreClosedTemp:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: nil,
                                                                   label: "nearest-store-closed-temp",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .nearestStoreClosed:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: nil,
                                                                   label: "nearest-store-closed",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .itemSearch:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: nil,
                                                                   label: "item-search",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .couponSuccess(discount, couponCode, _, _):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "coupon-success",
                                                                   action: nil,
                                                                   label: couponCode,
                                                                   value: NSDecimalNumber(value: discount)).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .couponFailed(_, couponCode, _, _):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "coupon-failure",
                                                                   action: nil,
                                                                   label: couponCode,
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .signupComplete:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "signup-complete",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .walletReloadInit(amount, _):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "reload-init",
                                                                   value: NSDecimalNumber(value: amount)).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .successfulWalletReload(amount, _):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "reload-success",
                                                                   value: NSDecimalNumber(value: amount)).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .failedWalletReload(amount, _):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "reload-failed",
                                                                   value: NSDecimalNumber(value: amount)).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .referralSent:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "referral-sent",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .productClicked(item):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            product.setId("\(item.id)")
            product.setName(item.itemTitle)
            if let name = item.category?.name {
                product.setCategory(name)
            }

            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPADetail)

            let screenBuilder: GAIDictionaryBuilder = GAIDictionaryBuilder.createScreenView()!
            screenBuilder.add(product)
            screenBuilder.setProductAction(productAction)

            tracker.send((screenBuilder.build() as! [AnyHashable: Any]))
        case let .reorderInit(amount):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: nil,
                                                                   label: "re-order",
                                                                   value: NSDecimalNumber(value: amount)).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .socialAuthSignupComplete(_, platform):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "social-signup-complete",
                                                                   value: platform == "google" ? 1 : 2).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .socialLoginSuccess(_, platform):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "social-login-success",
                                                                   value: platform == "google" ? 1 : 2).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .socialLoginFailed(_, platform):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "social-login-failed",
                                                                   value: platform == "google" ? 1 : 2).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        default: break
        }
    }

    public func track(event: SDKAnalyticsEvent) {
        switch event {
        case .passwordReset:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "password-reset",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .loginSuccess:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "login-success",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .loginFailed:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "login-failed",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .resendOTP:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "resend-otp",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .signupStart:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "signup-start",
                                                                   value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case .logout:
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary: [AnyHashable: Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                                       action: "logout",
                                                                                       label: "logout",
                                                                                       value: 0).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        case let .addToCart(cartItem, _, _):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            product.setId("\(cartItem.id)")
            product.setName(cartItem.itemTitle)
            product.setQuantity(cartItem.quantity as NSNumber)
            product.setPrice(cartItem.totalAmount as NSNumber)
            if let name = cartItem.category?.name {
                product.setCategory(name)
            }
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPAAdd)

            let screenBuilder: GAIDictionaryBuilder = GAIDictionaryBuilder.createScreenView()!
            screenBuilder.add(product)
            screenBuilder.setProductAction(productAction)

            tracker.send((screenBuilder.build() as! [AnyHashable: Any]))
        case let .removeFromCart(cartItem):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            product.setId("\(cartItem.id)")
            product.setName(cartItem.itemTitle)
            product.setQuantity(cartItem.quantity as NSNumber)
            product.setPrice(cartItem.totalAmount as NSNumber)
            if let name = cartItem.category?.name {
                product.setCategory(name)
            }
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPARemove)

            let screenBuilder: GAIDictionaryBuilder = GAIDictionaryBuilder.createScreenView()!
            screenBuilder.add(product)
            screenBuilder.setProductAction(productAction)

            tracker.send((screenBuilder.build() as! [AnyHashable: Any]))

        case let .purchaseCompleted(orderID, _, checkoutBuilder, _):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker, let paymentOption = checkoutBuilder.paymentOption else { return }
            let payableAmount = NSDecimalNumber(value: checkoutBuilder.order?.payableAmount ?? Double.zero)
            let eventDictionary: [AnyHashable: Any] = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                                       action: "purchase",
                                                                                       label: "success",
                                                                                       value: payableAmount).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)

            let eventBuilder = GAIDictionaryBuilder.createEvent(withCategory: nil, action: nil, label: nil, value: nil)!

            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPAPurchase)
            productAction.setTransactionId(String(orderID))
            productAction.setAffiliation("UrbanPiper")
            productAction.setRevenue(payableAmount)
            productAction.setTax(NSDecimalNumber(value: checkoutBuilder.order?.itemTaxes ?? Double.zero))

            let deliveryCharge = checkoutBuilder.deliveryOption == .pickUp ? Double.zero : checkoutBuilder.order?.deliveryCharge ?? Double.zero
            productAction.setShipping(NSDecimalNumber(value: deliveryCharge))
            productAction.setCheckoutOption(paymentOption.rawValue)

            productAction.setCouponCode(checkoutBuilder.couponCode)

            for item in checkoutBuilder.cartItems {
                let product: GAIEcommerceProduct = GAIEcommerceProduct()
                product.setId("\(item.id)")
                product.setName(item.itemTitle)
                product.setQuantity(NSNumber(value: item.quantity))
                product.setPrice(NSDecimalNumber(value: item.itemPrice ?? 0))
                if let name = item.category?.name {
                    product.setCategory(name)
                }
                eventBuilder.add(product)
            }

            eventBuilder.setProductAction(productAction)
            tracker.send((eventBuilder.build() as! [AnyHashable: Any]))

        case let .socialAuthSignupStart(_, platform):
            guard let tracker: GAITracker = GAI.sharedInstance().defaultTracker else { return }
            let eventDictionary = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: nil,
                                                                   label: "social-signup-start",
                                                                   value: platform == "google" ? 1 : 2).build() as! [AnyHashable: Any]
            tracker.send(eventDictionary)
        default: break
        }
    }
}
