//
//	AddressComponent.swift
//
//	Create by Vidhyadharan Mohanram on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class AddressComponent : NSObject, NSCoding{

	public var longName : String!
	public var shortName : String!
	public var types : [String]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		longName = dictionary["long_name"] as? String
		shortName = dictionary["short_name"] as? String
		types = dictionary["types"] as? [String]
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if longName != nil{
			dictionary["long_name"] = longName
		}
		if shortName != nil{
			dictionary["short_name"] = shortName
		}
		if types != nil{
			dictionary["types"] = types
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         longName = aDecoder.decodeObject(forKey: "long_name") as? String
         shortName = aDecoder.decodeObject(forKey: "short_name") as? String
         types = aDecoder.decodeObject(forKey: "types") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if longName != nil{
			aCoder.encode(longName, forKey: "long_name")
		}
		if shortName != nil{
			aCoder.encode(shortName, forKey: "short_name")
		}
		if types != nil{
			aCoder.encode(types, forKey: "types")
		}

	}

}
