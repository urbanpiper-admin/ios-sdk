//
//  APIManager+VersionCheck.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 10/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {

    @objc public func checkForUpgrade(username: String?,
                                      version: String,
                                      completion: ((VersionCheckResponse?) -> Void)?,
                                      failure: APIFailure?) -> URLSessionDataTask {
        var urlString: String = "\(APIManager.baseUrl)/api/v1/app/ios/?biz_id=\(bizId)&ver=\(version)"
        
        if let usernameVal = username {
            urlString = "\(urlString)&user=\(usernameVal)"
        }

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> VersionCheckResponse? in
            return VersionCheckResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let versionCheckResponse: VersionCheckResponse = VersionCheckResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completion?(versionCheckResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }

        }
        
        return dataTask*/
    }

}
