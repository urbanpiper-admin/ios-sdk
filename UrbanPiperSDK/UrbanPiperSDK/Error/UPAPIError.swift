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
        if error != nil && (error! as NSError).code == NSURLErrorCancelled {
            return nil
        }
        self.init(type: .apiError, data: data, responseObject: responseObject)
    }

}
