//
//  APIManager+Biz.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    @objc public func fetchBizInfo(completion: ((BizInfo?) -> Void)?,
                                failure: APIFailure?) -> URLSessionDataTask {
        
        let bizId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!

        let urlString: String = "\(APIManager.baseUrl)/api/v1/userbizinfo/?format=json&biz_id=\(bizId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let bizInfo: BizInfo = BizInfo(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        AppUserDataModel.shared.bizInfo = bizInfo
                        AnalyticsManager.shared.track(event: .bizInfoUpdated)
                        completion?(bizInfo)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }

}
