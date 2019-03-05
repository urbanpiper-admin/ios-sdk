//
//  UPError.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

//public enum HTTPStatusCode: Int {
//    case unknown = 0
//    // 100 Informational
//    case `continue` = 100
//    case switchingProtocols
//    case processing
//    // 200 Success
//    case ok = 200
//    case created
//    case accepted
//    case nonAuthoritativeInformation
//    case noContent
//    case resetContent
//    case partialContent
//    case multiStatus
//    case alreadyReported
//    case iMUsed = 226
//    // 300 Redirection
//    case multipleChoices = 300
//    case movedPermanently
//    case found
//    case seeOther
//    case notModified
//    case useProxy
//    case switchProxy
//    case temporaryRedirect
//    case permanentRedirect
//    // 400 Client Error
//    case badRequest = 400
//    case unauthorized
//    case paymentRequired
//    case forbidden
//    case notFound
//    case methodNotAllowed
//    case notAcceptable
//    case proxyAuthenticationRequired
//    case requestTimeout
//    case conflict
//    case gone
//    case lengthRequired
//    case preconditionFailed
//    case payloadTooLarge
//    case uriTooLong
//    case unsupportedMediaType
//    case rangeNotSatisfiable
//    case expectationFailed
//    case imATeapot
//    case misdirectedRequest = 421
//    case unprocessableEntity
//    case locked
//    case failedDependency
//    case upgradeRequired = 426
//    case preconditionRequired = 428
//    case tooManyRequests
//    case requestHeaderFieldsTooLarge = 431
//    case unavailableForLegalReasons = 451
//    // 500 Server Error
//    case internalServerError = 500
//    case notImplemented
//    case badGateway
//    case serviceUnavailable
//    case gatewayTimeout
//    case httpVersionNotSupported
//    case variantAlsoNegotiates
//    case insufficientStorage
//    case loopDetected
//    case notExtended = 510
//    case networkAuthenticationRequired
//}

public enum ErrorType {
    case unknown
    case googleLoginFailed
    case facebookLoginFailed
    case maxOrderableQuantityAdded(Int)
    case invalidString
    case invalidUsername
    case invalidDisplayName
    case invalidSurname
    case invalidGivenName
    case invalidCountryCode
    case invalidPhoneNumber
    case invalidEmail
    case invalidPassword(Int)
    case invalidPincode
    case invalidOtpCode(Int)
    case noInternetError
    case apiError
    case responseParseError
    case multiPartEncodingError
    case paymentFailure(String)
//    case invalidGroupId
//    case invalidOption
}

@objc public class UPError: NSError {

    public var errorType: ErrorType = .unknown
    
    public var errorTitle: String {
        switch errorType {
        case .facebookLoginFailed:
            return "Error"
        case .googleLoginFailed:
            return "Error"
        case .invalidString:
            return "Error"
        case .invalidUsername:
            return "Error"
        case .invalidDisplayName:
            return "Error"
        case .invalidSurname:
            return "Error"
        case .invalidGivenName:
            return "Error"
        case .invalidCountryCode:
            return "Error"
        case .invalidPhoneNumber:
            return "Error"
        case .invalidPincode:
            return "Error"
        case .invalidOtpCode:
            return "Error"
        case .invalidEmail:
            return "Error"
        case .invalidPassword(_):
            return "Error"
        case .noInternetError:
            return "No internet connection"
        case .multiPartEncodingError:
            return multiPartEncodingError!.localizedDescription
        case .unknown:
            return ""
        case .maxOrderableQuantityAdded(_):
            return "Error"
        case .apiError:
            return "Error"
        case .responseParseError:
            return "Error"
        case .paymentFailure(_):
            return "Error"
//        case .invalidGroupId:
//            return "Error"
//        case .invalidOption:
//            return "Error"
        }
    }
    
    public var errorMessage: String {
        switch errorType {
        case .facebookLoginFailed:
            return "Facebook login failed"
        case .googleLoginFailed:
            return "Google login failed"
        case .invalidString:
            return "Invalid text"
        case .invalidUsername:
            return "Invalid username"
        case .invalidDisplayName:
            return "Invalid displayName"
        case .invalidSurname:
            return "Invalid surname"
        case .invalidGivenName:
            return "Invalid given name"
        case .invalidCountryCode:
            return "Invalid country code"
        case .invalidPhoneNumber:
            return "Invalid phone number"
        case .invalidPincode:
            return "Invalid pin code"
        case .invalidOtpCode:
            return "Invalid otp code"
        case .invalidEmail:
            return "Invalid email"
        case .invalidPassword(let minChar):
            return "Enter a minimum of \(minChar) characters"
        case .noInternetError:
            return "Check your internet connection"
        case .multiPartEncodingError:
            return multiPartEncodingError!.localizedDescription
        case .unknown:
            return ""
        case .maxOrderableQuantityAdded(let currentStock):
            return "Sorry, current stock at the store is limited to: \(currentStock)"
        case .apiError:
            if let msg: String = apiCallData?["message"] as? String {
                return msg
            }
            
            if let msg: String = apiCallData?["error_message"] as? String {
                return msg
            }
            
            if let msg: String = apiCallData?["msg"] as? String {
                return msg
            }
            
            return "Unable to process your request"
        case .responseParseError:
            return "Unable to parse data"
        case .paymentFailure(let errorText):
            return errorText
//        case .invalidGroupId:
//            return "Provided group id is not associated with the current itembuilder groups"
//        case .invalidOption:
//            return "Provided option id is not associated with the current itembuilder group options"
        }
    }
    
    internal var apiCallData: [String: Any]?
    private var multiPartEncodingError: Error?
    
    public init(type: ErrorType, errorCode: Int = 0, data: Data? =  nil, responseObject: [String: Any]? = nil) {
        errorType = type
        apiCallData = responseObject
        
        if let dataObject: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: dataObject, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
            apiCallData = dictionary
            print("Server Error Message: \(dictionary)")
        }
        
        if let connection = APIManager.reachability?.connection, connection == .none {
            errorType = .noInternetError
        }
        
        super.init(domain: "com.urbanpiper.error", code: errorCode, userInfo: apiCallData)
    }
        
    convenience init(multiPartEncodingError error: Error) {
        self.init(type: .multiPartEncodingError)
        multiPartEncodingError = error
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
