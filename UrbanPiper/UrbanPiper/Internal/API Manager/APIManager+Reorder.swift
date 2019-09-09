//
//  APIManager+Reorder.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import Foundation
import CoreLocation

enum ReorderAPI {
    case reorder(orderId: Int, userLocation: CLLocationCoordinate2D?, storeId: Int?)
}

extension ReorderAPI: UPAPI {
    var path: String {
        switch self {
        case .reorder(let orderId, _, _):
            return "api/v2/order/\(orderId)/reorder"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .reorder(_, let userLocation, let storeId):
            var params = [String : String]()
            
            if let lat = userLocation?.latitude, let lng = userLocation?.longitude, lat != 0, lng != 0 {
                params["lat"] = String(lat)
                params["lng"] = String(lng)
            }
            
            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }
            
            return params
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .reorder:
            return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .reorder:
            return .GET
        }
    }
    
    var body: [String : AnyObject]? {
        switch self {
        case .reorder:
            return nil
        }
    }
    
}

extension APIManager {

    internal func reorder(orderId: Int,
                        userLocation: CLLocationCoordinate2D?,
                        storeId: Int?,
                        completion: ((ReorderResponse?) -> Void)?,
                        failure: APIFailure?) -> URLSessionDataTask {

        var urlString: String = "\(APIManager.baseUrl)/api/v2/order/\(orderId)/reorder"

        if let location: CLLocationCoordinate2D = userLocation, location.latitude != 0, location.longitude != 0 {
            urlString = "\(urlString)/?lat=\(location.latitude)&lng=\(location.longitude)"
            if let storeId: Int = storeId {
                urlString = "\(urlString)&location_id=\(storeId)"
            }
        } else if let storeId: Int = storeId {
            urlString = "\(urlString)/?location_id=\(storeId)"
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)!
    }

}
