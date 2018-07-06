//
//	ItemExtra.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemExtra : NSObject, NSCoding{

	public var id : Int!
	public var keyValues : [ItemKeyValue]!
	public var name : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		id = dictionary["id"] as? Int
		keyValues = [ItemKeyValue]()
		if let keyValuesArray: [[String:Any]] = dictionary["key_values"] as? [[String:Any]]{
			for dic in keyValuesArray{
				let value: ItemKeyValue = ItemKeyValue(fromDictionary: dic)
				keyValues.append(value)
			}
		}
		name = dictionary["name"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if keyValues != nil{
            var dictionaryElements = [[String:Any]]()
			for keyValuesElement in keyValues {
				dictionaryElements.append(keyValuesElement.toDictionary())
			}
			dictionary["key_values"] = dictionaryElements
		}
		if name != nil{
			dictionary["name"] = name
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         keyValues = aDecoder.decodeObject(forKey :"key_values") as? [ItemKeyValue]
         name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if keyValues != nil{
			aCoder.encode(keyValues, forKey: "key_values")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}
