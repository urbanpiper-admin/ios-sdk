//
//  APIManager+Banners.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 10/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {

    @objc public func fetchBannersList(completion: APICompletion<BannersResponse>?,
                                failure: APIFailure?) -> URLSessionTask {

        let urlString = "\(APIManager.baseUrl)/api/v1/galleries/?type=app_banner"

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        urlRequest.setValue(bizAuth(), forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let bannersResponse = BannersResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(bannersResponse)
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
