//
//  RedeemRewardResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 12/02/19.
//

import UIKit

public class RedeemRewardResponse: NSObject {
    
    public var expiresIn : Int!
    public var ptsRemaining : Int!
    public var redemptionCode : String!
    public var status : String!
    public var message : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        expiresIn = dictionary["expires_in"] as? Int
        ptsRemaining = dictionary["ptsRemaining"] as? Int
        redemptionCode = dictionary["redemption_code"] as? String
        status = dictionary["status"] as? String
        status = dictionary["status"] as? String
    }
}
