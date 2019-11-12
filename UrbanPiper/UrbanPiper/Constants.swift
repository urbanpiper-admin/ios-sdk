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
public typealias APIFailure = (Error?) -> Void

/// Supported social login providers by UrbanPiper
///
/// - google: Google login
/// - facebook: Facebook login
public enum SocialLoginProvider: String {
    /// - google: Google login
    case google
    /// - facebook: Facebook login
    case facebook
    /// - apple: Apple login
    case apple
}

internal enum OnlinePaymentPurpose: String {
    case reload
    case ordering
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
    case cash
    /// - prepaid: Your business wallet payment
    case prepaid
    /// - paymentGateway: payment via payment gateway(i.e. razorpay, paytabs)
    case paymentGateway = "payment_gateway"
    /// - paytm: PayTm payment method
    case paytm
    /// - simpl: Simpl payment method
    case simpl
    /// - paypal: Paypal payment method
    case paypal
    /// - select: Select a payment method, Deprecated will be remove in future
    @available(*, deprecated, message: "the enum case will be removed in future")
    case select
}

/// Supported delivery methods by UrbanPiper
///
/// - delivery: Delivery to home
/// - pickUp: PickUp from store
public enum DeliveryOption: String {
    /// - delivery: Delivery to home
    case delivery
    /// - pickUp: PickUp from store
    case pickUp = "pickup"
}

/// Errors thrown by the `ItemOptionBuilder`
///
/// - invalid: This error is thrown by the build function if ItemOptions are not added as specified by the minSelectable and maxSelectable variables in the ItemOptionGroup
/// - maxItemOptionsSelected: This error is thrown by the addOption function when a item option is added to a group beyond maxSelectable variable in the ItemOptionGroup
public enum ItemOptionBuilderError: Error {
    /// - invalid: This error is thrown by the build function if ItemOptions are not added as specified by the minSelectable and maxSelectable variables in the ItemOptionGroup
    case invalid(group: OptionGroup)
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

public enum AddressTag: String {
    case home
    case office = "work"
    case other
}

public enum Language: String {
    case english = "en"
    case hindi = "hi"
    case japanese = "ja"
    case arabic = "ar"

    public var displayName: String {
        switch self {
        case .english:
            return "English"
        case .hindi:
            return "Hindi"
        case .japanese:
            return "Japanese"
        case .arabic:
            return "Arabic"
        }
    }
}

public enum MessageType: String {
    case info
    case alert
    case promo
    case coupon
    case reward
    case cashback
}

public enum OrderStatus: String {
    case cancelled
    case expired
    case completed
    case placed
    case acknowledged
    case dispatched
    case awaitingPayment = "awaiting_payment"

    public var displayName: String {
        switch self {
        case .cancelled:
            return "Cancelled"
        case .expired:
            return "Expired"
        case .completed:
            return "Completed"
        case .placed:
            return "Placed"
        case .acknowledged:
            return "Acknowledged"
        case .dispatched:
            return "Dispatched"
        case .awaitingPayment:
            return "Awaiting Payment"
        }
    }

    public var displayColor: UIColor {
        switch self {
        case .cancelled:
            return #colorLiteral(red: 0.631372549, green: 0.1529411765, blue: 0, alpha: 1)
        case .expired:
            return #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
        case .completed:
            return #colorLiteral(red: 0, green: 0.4235294118, blue: 0.2235294118, alpha: 1)
        case .placed:
            return #colorLiteral(red: 0.5568627451, green: 0.2666666667, blue: 0.6784313725, alpha: 1)
        case .acknowledged:
            return #colorLiteral(red: 0.1607843137, green: 0.5019607843, blue: 0.7254901961, alpha: 1)
        case .dispatched:
            return #colorLiteral(red: 0.1725490196, green: 0.2431372549, blue: 0.3137254902, alpha: 1)
        case .awaitingPayment:
            return #colorLiteral(red: 0.0862745098, green: 0.6274509804, blue: 0.5215686275, alpha: 1.0)
        }
    }
}

public enum PaymentType: String {
    case paytm
    case paytabs
}

public enum UserStatus: Int, RawRepresentable {
    case registrationRequired
    case phoneNumberRequired
    case verifyPhoneNumber
    case registrationSuccessfullVerifyOTP
    case otpSent
    case valid

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        switch rawValue {
        case "new_registration_required": self = .registrationRequired
        case "phone_number_required": self = .phoneNumberRequired
        case "userbiz_phone_not_validated": self = .verifyPhoneNumber
        case "User has successfully been registered and validated": self = .valid
        case "User has successfully been registered.": self = .registrationSuccessfullVerifyOTP
        case "otp_sent": self = .otpSent
        default:
            return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .registrationRequired: return "new_registration_required"
        case .phoneNumberRequired: return "phone_number_required"
        case .verifyPhoneNumber: return "userbiz_phone_not_validated"
        case .registrationSuccessfullVerifyOTP: return "User has successfully been registered."
        case .otpSent: return "otp_sent"
        case .valid: return "User has successfully been registered and validated"
        }
    }
}

@objc public enum FoodType: Int, RawRepresentable {
    case veg = 1
    case nonVeg = 2
    case eggtarian = 3
}

public let UPAPIError: Int = -50
public let UPAPIServerError: Int = -60

struct Constants {
    static let fetchLimit: Int = 100
}

public struct Simpl {
    public let isAuthorized: Bool
    public let isFirstTransaction: Bool
    public let buttonText: String?
    public let error: Error?

    public init(isAuthorized: Bool, isFirstTransaction: Bool, buttonText: String?, error: Error?) {
        self.isAuthorized = isAuthorized
        self.isFirstTransaction = isFirstTransaction
        self.buttonText = buttonText
        self.error = error
    }
}

public struct SelectionQuantity {
    public static let unlimited = -1
    public static let none = 0
    public static let one = 1
}

public struct StockQuantity {
    public static let unlimited = -1
    public static let noStock = 0
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
