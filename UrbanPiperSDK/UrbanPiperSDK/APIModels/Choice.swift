//
//	Choice.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Choice : NSObject, NSCoding{

	public var id : Int!
	public var sortOrder : Int!
	public var text : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		id = dictionary["id"] as? Int
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		text = dictionary["text"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary: [String: Any] = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if sortOrder != nil{
			dictionary["sort_order"] = sortOrder
		}
		if text != nil{
			dictionary["text"] = text
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
         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
         text = aDecoder.decodeObject(forKey: "text") as? String

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
		if sortOrder != nil{
			aCoder.encode(sortOrder, forKey: "sort_order")
		}
		if text != nil{
			aCoder.encode(text, forKey: "text")
		}

	}

}
