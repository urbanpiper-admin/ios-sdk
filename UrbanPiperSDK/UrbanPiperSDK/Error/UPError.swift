//
//  UPError.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

public enum ErrorType {
    case unknown
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
    case maxItemOptionsSelected(Int)
    case apiError
    case multiPartEncodingError
    case paymentFailure(String)
}

@objc public class UPError: NSError {

    public var errorType: ErrorType = .unknown
    
    public var errorTitle: String {
        switch errorType {
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
        case .maxItemOptionsSelected(_):
            return ""
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
        case .paymentFailure(_):
            return "Error"
        }
    }
    
    public var errorMessage: String {
        switch errorType {
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
        case .maxItemOptionsSelected(let maxCount):
            return "You can add a maximum of \(maxCount) items in this section"
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
        case .paymentFailure(let errorText):
            return errorText
        }
    }
    
    internal var apiCallData: [String: Any]?
    private var apiStatusCode: Int?
    private var multiPartEncodingError: Error?
    
    public init(type: ErrorType, data: Data? =  nil, responseObject: [String: Any]? = nil) {
        errorType = type
        apiCallData = responseObject
        
        if let dataObject: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: dataObject, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
            apiCallData = dictionary
            print("Server Error Message: \(dictionary)")
        }
        
        if let connection = APIManager.reachability?.connection, connection == .none {
            errorType = .noInternetError
        }
        
        super.init(domain: "com.urbanpiper.error", code: 0, userInfo: apiCallData)
    }
        
    convenience init(multiPartEncodingError error: Error) {
        self.init(type: .multiPartEncodingError)
        multiPartEncodingError = error
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
