//
//  APIManager+Feedback.swift
//  UrbanPiperSDK
//
//  Created by Vid on 31/07/18.
//

import UIKit

extension APIManager {
    
    @objc public func submitFeedback(name: String,
                                     bizId: String,
                                     rating: Double,
                                     orderId: String,
                                     choiceText: String?,
                                     comments: String?,
                                     completion: ((GenericResponse?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/feedback/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        var params: [String: Any] =  ["name": name,
                                      "biz_id": bizId,
                                      "rating": Int(rating),
                                      "type": "ordering",
                                      "type_id": orderId]
        
        if let text = choiceText, text.count > 0 {
            params["choice_text"] = text
        }
        
        if let text = comments, text.count > 0 {
            params["comments"] = text
        }
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> GenericResponse? in
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
