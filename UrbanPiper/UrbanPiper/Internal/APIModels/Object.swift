//
//	Object.swift
//
//	Create by Vidhyadharan Mohanram on 8/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Object : NSObject, JSONDecodable{

	public var comboCount : Int!
	public var descriptionField : String!
	public var id : Int!
	public var image : String!
	public var itemCount : Int!
    public var loadFromWeb : Bool
	@objc public var name : String!
	public var slug : String!
	public var sortOrder : Int!
	public var webUrl : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		comboCount = dictionary["combo_count"] as? Int
		descriptionField = dictionary["description"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		itemCount = dictionary["item_count"] as? Int
		loadFromWeb = dictionary["load_from_web"] as? Bool ?? false
		name = dictionary["name"] as? String
		slug = dictionary["slug"] as? String
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		webUrl = dictionary["web_url"] as? String
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let comboCount = comboCount {
            dictionary["combo_count"] = comboCount as AnyObject
        }
        if let descriptionField = descriptionField {
            dictionary["description"] = descriptionField as AnyObject
        }
        if let id = id {
            dictionary["id"] = id as AnyObject
        }
        if let image = image {
            dictionary["image"] = image as AnyObject
        }
        if let itemCount = itemCount {
            dictionary["item_count"] = itemCount as AnyObject
        }
//        if let loadFromWeb = loadFromWeb {
            dictionary["load_from_web"] = loadFromWeb as AnyObject
//        }
        if let name = name {
            dictionary["name"] = name as AnyObject
        }
        if let slug = slug {
            dictionary["slug"] = slug as AnyObject
        }
        if let sortOrder = sortOrder {
            dictionary["sort_order"] = sortOrder as AnyObject
        }
        if let webUrl = webUrl {
            dictionary["web_url"] = webUrl as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         comboCount = aDecoder.decodeInteger(forKey: "combo_count")
//         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
//         id = aDecoder.decodeInteger(forKey: "id")
//         image = aDecoder.decodeObject(forKey: "image") as? String
//         itemCount = aDecoder.decodeInteger(forKey: "item_count")
//         loadFromWeb = val as? Bool ?? false
//         name = aDecoder.decodeObject(forKey: "name") as? String
//         slug = aDecoder.decodeObject(forKey: "slug") as? String
//         sortOrder = aDecoder.decodeInteger(forKey: "sort_order")
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
//        if let comboCount = comboCount {
//            aCoder.encode(comboCount, forKey: "combo_count")
//        }
//        if let descriptionField = descriptionField {
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let image = image {
//            aCoder.encode(image, forKey: "image")
//        }
//        if let itemCount = itemCount {
//            aCoder.encode(itemCount, forKey: "item_count")
//        }
//        if let loadFromWeb = loadFromWeb {
//            aCoder.encode(loadFromWeb, forKey: "load_from_web")
//        }
//        if let name = name {
//            aCoder.encode(name, forKey: "name")
//        }
//        if let slug = slug {
//            aCoder.encode(slug, forKey: "slug")
//        }
//        if let sortOrder = sortOrder {
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if let webUrl = webUrl {
//            aCoder.encode(webUrl, forKey: "web_url")
//        }
//
//    }

}
