//
//	ItemTaxes.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemTaxes : NSObject, JSONDecodable{

	public var rate : Float!
	public var title : String!
	public var value : Decimal!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		rate = dictionary["rate"] as? Float
		title = dictionary["title"] as? String
        
        if let val: Decimal = dictionary["value"] as? Decimal {
            value = val
        } else if let val: Double = dictionary["value"] as? Double {
            value = Decimal(val).rounded
        } else if let val: Float = dictionary["value"] as? Float {
            value = Decimal(Double(val)).rounded
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
        if let rate = rate {
            dictionary["rate"] = rate as AnyObject
        }
        if let title = title {
            dictionary["title"] = title as AnyObject
        }
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
//         rate = aDecoder.decodeObject(forKey: "rate") as? Float
//         title = aDecoder.decodeObject(forKey: "title") as? String
//         value = aDecoder.decodeObject(forKey: "value") as? Float
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let rate = rate {
//            aCoder.encode(rate, forKey: "rate")
//        }
//        if let title = title {
//            aCoder.encode(title, forKey: "title")
//        }
//        if let value = value {
//            aCoder.encode(value, forKey: "value")
//        }
//
//    }

}
