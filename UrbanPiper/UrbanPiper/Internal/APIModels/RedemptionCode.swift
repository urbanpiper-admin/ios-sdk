//
//  RedemptionCode.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 14, 2019

import Foundation


public class RedemptionCode : NSObject, JSONDecodable, NSCoding{

    public var expiresIn : Int!
    public var redemptionCode : String!
    public var validFrom : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        expiresIn = dictionary["expires_in"] as? Int
        redemptionCode = dictionary["redemption_code"] as? String
        validFrom = dictionary["valid_from"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary = [String : AnyObject]()
        if let expiresIn = expiresIn {
            dictionary["expires_in"] = expiresIn as AnyObject
        }
        if let redemptionCode = redemptionCode {
            dictionary["redemption_code"] = redemptionCode as AnyObject
        }
        if let validFrom = validFrom {
            dictionary["valid_from"] = validFrom as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        expiresIn = aDecoder.decodeInteger(forKey: "expires_in")
        redemptionCode = aDecoder.decodeObject(forKey: "redemption_code") as? String
        validFrom = aDecoder.decodeInteger(forKey: "valid_from")
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        if let expiresIn = expiresIn {
            aCoder.encode(expiresIn, forKey: "expires_in")
        }
        if let redemptionCode = redemptionCode {
            aCoder.encode(redemptionCode, forKey: "redemption_code")
        }
        if let validFrom = validFrom {
            aCoder.encode(validFrom, forKey: "valid_from")
        }
    }
}
