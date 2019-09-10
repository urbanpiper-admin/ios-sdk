//
//  APIManager+Ordering.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum CategoriesAPI {
    case categories(storeId: Int?, offset: Int, limit: Int)
}

extension CategoriesAPI: UPAPI {
    var path: String {
        switch self {
        case .categories:
            return "api/v1/order/categories/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .categories(let storeId, let offset, let limit):
            var params = ["format":"json",
                    "offset": String(offset),
                    "limit": String(limit),
                    "biz_id": APIManager.shared.bizId]
            
            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }
            
            return params
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .categories:
            return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .categories:
            return .GET
        }
    }
    
    var body: [String : AnyObject]? {
        switch self {
        case .categories:
            return nil
        }
    }
    
}

extension APIManager {

    func getCategories(storeId: Int?,
                             offset: Int = 0,
                             limit: Int = Constants.fetchLimit,
//                             isForceRefresh: Bool,
        completion: ((CategoriesResponse?) -> Void)?,
        failure: APIFailure?) -> URLSessionDataTask {

//        /api/v1/order/categories/1419/items/?format=json&limit=50&offset=50&biz_id=14632907
        var urlString: String = "\(APIManager.baseUrl)/api/v1/order/categories/?format=json&offset=\(offset)&limit=\(limit)&biz_id=\(bizId)"

        if let id = storeId {
            urlString = "\(urlString)&location_id=\(id)"
        }
        
        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)
//        , cachePolicy: isForceRefresh ? .reloadIgnoringLocalAndRemoteCacheData : .useProtocolCachePolicy)

        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
    }
    
}
