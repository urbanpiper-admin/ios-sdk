//
//  UPAPI.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 08/09/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

internal enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

internal protocol UPAPI {
    var path: String { get }
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var method: HttpMethod { get }
    var body: [String: AnyObject]? { get }
}

internal extension UPAPI {
    
    func requestWithBaseURL(baseURL: NSURL) -> URLRequest {
        let URL = baseURL.appendingPathComponent(path)!
                
        guard var components = URLComponents(url: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }
        
        if let parameters = parameters {
            components.queryItems = parameters.map {
                URLQueryItem(name: String($0), value: String($1))
            }
        }
        
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
    
}
