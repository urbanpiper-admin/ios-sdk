//
//  APIManager+Items.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {

    @objc public func userLikes(completion: APICompletion<UserLikesResponse>?,
                         failure: APIFailure?) -> URLSessionTask {

        let urlString = "\(APIManager.baseUrl)/api/v1/user/item/likes/"

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let likesResponse = UserLikesResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(likesResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completionClosure(nil)
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

    @objc public func likeUnlikeItem(itemId: Int,
                              like: Bool,
                              completion: APICompletion<[String: Any]>?,
                              failure: APIFailure?) -> URLSessionTask {

        let urlString = "\(APIManager.baseUrl)/api/v1/user/item/\(itemId)/like/"

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url)

        if like {
            urlRequest.httpMethod = "POST"
        } else {
            urlRequest.httpMethod = "DELETE"
        }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    
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

