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

        let urlString: String = "\(APIManager.baseUrl)/api/v1/galleries/?type=app_banner"

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        urlRequest.setValue(bizAuth(), forHTTPHeaderField: "Authorization")
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let bannersResponse: BannersResponse = BannersResponse(fromDictionary: dictionary)

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
