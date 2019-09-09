//
//  APIManager+Recomendation.swift
//  UrbanPiper
//
//  Created by Vid on 10/07/18.
//

import UIKit

enum FeaturedItemsAPI {
    case featuredItems(itemIds: [Int], storeId: Int?, offset: Int, limit: Int)
}

extension FeaturedItemsAPI: UPAPI {
    var path: String {
        switch self {
        case .featuredItems(let itemIds, _, _, _):
            let itemIdsString = itemIds.map { "\($0)" }.joined(separator: ",")
            return "api/v2/items/\(itemIdsString)/recommendations/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .featuredItems(_, let storeId, let offset, let limit):
            var params = ["offset":String(offset),
                    "limit":String(limit)]
            
            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }
            
            return params
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .featuredItems:
            return ["Authorization" : APIManager.shared.bizAuth()]
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .featuredItems:
            return .GET
        }
    }
    
    var body: [String : AnyObject]? {
        switch self {
        case .featuredItems:
            return nil
        }
    }
    
}

extension APIManager {

    func getFeaturedItems(itemIds: [Int] = [0],
                       storeId: Int?,
                       offset: Int = 0,
                       limit: Int = Constants.fetchLimit,
                       completion: ((CategoryItemsResponse?) -> Void)?,
                       failure: APIFailure?) -> URLSessionDataTask {
        let itemIdsString = itemIds.map { "\($0)" }.joined(separator: ",")
        var urlString: String = "\(APIManager.baseUrl)/api/v2/items/\(itemIdsString)/recommendations/?offset=\(offset)&limit=\(limit)"
        
        if let id = storeId {
            urlString = "\(urlString)&location_id=\(id)"
        }
        
//        if let nextUrlString: String = next {
//            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
//        }
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, headers: ["Authorization" : bizAuth()], completion: completion, failure: failure)!
    }
    
}
