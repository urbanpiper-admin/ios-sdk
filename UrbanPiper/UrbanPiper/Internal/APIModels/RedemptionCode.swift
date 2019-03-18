//
//  RedemptionCode.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 14, 2019

import Foundation


public class RedemptionCode : NSObject, NSCoding{

    public var expiresIn : Int!
    public var redemptionCode : String!
    public var validFrom : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        expiresIn = dictionary["expires_in"] as? Int
        redemptionCode = dictionary["redemption_code"] as? String
        validFrom = dictionary["valid_from"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if expiresIn != nil{
            dictionary["expires_in"] = expiresIn
        }
        if redemptionCode != nil{
            dictionary["redemption_code"] = redemptionCode
        }
        if validFrom != nil{
            dictionary["valid_from"] = validFrom
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        expiresIn = aDecoder.decodeObject(forKey: "expires_in") as? Int
        redemptionCode = aDecoder.decodeObject(forKey: "redemption_code") as? String
        validFrom = aDecoder.decodeObject(forKey: "valid_from") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        if expiresIn != nil{
            aCoder.encode(expiresIn, forKey: "expires_in")
        }
        if redemptionCode != nil{
            aCoder.encode(redemptionCode, forKey: "redemption_code")
        }
        if validFrom != nil{
            aCoder.encode(validFrom, forKey: "valid_from")
        }
    }
}
