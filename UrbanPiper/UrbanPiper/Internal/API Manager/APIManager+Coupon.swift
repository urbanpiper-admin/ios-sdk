//
//  APIManager+Coupon.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum OffersAPI {
    case offers(offset: Int, limit: Int)
    case applyCoupon(coupon: String, storeId: Int, deliveryOption: DeliveryOption, cartItems: [CartItem], applyWalletCredits: Bool)
}

extension OffersAPI: UPAPI {
    var path: String {
        switch self {
        case .offers:
            return "api/v1/coupons/"
        case let .applyCoupon(coupon, _, _, _, _):
            return "api/v1/coupons/\(coupon)/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .offers(offset, limit):
            return ["offset": String(offset),
                    "limit": String(limit)]
        case .applyCoupon:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .offers:
            return nil
        case .applyCoupon:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .offers:
            return .GET
        case .applyCoupon:
            return .POST
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .offers:
            return nil
        case let .applyCoupon(_, storeId, deliveryOption, cartItems, applyWalletCredits):
            let order: [String: Any] = ["biz_location_id": storeId,
                                        "order_type": deliveryOption.rawValue,
                                        "channel": APIManager.channel,
                                        "items": cartItems.map { $0.toDictionary() },
                                        "apply_wallet_credit": applyWalletCredits] as [String: Any]

            let params: [String: AnyObject] = ["order": order] as [String: AnyObject]
            return params
        }
    }
}
