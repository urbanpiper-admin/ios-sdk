//
//  APIManager+Biz.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {
    
    @objc public func fetchBizInfo(completion: APICompletion<BizInfo>?,
                                failure: APIFailure?) -> URLSessionTask {
        
        let bizAppId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString: String = "\(APIManager.baseUrl)/api/v1/userbizinfo/?format=json&biz_id=\(bizAppId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let bizInfo: BizInfo = BizInfo(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        AppUserDataModel.shared.bizInfo = bizInfo
                        AnalyticsManager.shared.setMixpanelPeople()
                        completion?(bizInfo)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
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
