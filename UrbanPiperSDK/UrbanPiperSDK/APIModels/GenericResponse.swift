//
//  GenericResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 06/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objc public class GenericResponse: NSObject {
    
    @objc public var status: String? = "success"
    public var message: String?
    public var errorMessage: String?
    
    
    internal override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init?(fromDictionary dictionary: [String: Any]?) {
        guard dictionary != nil else { return nil }
        
        status = dictionary?["status"] as? String
        message = dictionary?["message"] as? String
        errorMessage = dictionary?["error_message"] as? String
    }

}
