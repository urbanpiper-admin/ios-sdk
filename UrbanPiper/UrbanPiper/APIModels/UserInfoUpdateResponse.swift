//
//  UserInfoUpdateResponse.swift
//  UrbanPiper
//
//  Created by Vid on 08/02/19.
//

import UIKit

public class UserInfoUpdateResponse: NSObject, JSONDecodable {

    public var msg: String?
    public var success: Bool = false

        
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        msg = dictionary["msg"] as? String
        success = dictionary["success"] as? Bool ?? false
    }
    
    @objc public func toDictionary() -> [String : AnyObject] {
        var dictionary: [String : AnyObject] = [String : AnyObject]()

        if msg != nil {
            dictionary["msg"] = msg as AnyObject
        }
        
        dictionary["success"] = success as AnyObject
        
        return dictionary
    }
}
