//
//	Coupon.swift
//
//	Create by Vidhyadharan Mohanram on 10/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Coupon : NSObject{

	public var descriptionField : String!
	public var redemptionCode : String!
	public var title : String!
	public var validUntil : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		descriptionField = dictionary["description"] as? String
		redemptionCode = dictionary["redemption_code"] as? String
		title = dictionary["title"] as? String
		validUntil = dictionary["valid_until"] as? Int
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if descriptionField != nil{
//            dictionary["description"] = descriptionField
//        }
//        if redemptionCode != nil{
//            dictionary["redemption_code"] = redemptionCode
//        }
//        if title != nil{
//            dictionary["title"] = title
//        }
//        if validUntil != nil{
//            dictionary["valid_until"] = validUntil
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
//         redemptionCode = aDecoder.decodeObject(forKey: "redemption_code") as? String
//         title = aDecoder.decodeObject(forKey: "title") as? String
//         validUntil = aDecoder.decodeObject(forKey: "valid_until") as? Int
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if descriptionField != nil{
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if redemptionCode != nil{
//            aCoder.encode(redemptionCode, forKey: "redemption_code")
//        }
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
//        if validUntil != nil{
//            aCoder.encode(validUntil, forKey: "valid_until")
//        }
//
//    }

}
