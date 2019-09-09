//
//	Discount.swift
//
//	Create by Vidhyadharan Mohanram on 30/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Discount : NSObject, JSONDecodable{

	public var msg : String!
    public var success : Bool
	public var value : Decimal!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		msg = dictionary["msg"] as? String
		success = dictionary["success"] as? Bool ?? false
        
        let priceVal = dictionary["value"]
        if let val: Decimal = priceVal as? Decimal {
            value = val
        } else if let val: Double = priceVal as? Double {
            value = Decimal(val).rounded
        } else {
            value = Decimal.zero
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let msg = msg {
            dictionary["msg"] = msg as AnyObject
        }

        dictionary["success"] = success as AnyObject
        
        if let value = value {
            dictionary["value"] = value as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         msg = aDecoder.decodeObject(forKey: "msg") as? String
//         success = val as? Bool ?? false
//         value = aDecoder.decodeObject(forKey: "value") as? Decimal
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let msg = msg {
//            aCoder.encode(msg, forKey: "msg")
//        }
//        if let success = success {
//            aCoder.encode(success, forKey: "success")
//        }
//        if let value = value {
//            aCoder.encode(value, forKey: "value")
//        }
//
//    }

}
