//
//  APIManager+Items.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {

    func fetchCategoryItems(categoryId: Int,
                            locationID: Int?,
                            isForcedRefresh: Bool,
                            next: String?,
                            completion: APICompletion<CategoryItemsResponse>?,
                            failure: APIFailure?) -> URLSessionTask {

        let canUseCachedResponse: Bool = AppConfigManager.shared.firRemoteConfigDefaults.enableCaching && !isForcedRefresh

        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        var urlString = "\(APIManager.baseUrl)/api/v1/order/categories/\(categoryId)/items/?format=json&biz_id=\(appId)"

        if let id = locationID {
            urlString = urlString.appending("&location_id=\(id)")
        }
        
        if let nextUrlString: String = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url,
                                    cachePolicy: canUseCachedResponse ? .useProtocolCachePolicy : .reloadIgnoringLocalAndRemoteCacheData)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
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
                if let failureClosure = failure {
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }

        }

        return dataTask
    }

    func fetchCategoryItems(for keyword: String,
                            locationID: Int?,
                            completion: APICompletion<ItemsSearchResponse>?,
                            failure: APIFailure?) -> URLSessionTask {

        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        var urlString = "\(APIManager.baseUrl)/api/v1/search/items/?keyword=\(keyword)&biz_id=\(appId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        if let id = locationID {
            urlString = urlString!.appending("&location_id=\(id)")
        }

        let url: URL = URL(string: urlString!)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
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
                if let failureClosure = failure {
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }

        }

        return dataTask
    }

    func fetchItemDetails(itemId: Int,
                          locationID: Int?,
                          completion: APICompletion<ItemObject>?,
                          failure: APIFailure?) -> URLSessionTask {

        var urlString = "\(APIManager.baseUrl)/api/v1/items/\(itemId)/"

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

        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
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
                if let failureClosure = failure {
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }

        }

        return dataTask
    }

}

