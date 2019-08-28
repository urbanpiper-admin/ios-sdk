//
//  Constants.swift
//  UrbanPiper
//
//  Created by Vid on 31/01/19.
//

import UIKit

/// Events that should be handled by the SDK client, the event are passed to the client via the callback of the SDK initializer
///
/// - sessionExpired: Indicates that the current user's session has expired and the user is being logged out
public enum SDKEvent {
    /// - sessionExpired: Indicates that the current user's session has expired and the user is being logged out
    case sessionExpired
}

/// Callback that is called when the api call succeeds with the relevant response object
public typealias APICompletion<T> = (T?) -> Void
/// Callback that is called when the api call fails with an error object
public typealias APIFailure = (UPError?) -> Void

/// Supported social login providers by UrbanPiper
///
/// - google: Google login
/// - facebook: Facebook login
public enum SocialLoginProvider: String {
    /// - google: Google login
    case google = "google"
    /// - facebook: Facebook login
    case facebook = "facebook"
}

internal enum OnlinePaymentPurpose: String {
    case reload = "reload"
    case ordering = "ordering"
}

/// Supported payment methods by UrbanPiper
///
/// - cash: Cash on delivery
/// - prepaid: Your business wallet payment
/// - paymentGateway: payment via payment gateway(i.e. razorpay, paytabs)
/// - paytm: PayTm payment method
/// - simpl: Simpl payment method
/// - paypal: Paypal payment method
/// - select: Select a payment method, Deprecated will be remove in future
public enum PaymentOption: String {
    /// - cash: Cash on delivery
    case cash = "cash"
    /// - prepaid: Your business wallet payment
    case prepaid = "prepaid"
    /// - paymentGateway: payment via payment gateway(i.e. razorpay, paytabs)
    case paymentGateway = "payment_gateway"
    /// - paytm: PayTm payment method
    case paytm = "paytm"
    /// - simpl: Simpl payment method
    case simpl = "simpl"
    /// - paypal: Paypal payment method
    case paypal = "paypal"
    /// - select: Select a payment method, Deprecated will be remove in future
    @available(*, deprecated, message: "the enum case will be removed in future")
    case select = "select"
}

/// Supported delivery methods by UrbanPiper
///
/// - delivery: Delivery to home
/// - pickUp: PickUp from store
public enum DeliveryOption: String {
    /// - delivery: Delivery to home
    case delivery = "delivery"
    /// - pickUp: PickUp from store
    case pickUp = "pickup"
}

/// Errors thrown by the `ItemOptionBuilder`
///
/// - invalid: This error is thrown by the build function if ItemOptions are not added as specified by the minSelectable and maxSelectable variables in the ItemOptionGroup
/// - maxItemOptionsSelected: This error is thrown by the addOption function when a item option is added to a group beyond maxSelectable variable in the ItemOptionGroup
public enum ItemOptionBuilderError: Error {
    /// - invalid: This error is thrown by the build function if ItemOptions are not added as specified by the minSelectable and maxSelectable variables in the ItemOptionGroup
    case invalid(group: ItemOptionGroup)
    /// - maxItemOptionsSelected: This error is thrown by the addOption function when a item option is added to a group beyond maxSelectable variable in the ItemOptionGroup
    case maxItemOptionsSelected(Int)
}

/// Error thrown by Cart
///
/// - itemQuantityNotAvaialble: This error is thrown by the `UrbanPiper.addItemToCart(...)` function in UrbanPiper when the quantity to be added + the current item quantity exceeds the variable value `Item.currentStock` in `Item` object, the associated value of the enum returns the max item quanity that can be added.
public enum CartError: Error {
    /// - itemQuantityNotAvaialble: This error is thrown by the `UrbanPiper.addItemToCart(...)` function in UrbanPiper when the quantity to be added + the current item quantity exceeds the variable value `Item.currentStock` in `Item` object, the associated value of the enum returns the max item quanity that can be added.
    case itemQuantityNotAvaialble(Int)
}

struct Constants {
    static let fetchLimit: Int = 100
}


public extension NSNotification.Name {
    
    /// Notification posted when the user's session has expired
    static let sessionExpired = NSNotification.Name("session-expired")
    /// Notification posted when the cart changes
    static let cartChanged = NSNotification.Name("cart-changed")
    /// Notification posted when the user details are changed
    static let userInfoChanged = NSNotification.Name("user-info-changed")
    /// Notification posted when the user biz details(i.e points, balance etc) are changed
    static let userBizInfoChanged = NSNotification.Name("user-biz-info-changed")

}

