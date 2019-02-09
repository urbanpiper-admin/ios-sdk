//
//	Charge.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class Charge : NSObject{

	public var title : String!
	public var value : Decimal!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		title = dictionary["title"] as? String
        
        if let val: Decimal = dictionary["value"] as? Decimal {
            value = val
        } else if let val: Double = dictionary["value"] as? Double {
            value = Decimal(val).rounded
        } else {
            value = Decimal.zero
        }
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if title != nil{
            dictionary["title"] = title
        }
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         title = aDecoder.decodeObject(forKey: "title") as? String
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
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
//        if value != nil{
//            aCoder.encode(value, forKey: "value")
//        }
//
//    }

}
