//
//  UserInfoUpdateResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 08/02/19.
//

import UIKit

public class UserInfoUpdateResponse: NSObject {

    public var msg: String?
    public var success: Bool = false

        
    init(fromDictionary dictionary: [String:Any]) {
        msg = dictionary["msg"] as? String
        success = dictionary["success"] as? Bool ?? false
    }
}
