//
//  UPAPIError.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public class UPAPIError: UPError {

    public convenience init?(errorCode: Int = 0, data: Data? = nil, responseObject: [String: Any]? = nil) {        
        self.init(type: .apiError, errorCode: errorCode, data: data, responseObject: responseObject)
    }

}
