//
//  GenericResponse.swift
//  UrbanPiper
//
//  Created by Vid on 06/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objc public class GenericResponse: NSObject {
    
    @objc public var status: String? = "success"
    public var message: String?
    public var errorMessage: String?
    internal var msg: String?
    
    
    internal override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init?(fromDictionary dictionary: [String: Any]?) {
        guard dictionary != nil else { return nil }
        
        if let status = dictionary?["status"] as? String {
            self.status = status
        }
        message = dictionary?["message"] as? String
        errorMessage = dictionary?["error_message"] as? String
        msg = dictionary?["msg"] as? String
    }

    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if status != nil{
            dictionary["status"] = status
        }
        if message != nil{
            dictionary["message"] = message
        }
        if errorMessage != nil{
            dictionary["error_message"] = errorMessage
        }
        if msg != nil{
            dictionary["msg"] = msg
        }
        return dictionary
    }
    
}
