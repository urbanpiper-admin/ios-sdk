//
//  APIManager+Coupon.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {

    @objc public func apply(coupon: String,
                     storeLocationId: Int,
                     deliveryOption: String,
                     items: [[String: Any]],
                     applyWalletCredit: Bool,
                     completion: APICompletion<Order>?,
                        failure: APIFailure?) -> URLSessionTask {

        let params = ["order": ["biz_location_id": storeLocationId,
                                "order_type": deliveryOption,
                                "channel": APIManager.channel,
                                "items": items,
                                "apply_wallet_credit": applyWalletCredit]] as [String : Any]
        
        let urlString = "\(APIManager.baseUrl)/api/v1/coupons/\(coupon)/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let applyCouponResponse = Order(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(applyCouponResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }
    
}
