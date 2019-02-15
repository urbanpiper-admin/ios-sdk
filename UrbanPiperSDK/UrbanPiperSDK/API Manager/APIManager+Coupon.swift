//
//  APIManager+Coupon.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    func getOffers(offset: Int = 0,
                          limit: Int = Constants.fetchLimit,
                          completion: ((OffersAPIResponse?) -> Void)?,
                          failure: APIFailure?) -> URLSessionDataTask {

        let urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/?offset=\(offset)&limit=\(limit)"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> OffersAPIResponse? in
            return OffersAPIResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let offersAPIResponse: OffersAPIResponse = OffersAPIResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(offersAPIResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask*/
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
                                    "apply_wallet_credit": applyWalletCredit] as [String: Any]
        
        let params: [String: Any] = ["order": order] as [String: Any]
        
        var urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/\(coupon)/"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> Order? in
            return Order(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let applyCouponResponse: Order = Order(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(applyCouponResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask*/
    }
    
}
