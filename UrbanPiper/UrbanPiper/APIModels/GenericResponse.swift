//
//  GenericResponse.swift
//  UrbanPiper
//
//  Created by Vid on 06/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objc public class GenericResponse: NSObject, JSONDecodable {
    
    @objc public var status: String? = "success"
    public var message: String?
    public var errorMessage: String?
    internal var msg: String?
    
    
    internal override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        
        if let status = dictionary["status"] as? String {
            self.status = status
        }
        message = dictionary["message"] as? String
        errorMessage = dictionary["error_message"] as? String
        msg = dictionary["msg"] as? String
    }

    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let status = status {
            dictionary["status"] = status as AnyObject
        }
        if let message = message {
            dictionary["message"] = message as AnyObject
        }
        if let errorMessage = errorMessage {
            dictionary["error_message"] = errorMessage as AnyObject
        }
        if let msg = msg {
            dictionary["msg"] = msg as AnyObject
        }
        return dictionary
    }
    
}
