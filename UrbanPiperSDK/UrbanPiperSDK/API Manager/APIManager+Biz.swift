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
        
        let bizAppId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString = "\(APIManager.baseUrl)/api/v1/userbizinfo/?format=json&biz_id=\(bizAppId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let bizInfo = BizInfo(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        AppUserDataModel.shared.bizInfo = bizInfo
//                        AnalyticsManager.shared.setMixpanelPeople()
                        completion?(bizInfo)
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
