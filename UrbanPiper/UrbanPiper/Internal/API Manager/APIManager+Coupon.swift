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
        case .applyCoupon(let coupon, _, _, _, _):
            return "api/v1/coupons/\(coupon)/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .offers(let offset, let limit):
            return ["offset": String(offset),
                    "limit": String(limit)]
        case .applyCoupon:
            return nil
        }
    }
    
    var headers: [String : String]? {
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
    
    var body: [String : AnyObject]? {
        switch self {
        case .offers:
            return nil
        case .applyCoupon(_, let storeId, let deliveryOption, let cartItems, let applyWalletCredits):
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

/* extension APIManager {
    
    func getOffers(offset: Int = 0,
                          limit: Int = Constants.fetchLimit,
                          completion: APICompletion<OffersAPIResponse>?,
                          failure: APIFailure?) -> URLSessionDataTask {

        let urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/?offset=\(offset)&limit=\(limit)"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
    }

    @discardableResult internal func apply(coupon: String,
                     storeId: Int,
                     deliveryOption: DeliveryOption,
                     cartItems: [CartItem],
                     applyWalletCredit: Bool,
                     completion: APICompletion<Order>?,
                        failure: APIFailure?) -> URLSessionDataTask {

        let order: [String: Any] = ["biz_location_id": storeId,
                                    "order_type": deliveryOption.rawValue,
                                    "channel": APIManager.channel,
                                    "items": cartItems.map { $0.toDictionary() },
                                    "apply_wallet_credit": applyWalletCredit] as [String: Any]
        
        let params: [String: Any] = ["order": order] as [String: Any]
        
        var urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/\(coupon)/"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
    }
    
}*/
