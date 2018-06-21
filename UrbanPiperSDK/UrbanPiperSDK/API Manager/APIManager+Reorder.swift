//
//  APIManager+Reorder.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit
import CoreLocation

extension APIManager {

    public func reorder(orderId: Int,
                        userLocation: CLLocationCoordinate2D?,
                        bizLocationId: Int?,
                        completion: APICompletion<ReorderResponse>?,
                        failure: APIFailure?) -> URLSessionTask {

        let bizAppId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        var urlString = "\(APIManager.baseUrl)/api/v2/order/\(orderId)/reorder"

        if let location = userLocation, location.latitude != 0, location.longitude != 0 {
            urlString = urlString + "/?lat=\(location.latitude)&lng=\(location.longitude)"
            if let locationId = bizLocationId {
                urlString = urlString + "&location_id=\(locationId)"
            }
        } else if let locationId = bizLocationId {
            urlString = urlString + "/?location_id=\(locationId)"
        }

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let reorderResponse = ReorderResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completion?(reorderResponse)
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
