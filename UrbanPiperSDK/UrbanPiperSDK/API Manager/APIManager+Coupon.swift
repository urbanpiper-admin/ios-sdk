//
//  APIManager+Coupon.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    @objc public func availableCoupons(next: String?,
                                       completion: ((OffersAPIResponse?) -> Void)?,
                                       failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/"
        
        if let nextUrlString: String = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        }

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let offersAPIResponse: OffersAPIResponse = OffersAPIResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(offersAPIResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }

    @objc public func apply(coupon: String,
                     storeLocationId: Int,
                     deliveryOption: String,
                     items: [[String: Any]],
                     applyWalletCredit: Bool,
                     completion: ((Order?) -> Void)?,
                        failure: APIFailure?) -> URLSessionDataTask {

        let order: [String: Any] = ["biz_location_id": storeLocationId,
                                    "order_type": deliveryOption,
                                    "channel": APIManager.channel,
                                    "items": items,
                                    "apply_wallet_credit": applyWalletCredit] as [String : Any]
        
        let params: [String : Any] = ["order": order] as [String : Any]
        
        var urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/\(coupon)/"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let applyCouponResponse: Order = Order(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(applyCouponResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
}
