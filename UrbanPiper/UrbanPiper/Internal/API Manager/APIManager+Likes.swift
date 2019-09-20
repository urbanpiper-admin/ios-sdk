//
//  APIManager+Items.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum ItemLikesAPI {
    case userLikes
    case likeItem(itemId: Int)
    case unlikeItem(itemId: Int)
}

extension ItemLikesAPI: UPAPI {
    var path: String {
        switch self {
        case .userLikes:
            return "api/v1/user/item/likes/"
        case let .likeItem(itemId):
            return "api/v1/user/item/\(itemId)/like/"
        case let .unlikeItem(itemId):
            return "api/v1/user/item/\(itemId)/like/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .userLikes:
            return nil
        case .likeItem:
            return nil
        case .unlikeItem:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .userLikes:
            return nil
        case .likeItem:
            return nil
        case .unlikeItem:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .userLikes:
            return .GET
        case .likeItem:
            return .POST
        case .unlikeItem:
            return .DELETE
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .userLikes:
            return nil
        case .likeItem:
            return nil
        case .unlikeItem:
            return nil
        }
    }
}

/* extension APIManager {

 @objc func userLikes(offset: Int = 0,
                      limit: Int = Constants.fetchLimit,
                      completion: APICompletion<UserLikesResponse>?,
                      failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/item/likes/"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func likeItem(itemId: Int,
                           completion: APICompletion<GenericResponse>?,
                           failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/item/\(itemId)/like/"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)
     urlRequest.httpMethod = "POST"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func unlikeItem(itemId: Int,
                              completion: APICompletion<GenericResponse>?,
                             failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/item/\(itemId)/like/"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)
     urlRequest.httpMethod = "DELETE"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 }*/
