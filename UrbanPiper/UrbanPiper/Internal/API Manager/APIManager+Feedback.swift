//
//  APIManager+Feedback.swift
//  UrbanPiper
//
//  Created by Vid on 31/07/18.
//

import UIKit

enum FeedbackAPI {
    case submitFeedback(name: String, rating: Double, orderId: Int, choiceText: String?, comments: String?)
}

extension FeedbackAPI: UPAPI {
    var path: String {
        switch self {
        case .submitFeedback:
            return "api/v2/feedback/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .submitFeedback:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .submitFeedback:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .submitFeedback:
            return .POST
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case let .submitFeedback(name, rating, orderId, choiceText, comments):
            var params = ["name": name,
                          "biz_id": APIManager.shared.bizId,
                          "rating": Int(rating),
                          "type": "ordering",
                          "type_id": orderId] as [String: AnyObject]

            if let text = choiceText, text.count > 0 {
                params["choice_text"] = text as AnyObject
            }

            if let text = comments, text.count > 0 {
                params["comments"] = text as AnyObject
            }
            return params
        }
    }
}

/* extension APIManager {

 @objc internal func submitFeedback(name: String,
                                  rating: Double,
                                  orderId: Int,
                                  choiceText: String?,
                                  comments: String?,
                                  completion: APICompletion<GenericResponse>?,
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

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 }*/
