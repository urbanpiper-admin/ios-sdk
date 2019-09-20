//
//  RedeemRewardResponse.swift
//  UrbanPiper
//
//  Created by Vid on 12/02/19.
//

import UIKit

public class RedeemRewardResponse: NSObject, JSONDecodable {
    public var expiresIn: Int?
    public var ptsRemaining: Int?
    public var redemptionCode: String!
    public var status: String!
    public var message: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        expiresIn = dictionary["expires_in"] as? Int
        ptsRemaining = dictionary["ptsRemaining"] as? Int
        redemptionCode = dictionary["redemption_code"] as? String
        status = dictionary["status"] as? String
        message = dictionary["message"] as? String
    }

    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()

        if let expiresIn = expiresIn {
            dictionary["expires_in"] = expiresIn as AnyObject
        }

        if let ptsRemaining = ptsRemaining {
            dictionary["ptsRemaining"] = ptsRemaining as AnyObject
        }

        if let redemptionCode = redemptionCode {
            dictionary["redemption_code"] = redemptionCode as AnyObject
        }

        if let status = status {
            dictionary["status"] = status as AnyObject
        }

        if let message = message {
            dictionary["message"] = message as AnyObject
        }

        return dictionary
    }
}
