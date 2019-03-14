//
//  APIManager+MyOrders.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import Foundation

extension APIManager {

    internal func getHistory(completion: (([String : Any]?) -> Void)?,
                             failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/history/?format=json&biz_id=\(bizId)&type=order"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> [String: Any]? in
            return dictionary
        }, completion: completion, failure: failure)!
    }
    
    internal func getPastOrders(limit: Int? = nil,
                                  next: String? = nil,
                                  completion: ((PastOrdersResponse?) -> Void)?,
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
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> PastOrdersResponse? in
            return PastOrdersResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

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
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }

        }

        return dataTask*/
    }
    
    @objc internal func getPastOrderDetails(orderId: Int,
                                  completion: ((PastOrderDetailsResponse?) -> Void)?,
                                  failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/orders/\(orderId)/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> PastOrderDetailsResponse? in
            return PastOrderDetailsResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let myOrderDetailsResponse: PastOrderDetailsResponse = PastOrderDetailsResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(myOrderDetailsResponse)
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
