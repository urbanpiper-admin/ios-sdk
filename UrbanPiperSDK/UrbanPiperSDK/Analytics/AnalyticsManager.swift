//
//  AnalyticsManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 13/03/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

#if !DEBUG
import AppsFlyerLib
import Mixpanel
import GoogleAnalyticsSDK
#endif

public class AnalyticsManager: NSObject {
    
    @objc public static let shared: AnalyticsManager = AnalyticsManager()
    
    public static func initializeSDKs() {
        #if !DEBUG
        let plistPath: String = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        var googleServiceInfoPlist: [String: Any] = NSDictionary(contentsOfFile: plistPath) as! [String: Any]
        
        if let gai: GAI = GAI.sharedInstance(), let trackingId: String = googleServiceInfoPlist["TRACKING_ID"] as? String {
            gai.tracker(withTrackingId: trackingId)
            
            gai.trackUncaughtExceptions = true
            
            gai.logger.logLevel = .error
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.initialize(token: token)
        }
        
        if let devKey: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevKey, let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevAppid {
            AppsFlyerTracker.shared().appleAppID = appId
            AppsFlyerTracker.shared().appsFlyerDevKey = devKey
        }
        #endif
    }
    
    
    public func screenLoginOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Login")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_login")
        }
        #endif
    }
    
    
    public func screenSignUpOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Signup")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_signup")
        }
        #endif
    }
    
    @objc public func screenWalletOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Wallet")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_wallet")
        }
        #endif
    }
    
    public func screenOrderingHomeOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Ordering categories (Tiled)")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_ordering_home")
        }
        #endif
    }
    
    @objc public func screenReferralOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Referral screen")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_referral")
        }
        #endif
    }
    
    @objc public func screenPlacesSearchOpened() {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_google_place_search")
        }
        #endif
    }
    
    @objc public func screenOrderingHistoryOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Ordering status and history")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_ordering_history")
        }
        #endif
    }
    
    @objc public func screenPastOrderDetailOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Ordering past order detail")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_order_detail")
        }
        #endif
    }
    
    public func screenOrderingItemsListOpened(_ categoryTitle: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Ordering items. Category -- \(categoryTitle)")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_ordering_items")
        }
        #endif
    }
    
    public func screenCheckOutOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Ordering checkout")
            
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPACheckout)
            productAction.setCheckoutStep(NSNumber(value: 1))
            
            let builder: GAIDictionaryBuilder = GAIDictionaryBuilder.createEvent(withCategory: nil, action: nil, label: nil, value: nil)!
            builder.add(product)
            builder.setProductAction(productAction)
            
            tracker.send(builder.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_checkout",
                                          properties: ["total" : (CartManager.shared.cartValue as NSDecimalNumber).doubleValue,
                                                       "item_count" : CartManager.shared.cartCount])
        }
        #endif
    }
    
    public func screenOrderingPaymentOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Ordering payment")
            
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPACheckout)
            productAction.setCheckoutStep(NSNumber(value: 2))
            
            let builder: GAIDictionaryBuilder = GAIDictionaryBuilder.createEvent(withCategory: nil, action: nil, label: nil, value: nil)!
            builder.add(product)
            builder.setProductAction(productAction)
            
            tracker.send(builder.build() as! [AnyHashable : Any])
        }
        
        if let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() {
            tracker.trackEvent(AFEventInitiatedCheckout,
                               withValues: [AFEventParamQuantity: CartManager.shared.cartCount])
        }
        
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            var itemsDictionaryArray = [[String: Any]]()
            
            for itemObject in CartManager.shared.cartItems {
                itemsDictionaryArray.append(itemObject.toDictionary())
            }
            Mixpanel.mainInstance().track(event: "cart_confirmed",
                                          properties: ["items" : itemsDictionaryArray])
            Mixpanel.mainInstance().track(event: "screen_ordering_payment")
        }
        #endif
    }
    
    @objc public func screenFeedbackOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Feedback")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_ordering_feedback")
        }
        #endif
    }
    
    @objc public func screenSavedAddressOpened() {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_saved_address_list")
        }
        #endif
    }
    
    @objc public func screenValidateCouponOpened() {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_validate_coupon")
        }
        #endif
    }
    
    public func itemsSearchScreenOpened() {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_search")
        }
        #endif
    }
    
    @objc public func pointOfDeliverySearchScreenOpened() {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "screen_pod_search")
        }
        #endif
    }
    
    public func screenOrderConfirmationOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Ordering confirmation")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        #endif
    }
    
    @objc public func screenPrepaidReloadOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Prepaid reload")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        #endif
    }
    
    public func splashScreenOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Splash")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        #endif
    }
    
    @objc public func screenRazorPayCheckoutOpened() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "RazorPay checkout")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        #endif
    }
    
    @objc public func screenGenericWebViewOpened(title: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            tracker.set(kGAIScreenName, value: "Generic view -- \(title)")
            tracker.send(GAIDictionaryBuilder.createScreenView()!.build() as! [AnyHashable : Any])
        }
        #endif
    }
    
    public func trackAppLaunch() {
        #if !DEBUG
        if let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() {
            tracker.trackAppLaunch()
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "app_launched",
                                          properties: ["interval_of_day" : Date.currentHourRangeString])
        }
        #endif
    }
    
    public func userLoggedInSuccessfully(phone: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "login",
                                                                   label: "success",
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "login",
                                          properties : ["username" : phone,
                                                        "success" : true])
            setMixpanelPeople()
        }
        #endif
    }
    
    public func userLoginFailed(phone: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "login",
                                                                   label: "failure",
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "login",
                                          properties : ["username" : phone,
                                                        "success" : false])
        }
        #endif
    }
    
    @objc public func userLoggedOut() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "logout",
                                                                   label: nil,
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "logout")
            
            Mixpanel.mainInstance().people.deleteUser()
        }
        #endif
    }
    
    //  Should be called after the user has signed up and has yet to verify phone number via otp validation
    public func userSignedUpSuccessfully(phone: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "signup",
                                                                   label: "awaiting-pin",
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "signup_otp_gen",
                                          properties : ["username" : phone])
        }
        #endif
    }
    
    //  Should be called after the user entered otp is verfied successfully
    public func userEnteredOtpValidated(phone: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "signup",
                                                                   label: "completed",
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "signup",
                                          properties : ["username" : phone])
            
            setMixpanelPeople()
        }
        #endif
    }
    
    public func userSelectedResendOTP() {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "signup",
                                                                   label: "resend-pin",
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        #endif
    }
    
    //  Should be called when the user has signed up via social login and the phone no is not validated
    public func newSocialLoginUserSignedUp(phone: String, platform: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "social-signup",
                                                                   label: "completed",
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "signup_otp_gen",
                                          properties : ["username" : phone,
                                                        "platform" : platform])
        }
        #endif
    }
    
    public func socialLoginUserPhoneVerified(phone: String, platform: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "signup",
                                          properties : ["username" : phone,
                                                        "platform" : platform])
            
            setMixpanelPeople()
        }
        #endif
    }
    
    public func userLogInUsingSocialLogin(phone: String, platform: String) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "user",
                                                                   action: "login-social-auth",
                                                                   label: "completed",
                                                                   value: nil).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "login",
                                          properties : ["username" : phone,
                                                        "success" : true,
                                                        "platform" : platform])
            
            setMixpanelPeople()
        }
        #endif
    }
    
    @objc public func feedbackSubmitted(data: [String: Any]) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: "feedback",
                                                                   label: nil,
                                                                   value: data["rating"]! as! NSNumber).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            
            var properties: Properties = ["rating" : data["rating"]! as! Int,
                                          "type" : data["type"]! as! String,
                                          "type_id" : data["type_id"]! as! String]
            
            if let choiceText: String = data["choice_text"] as? String {
                properties["choice"] = choiceText
            }
            
            Mixpanel.mainInstance().track(event: "feedback_submitted",
                                          properties : properties)
        }
        #endif
    }
    
    public func itemSearch(query: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            var properties: Properties = ["query" : query]
            
            if let storeId = OrderingStoreDataModel.shared.nearestStoreResponse?.store?.bizLocationId {
                properties["store_id"] = "\(storeId)"
            }
            
            Mixpanel.mainInstance().track(event: "search",
                                          properties : properties)
        }
        #endif
    }
    
    public func orderPlacementFailure(amount: Decimal) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: "purchase",
                                                                   label: "failure",
                                                                   value: amount as NSNumber).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        #endif
    }
    
    @objc public func userInitiatedWalletReloadWithUPServer(amount: NSDecimalNumber) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "prepaid",
                                                                   action: "reload",
                                                                   label: "up-txn-init",
                                                                   value: amount).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            let properties: [String : MixpanelType] = ["amount" : amount.doubleValue,
                                                       "success": true]
            
            Mixpanel.mainInstance().track(event: "wallet_reload_init",
                                          properties : properties)
        }
        #endif
    }
    
    @objc public func userInitiatedWalletReloadUsingRazorPay(amount: NSDecimalNumber) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "prepaid",
                                                                   action: "reload",
                                                                   label: "rzp-txn-init",
                                                                   value: amount).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            let properties: [String : MixpanelType] = ["amount" : amount.doubleValue,
                                                       "success": true]
            
            Mixpanel.mainInstance().track(event: "wallet_reload_init",
                                          properties : properties)
        }
        #endif
    }
    
    @objc public func walletReloadedUsingRazorPay(amount: NSDecimalNumber) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "prepaid",
                                                                   action: "reload",
                                                                   label: "rzp-txn-complete",
                                                                   value: amount).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        #endif
    }
    
    @objc public func walletReloadedWithUPServer(amount: NSDecimalNumber) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "prepaid",
                                                                   action: "reload",
                                                                   label: "up-txn-complete",
                                                                   value: amount).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        #endif
    }
    
    @objc public func walletReloadFailed(amount: NSDecimalNumber) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            let properties: [String : MixpanelType] = ["amount" : amount.doubleValue,
                                                       "success": false]
            
            Mixpanel.mainInstance().track(event: "wallet_reload_init",
                                          properties : properties)
        }
        #endif
    }
    
    @objc public func couponApplied(discount: Decimal, couponCode: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            let properties: [String : MixpanelType] = ["discount" : NSDecimalNumber(decimal:discount).doubleValue,
                                                       "coupon_txt": couponCode]
            
            Mixpanel.mainInstance().track(event: "validate_coupon",
                                          properties : properties)
        }
        #endif
    }
    
    @objc public func newAddressAdded() {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "add_address")
        }
        #endif
    }
    
    public func referralSentDetails(link: String, channel: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "referral_sent",
                                          properties: ["link": link,
                                                       "channel": channel])
        }
        #endif
    }
    
    @objc public func placeSelected(name: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "place_selected",
                                          properties: ["name": name])
        }
        #endif
    }
    
    public func categorySelected(name: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "category_selected",
                                          properties: ["name": name])
        }
        #endif
    }
    
    public func noStoresNearBy(lat: Double, lng: Double) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "no_stores_nearby",
                                          properties: ["lat": lat,
                                                       "lng": lng])
        }
        #endif
    }
    
    public func nearestStoreClosed(lat: Double, lng: Double, deliveryAddress: String, storeName: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "nearest_store_closed",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "location": deliveryAddress,
                                                       "store": storeName])
        }
        #endif
    }
    
    public func nearestStoreTemporarilyClosed(lat: Double, lng: Double, deliveryAddress: String, storeName: String) {
        #if !DEBUG
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            Mixpanel.mainInstance().track(event: "nearest_store_temp_closed",
                                          properties: ["lat": lat,
                                                       "lng": lng,
                                                       "location": deliveryAddress,
                                                       "store": storeName])
        }
        #endif
    }
    
    @objc public func walletReloadedWith(amount: NSDecimalNumber) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "prepaid",
                                                                   action: "transaction",
                                                                   label: "reload",
                                                                   value: amount).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            let properties: [String : MixpanelType] = ["amount" : amount.doubleValue,
                                                       "success": true]
            
            Mixpanel.mainInstance().track(event: "wallet_reload_init",
                                          properties : properties)
        }
        #endif
        //        Wallet reload/purchase in-store:
        //        In the wallet screen, a user might reload or make a purchase using the wallet in-store. To detect an offline action with the wallet, we need to rely on the wallet data refreshed from the server. If the wallet balance from the server is more than that in the app, it was a "reload". If the balance from server is smaller, it was a "purchase".
    }
    
    @objc public func orderPlacedUsingWallet(amount: NSDecimalNumber) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "prepaid",
                                                                   action: "transaction",
                                                                   label: "purchase",
                                                                   value: amount).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
        }
        #endif
        //        Wallet reload/purchase in-store:
        //        In the wallet screen, a user might reload or make a purchase using the wallet in-store. To detect an offline action with the wallet, we need to rely on the wallet data refreshed from the server. If the wallet balance from the server is more than that in the app, it was a "reload". If the balance from server is smaller, it was a "purchase".
    }
    
    public func itemDetailsDisplayed(itemObject: ItemObject) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            product.setId("\(itemObject.id)")
            product.setName(itemObject.itemTitle)
            product.setCategory(itemObject.category.name)
            
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPADetail)
            
            let screenBuilder: GAIDictionaryBuilder = GAIDictionaryBuilder.createScreenView()!
            screenBuilder.add(product)
            screenBuilder.setProductAction(productAction)
            
            tracker.send(screenBuilder.build() as! [AnyHashable : Any])
        }
        
        if let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() {
            tracker.trackEvent(AFEventContentView,
                               withValues: [AFEventParamContentId: itemObject.id,
                                            AFEventParamPrice: itemObject.totalAmount,
                                            AFEventParamContentType: "item_view",
                                            AFEventParamContent: itemObject.itemTitle,
                                            AFEventParamCurrency: "INR"])
        }
        #endif
    }
    
    public func itemAddedToCart(itemObject: ItemObject) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            product.setId("\(itemObject.id!)")
            product.setName(itemObject.itemTitle)
            product.setQuantity(itemObject.quantity as NSNumber)
            product.setPrice(itemObject.totalAmount as NSNumber)
            product.setCategory(itemObject.category.name)
            
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPAAdd)
            
            let screenBuilder: GAIDictionaryBuilder = GAIDictionaryBuilder.createScreenView()!
            screenBuilder.add(product)
            screenBuilder.setProductAction(productAction)
            
            tracker.send(screenBuilder.build() as! [AnyHashable : Any])
        }
        
        if let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() {
            tracker.trackEvent(AFEventAddToCart,
                               withValues: [AFEventParamContentId: itemObject.id,
                                            AFEventParamPrice: itemObject.totalAmount,
                                            AFEventParamQuantity : itemObject.quantity,
                                            AFEventParamCurrency: "INR"])
        }
        #endif
    }
    
    public func itemRemovedFromCart(itemObject: ItemObject) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            
            let product: GAIEcommerceProduct = GAIEcommerceProduct()
            product.setId("\(itemObject.id!)")
            product.setName(itemObject.itemTitle)
            product.setQuantity(itemObject.quantity as NSNumber)
            product.setPrice(itemObject.totalAmount as NSNumber)
            product.setCategory(itemObject.category.name)
            
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPARemove)
            
            let screenBuilder: GAIDictionaryBuilder = GAIDictionaryBuilder.createScreenView()!
            screenBuilder.add(product)
            screenBuilder.setProductAction(productAction)
            
            tracker.send(screenBuilder.build() as! [AnyHashable : Any])
        }
        
        #endif
    }
    
    public func orderPlaced(orderId: String, phone: String, orderPaymentDataModel: OrderPaymentDataModel) {
        #if !DEBUG
        if let tracker: GAITracker = GAI.sharedInstance().defaultTracker {
            
            let eventDictionary: [AnyHashable : Any] = GAIDictionaryBuilder.createEvent(withCategory: "ordering",
                                                                   action: "purchase",
                                                                   label: "success",
                                                                   value: orderPaymentDataModel.itemsTotalPrice as NSNumber).build() as! [AnyHashable : Any]
            tracker.send(eventDictionary)
            
            let eventBuilder = GAIDictionaryBuilder.createEvent(withCategory: nil, action: nil, label: nil, value: nil)!
            
            let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
            productAction.setAction(kGAIPAPurchase)
            productAction.setTransactionId(orderId)
            productAction.setAffiliation("UrbanPiper")
            productAction.setRevenue(NSDecimalNumber(decimal: orderPaymentDataModel.itemsTotalPrice))
            productAction.setTax(NSDecimalNumber(decimal: orderPaymentDataModel.itemTaxes ?? Decimal.zero))
            
            let deliveryCharge = orderPaymentDataModel.selectedDeliveryOption == .pickUp ? Decimal.zero : orderPaymentDataModel.deliveryCharge
            productAction.setShipping(NSDecimalNumber(decimal: deliveryCharge))
            productAction.setCheckoutOption(orderPaymentDataModel.selectedPaymentOption.rawValue)
            
            let couponCode = orderPaymentDataModel.applyCouponResponse != nil ? orderPaymentDataModel.couponCode : nil
            productAction.setCouponCode(couponCode)
            
            if let items = orderPaymentDataModel.orderResponse?.items {
                for item in items {
                    let product: GAIEcommerceProduct = GAIEcommerceProduct()
                    product.setId("\(item.id)")
                    product.setName(item.itemTitle)
                    product.setQuantity(NSNumber(value: item.quantity))
                    product.setPrice(NSDecimalNumber(decimal: item.itemPrice))
                    product.setCategory(item.category.name)
                    
                    eventBuilder.add(product)
                }
            }
            
            eventBuilder.setProductAction(productAction)
            tracker.send(eventBuilder.build() as! [AnyHashable : Any])
        }
        
        if let tracker: AppsFlyerTracker = AppsFlyerTracker.shared() {
            tracker.trackEvent(AFEventPurchase,
                               withValues: [AFEventParamContentId: "",
                                            AFEventParamContentType: "",
                                            AFEventParamRevenue: orderPaymentDataModel.itemsTotalPrice,
                                            AFEventParamCurrency: "INR"])
        }
        
        if let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            var itemsDictionaryArray = [[String: Any]]()
            
            for item in orderPaymentDataModel.orderResponse!.items {
                itemsDictionaryArray.append(item.toDictionary())
            }
            
            var properties: [String : MixpanelType] = ["order_total" : NSDecimalNumber(decimal: orderPaymentDataModel.itemsTotalPrice).doubleValue,
                                                       "num_items": orderPaymentDataModel.orderResponse!.items.count,
                                                       "payment_option" : orderPaymentDataModel.selectedPaymentOption.rawValue,
                                                       "store" : OrderingStoreDataModel.shared.nearestStoreResponse!.store!.name,
                                                       "order_phone" : phone,
                                                       "channel" : orderPaymentDataModel.orderResponse!.channel,
                                                       "order_id" : orderId,
                                                       "interval_of_day" : Date.currentHourRangeString,
                                                       "items" : itemsDictionaryArray]
            
            if orderPaymentDataModel.applyCouponResponse != nil {
                properties["coupon_txt"] = orderPaymentDataModel.couponCode!
                properties["order_discount"] = NSDecimalNumber(decimal: orderPaymentDataModel.discountPrice!).doubleValue
            }
            
            if CartManager.shared.isReorder {
                Mixpanel.mainInstance().track(event: "reorder",
                                              properties : properties)
            } else {
                Mixpanel.mainInstance().track(event: "order_placed",
                                              properties : properties)
            }
            
            Mixpanel.mainInstance().people.trackCharge(amount: properties["order_total"] as! Double,
                                                       properties: properties)
        }
        #endif
    }
    
    public func setMixpanelPeople() {
        #if !DEBUG
        if let user = AppUserDataModel.shared.validAppUserData,
            let token: String = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, token.count > 0 {
            
            let mixpanel = Mixpanel.mainInstance()
            mixpanel.identify(distinctId: user.phoneNumberWithCountryCode)
            mixpanel.identify(distinctId: mixpanel.distinctId)
            
            if let bizObject = AppUserDataModel.shared.bizInfo?.objects.last {
                var properties: Properties = ["$email": user.email,
                                  "$phone": user.phoneNumberWithCountryCode,
                                  "balance": bizObject.balance.doubleValue,
                                  "$name": user.firstName,
                                  "last_order_dt": bizObject.lastOrderDateString] as [String : MixpanelType]
                
                if let val = bizObject.cardNumbers.last {
                    properties["cardNumber"] = val
                }
                
                if let val = bizObject.lastUpdatedDateString {
                    properties["userInfoUpdated"] = val
                }
                
                if let val = bizObject.totalOrderValue {
                    properties["total_order_value"] = val
                }
                
                if let val = bizObject.numOfOrders {
                    properties["num_of_orders"] = val
                }
                
                if let val = bizObject.daysSinceLastOrder {
                    properties["days_since_last_order"] = val
                }
                
                mixpanel.people.set(properties: properties)
            } else {
                mixpanel.people.set(properties: ["$email": user.email ?? "",
                                                 "$phone": user.phoneNumberWithCountryCode,
                                                 "$name": user.firstName ?? ""])
            }
        }
        #endif
    }
}
