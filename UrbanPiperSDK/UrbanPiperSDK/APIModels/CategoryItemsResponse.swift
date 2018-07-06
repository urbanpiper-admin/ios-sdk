//
//	CategoryItemsResponse.swift
//
//	Create by Vidhyadharan Mohanram on 19/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class CategoryItemsResponse : NSObject, NSCoding{

	public var combos : [AnyObject]!
	public var meta : ItemMeta!
	public var objects : [ItemObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		combos = dictionary["combos"] as? [AnyObject]
		if let metaData: [String:Any] = dictionary["meta"] as? [String:Any]{
			meta = ItemMeta(fromDictionary: metaData)
		}
		objects = [ItemObject]()
		if let objectsArray: [[String:Any]] = dictionary["objects"] as? [[String:Any]]{
			for dic in objectsArray{
				let value: ItemObject = ItemObject(fromDictionary: dic)
				objects.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if combos != nil{
			dictionary["combos"] = combos
		}
		if meta != nil{
			dictionary["meta"] = meta.toDictionary()
		}
		if objects != nil{
            var dictionaryElements = [[String:Any]]()
			for objectsElement in objects {
				dictionaryElements.append(objectsElement.toDictionary())
			}
			dictionary["objects"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         combos = aDecoder.decodeObject(forKey: "combos") as? [AnyObject]
         meta = aDecoder.decodeObject(forKey: "meta") as? ItemMeta
         objects = aDecoder.decodeObject(forKey :"objects") as? [ItemObject]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if combos != nil{
			aCoder.encode(combos, forKey: "combos")
		}
		if meta != nil{
			aCoder.encode(meta, forKey: "meta")
		}
		if objects != nil{
			aCoder.encode(objects, forKey: "objects")
		}

	}

}
