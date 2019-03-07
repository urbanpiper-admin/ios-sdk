//
//	ItemTag.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemTag : NSObject{

	public private(set)  var id : Int!
	public private(set)  var title : String!
	public private(set)  var group : String!
	public private(set)  var tags : [ItemTag]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		id = dictionary["id"] as? Int
		title = dictionary["title"] as? String
		group = dictionary["group"] as? String
		tags = [ItemTag]()
		if let tagsArray: [[String:Any]] = dictionary["tags"] as? [[String:Any]]{
			for dic in tagsArray{
				let value: ItemTag = ItemTag(fromDictionary: dic)
				tags.append(value)
			}
		}
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if title != nil{
            dictionary["title"] = title
        }
        if group != nil{
            dictionary["group"] = group
        }
        if tags != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for tagsElement in tags {
                dictionaryElements.append(tagsElement.toDictionary())
            }
            dictionary["tags"] = dictionaryElements
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         title = aDecoder.decodeObject(forKey: "title") as? String
//         group = aDecoder.decodeObject(forKey: "group") as? String
//         tags = aDecoder.decodeObject(forKey :"tags") as? [ItemTag]
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
//        if group != nil{
//            aCoder.encode(group, forKey: "group")
//        }
//        if tags != nil{
//            aCoder.encode(tags, forKey: "tags")
//        }
//
//    }

}
