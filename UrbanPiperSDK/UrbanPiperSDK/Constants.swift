//
//  Constants.swift
//  UrbanPiperSDK
//
//  Created by Vid on 31/01/19.
//

import UIKit

public typealias APICompletion<T> = (T?) -> Void
public typealias APIFailure = (UPError?) -> Void

public enum SocialLoginProvider: String {
    case google = "google"
    case facebook = "facebook"
}

public enum OnlinePaymentPurpose: String {
    case reload = "reload"
    case ordering = "ordering"
}

public enum PaymentOption: String {
    case cash = "cash"
    case prepaid = "prepaid"
    case paymentGateway = "payment_gateway"
    case paytm = "paytm"
    case simpl = "simpl"
    case paypal = "paypal"
    case select = "select"
}

public enum DeliveryOption: String {
    case delivery = "delivery"
    case pickUp = "pickup"
}

public enum ItemOptionBuilderError: Error {
    case invalid(group: ItemOptionGroup)
    case maxItemOptionsSelected(Int)
}

public enum CartError: Error {
    case maxOrderableQuantityAdded(Int)
}

struct Constants {

    static let isNotFirstLaunchKey: String = "IsNotFirstLaunchKey"

    static let fetchLimit: Int = 20
}


public extension NSNotification.Name {
    
    public static let upSDKTokenExpired = NSNotification.Name("upsdk-token-expired")
    public static let cartChanged = NSNotification.Name("cart-changed")
    public static let userInfoChanged = NSNotification.Name("user-info-changed")
    public static let userBizInfoChanged = NSNotification.Name("user-biz-info-changed")

}

