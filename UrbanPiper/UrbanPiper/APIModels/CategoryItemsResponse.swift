//
//	CategoryItemsResponse.swift
//
//	Create by Vidhyadharan Mohanram on 19/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class CategoryItemsResponse : NSObject, JSONDecodable, NSCopying{

//    public var combos : [AnyObject]!
	public var meta : Meta!
	public var objects : [Item]!

    internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
//        combos = dictionary["combos"] as? [AnyObject]
        if let metaData: [String : AnyObject] = dictionary["meta"] as? [String : AnyObject]{
            meta = Meta(fromDictionary: metaData)
        }
        objects = [Item]()
        if let objectsArray: [[String : AnyObject]] = dictionary["objects"] as? [[String : AnyObject]]{
            for dic in objectsArray{
                guard let value: Item = Item(fromDictionary: dic) else { continue }
                objects.append(value)
            }
        }
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    internal required init?(fromDictionary dictionary: [String : AnyObject], isUpsoldItems: Bool = false, isRecommendedItems: Bool = false){
//        combos = dictionary["combos"] as? [AnyObject]
		if let metaData: [String : AnyObject] = dictionary["meta"] as? [String : AnyObject]{
			meta = Meta(fromDictionary: metaData)
		}
		objects = [Item]()
		if let objectsArray: [[String : AnyObject]] = dictionary["objects"] as? [[String : AnyObject]]{
			for dic in objectsArray{
				guard let value: Item = Item(fromDictionary: dic) else { continue }
                value.isUpsoldItem = isUpsoldItems
                value.isRecommendedItem = isRecommendedItems
				objects.append(value)
			}
		}
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let combos = combos {
//            dictionary["combos"] = combos as AnyObject
//        }
        if let meta = meta {
            dictionary["meta"] = meta.toDictionary() as AnyObject
        }
        if let objects = objects {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for objectsElement in objects {
                dictionaryElements.append(objectsElement.toDictionary())
            }
            dictionary["objects"] = dictionaryElements as AnyObject
        }
        return dictionary
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        return CategoryItemsResponse(fromDictionary: toDictionary()) as Any
    }
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         combos = aDecoder.decodeObject(forKey: "combos") as? [AnyObject]
//         meta = aDecoder.decodeObject(forKey: "meta") as? Meta
//         objects = aDecoder.decodeObject(forKey :"objects") as? [Item]
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let combos = combos {
//            aCoder.encode(combos, forKey: "combos")
//        }
//        if let meta = meta {
//            aCoder.encode(meta, forKey: "meta")
//        }
//        if let objects = objects {
//            aCoder.encode(objects, forKey: "objects")
//        }
//
//    }

}
