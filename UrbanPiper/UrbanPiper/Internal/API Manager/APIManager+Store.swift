//
//  APIManager+StoreLocator.swift
//  UrbanPiper
//
//  Created by Vid on 04/07/18.
//

import CoreLocation
import Foundation

enum StoreAPI {
    case stores
    case nearestStore(coordinates: CLLocationCoordinate2D)
}

extension StoreAPI: UPAPI {
    var path: String {
        switch self {
        case .stores:
            return "api/v1/stores/"
        case .nearestStore:
            return "api/v1/stores/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .stores:
            return ["format": "json",
                    "biz_id": APIManager.shared.bizId,
                    "all": "1"]
        case let .nearestStore(coordinates):
            return ["format": "json",
                    "biz_id": APIManager.shared.bizId,
                    "lat": String(coordinates.latitude),
                    "lng": String(coordinates.longitude)]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .stores:
            return nil
        case .nearestStore:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .stores:
            return .GET
        case .nearestStore:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .stores:
            return nil
        case .nearestStore:
            return nil
        }
    }
}

/* extension APIManager {

 @objc internal func getAllStores(completion: APICompletion<StoreListResponse>?,
                                  failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(bizId)&all=1"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func getNearestStore(_ coordinates: CLLocationCoordinate2D,
                                     completion: APICompletion<StoreResponse>?,
                                     failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(bizId)&lat=\(coordinates.latitude)&lng=\(coordinates.longitude)"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }
 }*/
