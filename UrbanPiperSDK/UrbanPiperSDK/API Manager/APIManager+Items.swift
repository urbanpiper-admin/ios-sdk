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

        let canUseCachedResponse = AppConfigManager.shared.firRemoteConfigDefaults.enableCaching && !isForcedRefresh

        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        var urlString = "\(APIManager.baseUrl)/api/v1/order/categories/\(categoryId)/items/?format=json&biz_id=\(appId)"

        if let id = locationID {
            urlString = urlString.appending("&location_id=\(id)")
        }
        
        if let nextUrlString = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        }

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url,
                                    cachePolicy: canUseCachedResponse ? .useProtocolCachePolicy : .reloadIgnoringLocalAndRemoteCacheData)

        urlRequest.httpMethod = "GET"

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let categoryItemsResponse = CategoryItemsResponse(fromDictionary: dictionary)

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
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }

        }

        return task
    }

    func fetchCategoryItems(for keyword: String,
                            locationID: Int?,
                            completion: APICompletion<ItemsSearchResponse>?,
                            failure: APIFailure?) -> URLSessionTask {

        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        var urlString = "\(APIManager.baseUrl)/api/v1/search/items/?keyword=\(keyword)&biz_id=\(appId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        if let id = locationID {
            urlString = urlString!.appending("&location_id=\(id)")
        }

        let url = URL(string: urlString!)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let itemsSearchResponse = ItemsSearchResponse(fromDictionary: dictionary)

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
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }

        }

        return task
    }

    func fetchItemDetails(itemId: Int,
                          locationID: Int?,
                          completion: APICompletion<ItemObject>?,
                          failure: APIFailure?) -> URLSessionTask {

        var urlString = "\(APIManager.baseUrl)/api/v1/items/\(itemId)/"

        let now = Date()
        let timeInt = now.timeIntervalSince1970 * 1000

        if let id = locationID {
            urlString = urlString.appending("?location_id=\(id)&cx=\(timeInt)")
        } else {
            urlString = urlString.appending("?cx=\(timeInt)")
        }

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let item = ItemObject(fromDictionary: dictionary)

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
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }

        }

        return task
    }

}

