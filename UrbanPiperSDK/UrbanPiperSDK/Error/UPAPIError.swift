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
        let errorCode = (error! as NSError).code
        if error != nil && errorCode == NSURLErrorCancelled {
            return nil
        }
        
        self.init(type: .apiError, errorCode: errorCode, data: data, responseObject: responseObject)        
    }

}
