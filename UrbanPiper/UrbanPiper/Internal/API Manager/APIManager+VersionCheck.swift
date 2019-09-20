//
//  APIManager+VersionCheck.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 10/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum VersionCheckAPI {
    case checkVersion(username: String?, version: String)
}

extension VersionCheckAPI: UPAPI {
    var path: String {
        switch self {
        case .checkVersion:
            return "api/v1/app/ios/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .checkVersion(username, version):
            var params = ["biz_id": APIManager.shared.bizId,
                          "ver": version]

            if let username = username {
                params["user"] = username
            }

            return params
        }
    }

    var headers: [String: String]? {
        switch self {
        case .checkVersion:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .checkVersion:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .checkVersion:
            return nil
        }
    }
}

/* extension APIManager {

 @objc internal func checkAppVersion(username: String?,
                                   version: String,
                                   completion: APICompletion<VersionCheckResponse>?,
                                   failure: APIFailure?) -> URLSessionDataTask {
     var urlString: String = "\(APIManager.baseUrl)/api/v1/app/ios/?biz_id=\(bizId)&ver=\(version)"

     if let usernameVal = username {
         urlString = "\(urlString)&user=\(usernameVal)"
     }

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 }*/
