//
//  UserInfoUpdateResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 08/02/19.
//

import UIKit

public class UserInfoUpdateResponse: NSObject {

    public private(set) var msg: String?
    public private(set) var success: Bool = false

        
    init(fromDictionary dictionary: [String:Any]) {
        msg = dictionary["msg"] as? String
        success = dictionary["success"] as? Bool ?? false
    }
    
    @objc public func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [String:Any]()

        if msg != nil {
            dictionary["msg"] = msg
        }
        
        dictionary["success"] = success
        
        return dictionary
    }
}
