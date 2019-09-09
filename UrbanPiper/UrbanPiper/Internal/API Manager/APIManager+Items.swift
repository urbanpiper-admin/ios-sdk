    //
//  APIManager+Items.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum ItemsAPI {
    case filterAndSortOptions(categoryId: Int)
    case getCategoryItems(categoryId: Int, storeId: Int?, offset: Int, limit: Int, sortKey: String?, filterOptions: [FilterOption]?)
    case searchItems(query: String, storeId: Int?, offset: Int, limit: Int)
    case itemDetails(itemId: Int, storeId: Int?)
}

extension ItemsAPI: UPAPI {
    
    var path: String {
        switch self {
        case .filterAndSortOptions(let categoryId):
            return "api/v2/categories/\(categoryId)/options/"
        case .getCategoryItems(let categoryId, _, _, _, _, _):
            return "api/v1/order/categories/\(categoryId)/items/"
        case .searchItems:
            return "api/v2/search/items/"
        case .itemDetails(let itemId, _):
            return "api/v1/items/\(itemId)/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .filterAndSortOptions:
            return nil
        case .getCategoryItems(_, let storeId, let offset, let limit, let sortKey, let filterOptions):
            var params = ["format":"json",
                          "offset":String(offset),
                          "limit":String(limit),
                          "biz_id":APIManager.shared.bizId]
            
            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }
            
            if let key = sortKey {
                params["sort_by"] = key
            }
            
            if let options = filterOptions, options.count > 0 {
                let keysArray = options.map { String($0.id!) }
                let filterKeysString = keysArray.joined(separator: ",")
                params["filter_by"] = filterKeysString
            }
            
            return params
        case .searchItems(let query, let storeId, let offset, let limit):
            var params = ["keyword":query,
                          "offset":"\(offset)",
                          "limit":"\(limit)",
                          "biz_id":APIManager.shared.bizId]
            
            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }
            
            return params
        case .itemDetails(_, let storeId):
            
            let now: Date = Date()
            let timeInt = String(now.timeIntervalSince1970 * 1000)
            
            var params: [String : String] = ["cx" : timeInt]
            
            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }
            
            return params
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .filterAndSortOptions(_):
            return ["Authorization" : APIManager.shared.bizAuth()]
        case .getCategoryItems:
            return nil
        case .searchItems:
            return nil
        case .itemDetails:
            return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .filterAndSortOptions:
            return .GET
        case .getCategoryItems:
            return .GET
        case .searchItems:
            return .GET
        case .itemDetails:
            return .GET
        }
    }
    
    var body: [String : AnyObject]? {
        switch self {
        case .filterAndSortOptions:
            return nil
        case .getCategoryItems:
            return nil
        case .searchItems:
            return nil
        case .itemDetails:
            return nil
        }
    }
    
}

extension APIManager {
    
    func getFilterAndSortOptions(id: Int,
                            completion: ((CategoryOptionsResponse?) -> Void)?,
                            failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.baseUrl)/api/v2/categories/\(id)/options/"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        return apiRequest(urlRequest: &urlRequest, headers: ["Authorization" : bizAuth()], completion: completion, failure: failure)!
    }

    func getCategoryItems(categoryId: Int,
                            storeId: Int?,
                            offset: Int = 0,
                            limit: Int = Constants.fetchLimit,
                            sortKey: String? = nil,
                            filterOptions: [FilterOption]? = nil,
//                            isForcedRefresh: Bool,
//                            next: String?,
                            completion: ((CategoryItemsResponse?) -> Void)?,
                            failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v1/order/categories/\(categoryId)/items/?format=json&offset=\(offset)&limit=\(limit)&biz_id=\(bizId)"

        if let id = storeId {
            urlString = "\(urlString)&location_id=\(id)"
        }
        
        if let key = sortKey {
            urlString = "\(urlString)&sort_by=\(key)"
        }
        
        if let options = filterOptions, options.count > 0 {
            let keysArray = options.map { String($0.id!) }
            let filterKeysString = keysArray.joined(separator: ",")
            urlString = "\(urlString)&filter_by=\(filterKeysString)"
        }
        
//        if let nextUrlString: String = next {
//            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
//        }

        let url: URL = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        var urlRequest: URLRequest = URLRequest(url: url)
//        , cachePolicy: isForcedRefresh ? .reloadIgnoringLocalAndRemoteCacheData : .useProtocolCachePolicy)

        urlRequest.httpMethod = "GET"

        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)!
    }

    func searchItems(query: String,
                            storeId: Int?,
                            offset: Int = 0,
                            limit: Int = Constants.fetchLimit,
                            completion: ((ItemsSearchResponse?) -> Void)?,
                            failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v2/search/items/?keyword=\(query)&offset=\(offset)&limit=\(limit)&biz_id=\(bizId)"
        
//        if let nextUrlString: String = next {
//            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
//        }
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        if let id = storeId {
            urlString = urlString.appending("&location_id=\(id)")
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)!
    }

    func getItemDetails(itemId: Int,
                          storeId: Int?,
                          completion: ((Item?) -> Void)?,
                          failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v1/items/\(itemId)/"

        let now: Date = Date()
        let timeInt = now.timeIntervalSince1970 * 1000

        if let id = storeId {
            urlString = urlString.appending("?location_id=\(id)&cx=\(timeInt)")
        } else {
            urlString = urlString.appending("?cx=\(timeInt)")
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        return apiRequest(urlRequest: &urlRequest, completion: { (item: Item?) in
            item?.isItemDetailsItem = true
            completion?(item)
        }, failure: failure)!
    }

}

