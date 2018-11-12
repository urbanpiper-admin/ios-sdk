//
//  APIManager+Items.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    func fetchCategoryOptions(id: Int,
                            completion: ((CategoryOptionsResponse?) -> Void)?,
                            failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.baseUrl)/api/v2/categories/\(id)/options/"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue(bizAuth(), forHTTPHeaderField: "Authorization")

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let categoryOptionsResponse: CategoryOptionsResponse = CategoryOptionsResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(categoryOptionsResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }

    func fetchCategoryItems(categoryId: Int,
                            locationID: Int?,
                            sortKey: String?,
                            filterOptions: [FilterOption]?,
                            isForcedRefresh: Bool,
                            next: String?,
                            completion: ((CategoryItemsResponse?) -> Void)?,
                            failure: APIFailure?) -> URLSessionDataTask {

        let canUseCachedResponse: Bool = AppConfigManager.shared.firRemoteConfigDefaults.enableCaching && !isForcedRefresh

        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        var urlString: String = "\(APIManager.baseUrl)/api/v1/order/categories/\(categoryId)/items/?format=json&biz_id=\(appId)"

        if let id = locationID {
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
        
        if let nextUrlString: String = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        }

        let url: URL = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        var urlRequest: URLRequest = URLRequest(url: url,
                                    cachePolicy: canUseCachedResponse ? .useProtocolCachePolicy : .reloadIgnoringLocalAndRemoteCacheData)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let categoryItemsResponse: CategoryItemsResponse = CategoryItemsResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(categoryItemsResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }

        }

        return dataTask
    }

    func fetchCategoryItems(for keyword: String,
                            next: String? = nil,
                            locationID: Int?,
                            completion: ((ItemsSearchResponse?) -> Void)?,
                            failure: APIFailure?) -> URLSessionDataTask {

        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        var urlString: String = "\(APIManager.baseUrl)/api/v2/search/items/?keyword=\(keyword)&biz_id=\(appId)"
        
        if let nextUrlString: String = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        }
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        if let id = locationID {
            urlString = urlString.appending("&location_id=\(id)")
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let itemsSearchResponse: ItemsSearchResponse = ItemsSearchResponse(fromDictionary: dictionary)
                    DispatchQueue.main.async {
                        completionClosure(itemsSearchResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }

        }

        return dataTask
    }

    func fetchItemDetails(itemId: Int,
                          locationID: Int?,
                          completion: ((ItemObject?) -> Void)?,
                          failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v1/items/\(itemId)/"

        let now: Date = Date()
        let timeInt = now.timeIntervalSince1970 * 1000

        if let id = locationID {
            urlString = urlString.appending("?location_id=\(id)&cx=\(timeInt)")
        } else {
            urlString = urlString.appending("?cx=\(timeInt)")
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let item: ItemObject = ItemObject(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(item)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }

        }

        return dataTask
    }

}

