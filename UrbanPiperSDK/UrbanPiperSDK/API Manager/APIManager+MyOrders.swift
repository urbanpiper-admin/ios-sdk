//
//  APIManager+MyOrders.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import Foundation

extension APIManager {

    public func fetchOrderHistory(limit: Int? = nil,
                                  next: String? = nil,
                                  completion: ((MyOrdersResponse?) -> Void)?,
                                  failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v2/orders/"
        
        if let nextUrlString: String = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        } else if let orderFetchLimit: Int = limit {
            urlString = "\(urlString)?limit=\(orderFetchLimit)"
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let myOrdersResponse: MyOrdersResponse = MyOrdersResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completion?(myOrdersResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }

        }

        return dataTask
    }
    
    public func fetchOrderDetails(orderId: Int,
                                  completion: ((MyOrderDetailsResponse?) -> Void)?,
                                  failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/orders/\(orderId)/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let myOrderDetailsResponse: MyOrderDetailsResponse = MyOrderDetailsResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(myOrderDetailsResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }

}
