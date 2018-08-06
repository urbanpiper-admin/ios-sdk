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
                                     completion: APICompletion<[String : Any]>?,
                                     failure: APIFailure?) -> URLSessionDataTask? {
        
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
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                guard let completionClosure = completion else { return }
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
                    DispatchQueue.main.async {
                        completionClosure(dictionary)
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
