//
//  APIManager+FCM.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    @objc internal func registerForFCMToken(token: String,
                                       completion: ((GenericResponse?) -> Void)?,
                                       failure: APIFailure?) -> URLSessionDataTask {
        let urlString: String = "\(APIManager.baseUrl)/api/v1/device/fcm/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["registration_id": token,
                                     "device_id": APIManager.uuidString as Any,
                                     "channel": APIManager.channel]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> GenericResponse? in
            return GenericResponse(fromDictionary: dictionary) ?? GenericResponse.init()
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 201 {
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {

                    DispatchQueue.main.async {
                        completion?(dictionary)
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
