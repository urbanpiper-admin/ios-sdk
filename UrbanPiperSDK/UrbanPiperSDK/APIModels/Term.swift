//
//	Term.swift
//
//	Create by Vidhyadharan Mohanram on 10/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Term : NSObject, NSCoding{

	public var offset : Int!
	public var value : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		offset = dictionary["offset"] as? Int
		value = dictionary["value"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if offset != nil{
//            dictionary["offset"] = offset
//        }
//        if value != nil{
//            dictionary["value"] = value
//        }
//        return dictionary
//    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         offset = aDecoder.decodeObject(forKey: "offset") as? Int
         value = aDecoder.decodeObject(forKey: "value") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if offset != nil{
			aCoder.encode(offset, forKey: "offset")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}
