//
//  APIManager+Biz.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    @objc internal func refreshUserBizInfo(completion: ((BizInfo?) -> Void)?,
                                failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/userbizinfo/?format=json&biz_id=\(bizId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> BizInfo? in
            return BizInfo(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let bizInfo: BizInfo = BizInfo(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(bizInfo)
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
