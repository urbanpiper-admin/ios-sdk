//
//  APIManager+Reorder.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import Foundation
import CoreLocation

extension APIManager {

    public func reorder(orderId: Int,
                        userLocation: CLLocationCoordinate2D?,
                        bizLocationId: Int?,
                        completion: ((ReorderResponse?) -> Void)?,
                        failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v2/order/\(orderId)/reorder"

        if let location: CLLocationCoordinate2D = userLocation, location.latitude != 0, location.longitude != 0 {
            urlString = "\(urlString)/?lat=\(location.latitude)&lng=\(location.longitude)"
            if let locationId: Int = bizLocationId {
                urlString = "\(urlString)&location_id=\(locationId)"
            }
        } else if let locationId: Int = bizLocationId {
            urlString = "\(urlString)/?location_id=\(locationId)"
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let reorderResponse: ReorderResponse = ReorderResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completion?(reorderResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }

        }

        return dataTask
    }

}
