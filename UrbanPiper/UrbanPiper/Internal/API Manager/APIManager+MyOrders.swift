//
//  APIManager+MyOrders.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import Foundation

enum PastOrdersAPI {
    case pastOrders(offset: Int, limit: Int)
    case pastOrderDetails(orderId: Int)
}

extension PastOrdersAPI: UPAPI {
    var path: String {
        switch self {
        case .pastOrders:
            return "api/v2/orders/"
        case .pastOrderDetails(let orderId):
            return "api/v2/orders/\(orderId)/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .pastOrders(let offset, let limit):
            return ["offset": String(offset),
                    "limit": String(limit)]
        case .pastOrderDetails:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .pastOrders:
            return nil
        case .pastOrderDetails:
            return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .pastOrders:
            return .GET
        case .pastOrderDetails:
            return .GET
        }
    }
    
    var body: [String : AnyObject]? {
        switch self {
        case .pastOrders:
            return nil
        case .pastOrderDetails:
            return nil
        }
    }
    
}

extension APIManager {
    
    internal func getPastOrders(offset: Int = 0,
                                limit: Int = Constants.fetchLimit,
                                next: String? = nil,
                                completion: ((PastOrdersResponse?) -> Void)?,
                                failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v2/orders/"
        
        if let nextUrlString: String = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        } else {
            urlString = "\(urlString)?offset=\(offset)&limit=\(limit)"
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
    }
    
    @objc internal func getPastOrderDetails(orderId: Int,
                                  completion: ((PastOrderDetailsResponse?) -> Void)?,
                                  failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/orders/\(orderId)/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
    }

}
