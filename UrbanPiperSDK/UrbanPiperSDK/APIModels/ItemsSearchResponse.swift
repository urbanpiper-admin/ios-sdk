//
//	ItemsSearchResponse.swift
//
//	Create by Vidhyadharan Mohanram on 12/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemsSearchResponse : NSObject{

	public private(set)  var items : [Item]!
    public private(set)  var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		items = [Item]()
		if let itemsArray: [[String:Any]] = dictionary["items"] as? [[String:Any]]{
			for dic in itemsArray{
				let value: Item = Item(fromDictionary: dic)
                value.isSearchItem = true
				items.append(value)
			}
		}
        if let metaData: [String:Any] = dictionary["meta"] as? [String:Any]{
            meta = Meta(fromDictionary: metaData)
        }
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if items != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for itemsElement in items {
                dictionaryElements.append(itemsElement.toDictionary())
            }
            dictionary["items"] = dictionaryElements
        }
        if meta != nil{
            dictionary["meta"] = meta.toDictionary()
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         items = aDecoder.decodeObject(forKey :"items") as? [Item]
//         meta = aDecoder.decodeObject(forKey: "meta") as? Meta
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if items != nil{
//            aCoder.encode(items, forKey: "items")
//        }
//        if meta != nil{
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }

}
