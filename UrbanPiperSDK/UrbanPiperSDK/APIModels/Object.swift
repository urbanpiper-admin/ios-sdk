//
//	Object.swift
//
//	Create by Vidhyadharan Mohanram on 8/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Object : NSObject{

	public var comboCount : Int!
	public var descriptionField : String!
	public var id : Int!
	public var image : String!
	public var itemCount : Int!
	public var loadFromWeb : Bool!
	@objc public var name : String!
	public var slug : String!
	public var sortOrder : Int!
	public var webUrl : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		comboCount = dictionary["combo_count"] as? Int
		descriptionField = dictionary["description"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		itemCount = dictionary["item_count"] as? Int
		loadFromWeb = dictionary["load_from_web"] as? Bool
		name = dictionary["name"] as? String
		slug = dictionary["slug"] as? String
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		webUrl = dictionary["web_url"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if comboCount != nil{
//            dictionary["combo_count"] = comboCount
//        }
//        if descriptionField != nil{
//            dictionary["description"] = descriptionField
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if image != nil{
//            dictionary["image"] = image
//        }
//        if itemCount != nil{
//            dictionary["item_count"] = itemCount
//        }
//        if loadFromWeb != nil{
//            dictionary["load_from_web"] = loadFromWeb
//        }
//        if name != nil{
//            dictionary["name"] = name
//        }
//        if slug != nil{
//            dictionary["slug"] = slug
//        }
//        if sortOrder != nil{
//            dictionary["sort_order"] = sortOrder
//        }
//        if webUrl != nil{
//            dictionary["web_url"] = webUrl
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
//         comboCount = aDecoder.decodeObject(forKey: "combo_count") as? Int
//         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         image = aDecoder.decodeObject(forKey: "image") as? String
//         itemCount = aDecoder.decodeObject(forKey: "item_count") as? Int
//         loadFromWeb = aDecoder.decodeObject(forKey: "load_from_web") as? Bool
//         name = aDecoder.decodeObject(forKey: "name") as? String
//         slug = aDecoder.decodeObject(forKey: "slug") as? String
//         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
//         webUrl = aDecoder.decodeObject(forKey: "web_url") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if comboCount != nil{
//            aCoder.encode(comboCount, forKey: "combo_count")
//        }
//        if descriptionField != nil{
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if image != nil{
//            aCoder.encode(image, forKey: "image")
//        }
//        if itemCount != nil{
//            aCoder.encode(itemCount, forKey: "item_count")
//        }
//        if loadFromWeb != nil{
//            aCoder.encode(loadFromWeb, forKey: "load_from_web")
//        }
//        if name != nil{
//            aCoder.encode(name, forKey: "name")
//        }
//        if slug != nil{
//            aCoder.encode(slug, forKey: "slug")
//        }
//        if sortOrder != nil{
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if webUrl != nil{
//            aCoder.encode(webUrl, forKey: "web_url")
//        }
//
//    }

}
