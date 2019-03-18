//
//  UPError.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

//  TODO: Should be changed back to internal
public enum ErrorType {
    case apiError
    case responseParseError
}

/// The error class that is returned in case of api call failure via the APIFailure callback
@objc public class UPError: NSError {
    
    internal var errorType: ErrorType
    /// Optional. Returns the data object from the failed api call
    public let data: Data?
    /// Optional. Returns the response object from the failed api call
    public let response: URLResponse?
    internal let error: Error?
    
    /// Optional. Returns a dictionary instance de-serialized from the json data object of the failed api call
    public var responseDictionary: [String: Any]? {
        guard let responseData = data,
            let jsonObject: Any = try? JSONSerialization.jsonObject(with: responseData, options: []),
            let dictionary: [String: Any] = jsonObject as? [String: Any] else { return  nil }
        return dictionary
    }
    
    /// Optional. Returns The HTTP status code of the failed api call
    public var httpStatusCode: Int? {
        guard let httpResponse = response as? HTTPURLResponse else { return nil }
        return httpResponse.statusCode
    }
    
    /// Returns the error message from the server if server error message is non nil else return the localizedDescription from the error object of the failed api call
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
    
    //  TODO: Should be changed back to internal
    public init(type: ErrorType = .apiError, data: Data?, response: URLResponse?, error: Error?) {
        self.errorType = type
        self.data = data
        self.response = response
        self.error = error

        super.init(domain: "com.urbanpiper.error", code: (error as NSError?)?.code ?? 0, userInfo: (error as NSError?)?.userInfo)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        errorType = aDecoder.decodeObject(forKey: "errorType") as? ErrorType ?? .apiError
        data = aDecoder.decodeObject(forKey: "data") as? Data
        response = aDecoder.decodeObject(forKey: "response") as? URLResponse
        error = aDecoder.decodeObject(forKey: "error") as? Error

        super.init(coder: aDecoder)
    }
    
}
