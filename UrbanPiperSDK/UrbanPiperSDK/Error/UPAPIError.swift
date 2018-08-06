//
//  UPAPIError.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public class UPAPIError: UPError {

    public convenience init?(error: Error? = nil, data: Data? = nil, responseObject: [String: Any]? = nil) {
        var errorCode = 0
        
        if let nsError = error as? NSError {
            errorCode = nsError.code
            guard nsError.code != NSURLErrorCancelled else { return nil }
        }
        
        self.init(type: .apiError, errorCode: errorCode, data: data, responseObject: responseObject)
    }

}
