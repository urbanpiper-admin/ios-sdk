//
//	CategoriesResponse.swift
//
//	Create by Vidhyadharan Mohanram on 8/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class CategoriesResponse : NSObject{

	private var biz : Biz!
	public private(set)  var clearCache : Bool!
	public private(set)  var meta : Meta!
    public internal(set)  var objects : [Object]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		if let bizData: [String:Any] = dictionary["biz"] as? [String:Any]{
			biz = Biz(fromDictionary: bizData)
		}
        
        Biz.shared = biz

		clearCache = dictionary["clear_cache"] as? Bool
		if let metaData: [String:Any] = dictionary["meta"] as? [String:Any]{
			meta = Meta(fromDictionary: metaData)
		}
		objects = [Object]()
		if let objectsArray: [[String:Any]] = dictionary["objects"] as? [[String:Any]]{
			for dic in objectsArray{
				let value: Object = Object(fromDictionary: dic)
				objects.append(value)
			}
		}
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    @objc public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if biz != nil{
//            dictionary["biz"] = biz.toDictionary()
//        }
//        if clearCache != nil{
//            dictionary["clear_cache"] = clearCache
//        }
//        if meta != nil{
//            dictionary["meta"] = meta.toDictionary()
//        }
//        if objects != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for objectsElement in objects {
//                dictionaryElements.append(objectsElement.toDictionary())
//            }
//            dictionary["objects"] = dictionaryElements
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         biz = aDecoder.decodeObject(forKey: "biz") as? Biz
//         clearCache = aDecoder.decodeObject(forKey: "clear_cache") as? Bool
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
//        if biz != nil{
//            aCoder.encode(biz, forKey: "biz")
//        }
//        if clearCache != nil{
//            aCoder.encode(clearCache, forKey: "clear_cache")
//        }
//        if meta != nil{
//            aCoder.encode(meta, forKey: "meta")
//        }
//        if objects != nil{
//            aCoder.encode(objects, forKey: "objects")
//        }
//
//    }

}
