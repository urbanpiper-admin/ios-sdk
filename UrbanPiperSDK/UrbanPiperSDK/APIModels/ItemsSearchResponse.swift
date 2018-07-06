//
//	ItemsSearchResponse.swift
//
//	Create by Vidhyadharan Mohanram on 12/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemsSearchResponse : NSObject, NSCoding{

	public var items : [ItemObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		items = [ItemObject]()
		if let itemsArray: [[String:Any]] = dictionary["items"] as? [[String:Any]]{
			for dic in itemsArray{
				let value: ItemObject = ItemObject(fromDictionary: dic)
				items.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if items != nil{
            var dictionaryElements = [[String:Any]]()
			for itemsElement in items {
				dictionaryElements.append(itemsElement.toDictionary())
			}
			dictionary["items"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         items = aDecoder.decodeObject(forKey :"items") as? [ItemObject]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if items != nil{
			aCoder.encode(items, forKey: "items")
		}

	}

}
