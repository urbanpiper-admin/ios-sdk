//
//  APIManager+Banners.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 10/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum BannersAPI {
    case banners
}

extension BannersAPI: UPAPI {
    var path: String {
        switch self {
        case .banners:
            return "api/v1/galleries/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .banners:
            return ["type":"app_banner"]
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .banners:
            return ["Authorization" : APIManager.shared.bizAuth()]
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .banners:
            return .GET
        }
    }
    
    var body: [String : AnyObject]? {
        switch self {
        case .banners:
            return nil
        }
    }
    
}

extension APIManager {

    @objc internal func getBanners(completion: ((BannersResponse?) -> Void)?,
                                failure: APIFailure?) -> URLSessionDataTask {

        let urlString: String = "\(APIManager.baseUrl)/api/v1/galleries/?type=app_banner"

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        
        return apiRequest(urlRequest: &urlRequest,
                          headers: ["Authorization" : bizAuth()],
                          completion: completion,
                          failure: failure)
    }

}
