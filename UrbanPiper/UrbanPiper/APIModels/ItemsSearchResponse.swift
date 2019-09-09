//
//	ItemsSearchResponse.swift
//
//	Create by Vidhyadharan Mohanram on 12/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemsSearchResponse : NSObject, JSONDecodable{

	public var items : [Item]!
    public var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		items = [Item]()
		if let itemsArray: [[String : AnyObject]] = dictionary["items"] as? [[String : AnyObject]]{
			for dic in itemsArray{
				guard let value: Item = Item(fromDictionary: dic) else { continue }
                value.isSearchItem = true
				items.append(value)
			}
		}
        if let metaData: [String : AnyObject] = dictionary["meta"] as? [String : AnyObject]{
            meta = Meta(fromDictionary: metaData)
        }
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let items = items {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for itemsElement in items {
                dictionaryElements.append(itemsElement.toDictionary())
            }
            dictionary["items"] = dictionaryElements as AnyObject
        }
        if let meta = meta {
            dictionary["meta"] = meta.toDictionary() as AnyObject
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
//        if let items = items {
//            aCoder.encode(items, forKey: "items")
//        }
//        if let meta = meta {
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }

}
