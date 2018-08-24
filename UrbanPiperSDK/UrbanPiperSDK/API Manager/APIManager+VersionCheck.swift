//
//  APIManager+VersionCheck.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 10/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {

    @objc public func checkForUpgrade(completion: APICompletion<VersionCheckResponse>?,
                                 failure: APIFailure?) -> URLSessionDataTask? {

        let username: String = AppUserDataModel.shared.validAppUserData?.phoneNumberWithCountryCode ?? "null"
        
        let infoDictionary: [String: Any] = Bundle.main.infoDictionary!
        guard let appVersion: String = infoDictionary["CFBundleShortVersionString"] as? String,
            let bizId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId else { return nil }
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/app/ios/?user=\(username)&biz_id=\(bizId)&ver=\(appVersion)"

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in

            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let versionCheckResponse: VersionCheckResponse = VersionCheckResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(versionCheckResponse)
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
