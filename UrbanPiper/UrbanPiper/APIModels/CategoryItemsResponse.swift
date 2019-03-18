//
//	CategoryItemsResponse.swift
//
//	Create by Vidhyadharan Mohanram on 19/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class CategoryItemsResponse : NSObject, NSCopying{

//    public var combos : [AnyObject]!
	public var meta : Meta!
	public var objects : [Item]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    internal init(fromDictionary dictionary:  [String:Any], isUpsoldItems: Bool = false, isRecommendedItems: Bool = false){
//        combos = dictionary["combos"] as? [AnyObject]
		if let metaData: [String:Any] = dictionary["meta"] as? [String:Any]{
			meta = Meta(fromDictionary: metaData)
		}
		objects = [Item]()
		if let objectsArray: [[String:Any]] = dictionary["objects"] as? [[String:Any]]{
			for dic in objectsArray{
				let value: Item = Item(fromDictionary: dic)
                value.isUpsoldItem = isUpsoldItems
                value.isRecommendedItem = isRecommendedItems
				objects.append(value)
			}
		}
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
//        if combos != nil{
//            dictionary["combos"] = combos
//        }
        if meta != nil{
            dictionary["meta"] = meta.toDictionary()
        }
        if objects != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for objectsElement in objects {
                dictionaryElements.append(objectsElement.toDictionary())
            }
            dictionary["objects"] = dictionaryElements
        }
        return dictionary
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        return CategoryItemsResponse(fromDictionary: toDictionary())
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
//        if combos != nil{
//            aCoder.encode(combos, forKey: "combos")
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
