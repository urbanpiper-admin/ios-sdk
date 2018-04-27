//
//  APIManager+NearestStore.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 10/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit
import CoreLocation

extension APIManager {

    @objc public func fetchNearestStore(_ coordinates: CLLocationCoordinate2D,
                                 completion: APICompletion<StoreResponse>?,
                                 failure: APIFailure?) -> URLSessionTask {

        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(appId)&lat=\(coordinates.latitude)&lng=\(coordinates.longitude)"

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let storeDetail = StoreResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(storeDetail)
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
