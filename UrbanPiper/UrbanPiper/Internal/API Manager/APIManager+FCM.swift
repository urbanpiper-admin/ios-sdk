//
//  APIManager+FCM.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum FCMAPI {
    case registerForFCM(token: String)
}

extension FCMAPI: UPAPI {
    var path: String {
        switch self {
        case .registerForFCM:
            return "api/v1/device/fcm/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .registerForFCM:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .registerForFCM:
            return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .registerForFCM:
            return .POST
        }
    }
    
    var body: [String : AnyObject]? {
        switch self {
        case .registerForFCM(let token):
            return ["registration_id": token,
                    "device_id": APIManager.uuidString,
                    "channel": APIManager.channel] as [String : AnyObject]
        }
    }
    
}

/* extension APIManager {
    
    @objc internal func registerForFCMToken(token: String,
                                       completion: APICompletion<GenericResponse>?,
                                       failure: APIFailure?) -> URLSessionDataTask {
        let urlString: String = "\(APIManager.baseUrl)/api/v1/device/fcm/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["registration_id": token,
                                     "device_id": APIManager.uuidString as Any,
                                     "channel": APIManager.channel]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
    }
}*/
