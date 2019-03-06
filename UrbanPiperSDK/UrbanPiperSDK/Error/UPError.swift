//
//  UPError.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

internal enum ErrorType {
    case apiError
    case responseParseError
}

@objc public class UPError: NSError {
    
    internal var errorType: ErrorType
    public let data: Data?
    public let response: URLResponse?
    internal let error: Error?
    
    public var responseDictionary: [String: Any]? {
        guard let responseData = data,
            let jsonObject: Any = try? JSONSerialization.jsonObject(with: responseData, options: []),
            let dictionary: [String: Any] = jsonObject as? [String: Any] else { return  nil }
        return dictionary
    }
    
    public var httpStatusCode: Int? {
        guard let httpResponse = response as? HTTPURLResponse else { return nil }
        return httpResponse.statusCode
    }
    
    public var errorMessage: String {
        switch errorType {
        case .responseParseError:
            return "Unable to parse data"
        default:
            guard let dictionary = responseDictionary else { return localizedDescription }
            let msg = (dictionary["message"] ?? dictionary["error_message"] ?? dictionary["msg"]) as? String
            return msg ?? localizedDescription
        }
    }
    
    internal init(type: ErrorType = .apiError, data: Data?, response: URLResponse?, error: Error?) {
        self.errorType = type
        self.data = data
        self.response = response
        self.error = error

        super.init(domain: "com.urbanpiper.error", code: (error as? NSError)?.code ?? 0, userInfo: (error as? NSError)?.userInfo)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        errorType = aDecoder.decodeObject(forKey: "errorType") as? ErrorType ?? .apiError
        data = aDecoder.decodeObject(forKey: "data") as? Data
        response = aDecoder.decodeObject(forKey: "response") as? URLResponse
        error = aDecoder.decodeObject(forKey: "error") as? Error

        super.init(coder: aDecoder)
    }
    
}
