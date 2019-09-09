//
//	CategoriesResponse.swift
//
//	Create by Vidhyadharan Mohanram on 8/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class CategoriesResponse : NSObject, JSONDecodable{

	private var biz : Biz!
    public var clearCache : Bool
	public var meta : Meta!
    public var objects : [Object]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		if let bizData: [String : AnyObject] = dictionary["biz"] as? [String : AnyObject]{
			biz = Biz(fromDictionary: bizData)
		}
        
        Biz.shared = biz

		clearCache = dictionary["clear_cache"] as? Bool ?? false
		if let metaData: [String : AnyObject] = dictionary["meta"] as? [String : AnyObject]{
			meta = Meta(fromDictionary: metaData)
		}
		objects = [Object]()
		if let objectsArray: [[String : AnyObject]] = dictionary["objects"] as? [[String : AnyObject]]{
			for dic in objectsArray{
				guard let value: Object = Object(fromDictionary: dic) else { continue }
				objects.append(value)
			}
		}
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let biz = biz {
            dictionary["biz"] = biz.toDictionary() as AnyObject
        }
//        if let clearCache = clearCache {
            dictionary["clear_cache"] = clearCache as AnyObject
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

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         biz = aDecoder.decodeObject(forKey: "biz") as? Biz
//         clearCache = val as? Bool ?? false
//         meta = aDecoder.decodeObject(forKey: "meta") as? Meta
//         objects = aDecoder.decodeObject(forKey :"objects") as? [Object]
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let biz = biz {
//            aCoder.encode(biz, forKey: "biz")
//        }
//        if let clearCache = clearCache {
//            aCoder.encode(clearCache, forKey: "clear_cache")
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
