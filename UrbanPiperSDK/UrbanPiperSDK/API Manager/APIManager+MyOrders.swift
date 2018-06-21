//
//  APIManager+MyOrders.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit

extension APIManager {

    public func fetchOrderHistory(completion: APICompletion<MyOrdersResponse>?,
                                  failure: APIFailure?) -> URLSessionTask {

        let bizAppId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString = "\(APIManager.baseUrl)/api/v1/user/history/?format=json&biz_id=\(bizAppId)&type=order"

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let myOrdersResponse = MyOrdersResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completion?(myOrdersResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion?(nil)
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
