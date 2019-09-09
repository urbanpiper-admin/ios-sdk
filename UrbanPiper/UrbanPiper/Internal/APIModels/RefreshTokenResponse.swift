//
//  RefreshTokenResponse.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 08/09/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

class RefreshTokenResponse: NSObject, JSONDecodable {
    
    public var status : String!
    public var message : String!
    public var token : String!
    
    internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        status = dictionary["status"] as? String
        message = dictionary["message"] as? String
        token = dictionary["token"] as? String
    }
}
