//
//	Discount.swift
//
//	Create by Vidhyadharan Mohanram on 30/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Discount : NSObject, NSCoding{

	public var msg : String!
	public var success : Bool!
	public var value : Decimal!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		msg = dictionary["msg"] as? String
		success = dictionary["success"] as? Bool
        
        let priceVal = dictionary["value"]
        if let val = priceVal as? Decimal {
            print("decimal amount value \(val)")
            value = val
        } else if let val = priceVal as? Double {
            print("double amount value \(val)")
            value = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: value).doubleValue))")
        } else if let val = priceVal as? Float {
            value = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = priceVal as? Int {
            print("int amount value \(val)")
            value = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: value).doubleValue))")
        } else {
            value = Decimal(0).rounded
            print("amount value nil")
        }
    }

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if msg != nil{
			dictionary["msg"] = msg
		}
		if success != nil{
			dictionary["success"] = success
		}
		if value != nil{
			dictionary["value"] = value
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         msg = aDecoder.decodeObject(forKey: "msg") as? String
         success = aDecoder.decodeObject(forKey: "success") as? Bool
         value = aDecoder.decodeObject(forKey: "value") as? Decimal

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if msg != nil{
			aCoder.encode(msg, forKey: "msg")
		}
		if success != nil{
			aCoder.encode(success, forKey: "success")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}
