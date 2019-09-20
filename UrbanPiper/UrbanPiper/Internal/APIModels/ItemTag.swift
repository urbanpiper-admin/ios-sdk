//
//	ItemTag.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class ItemTag: NSObject, JSONDecodable {
    public var id: Int = 0
    public var title: String!
    public var group: String!
    public var tags: [ItemTag]!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        id = dictionary["id"] as? Int ?? 0
        title = dictionary["title"] as? String
        group = dictionary["group"] as? String
        tags = [ItemTag]()
        if let tagsArray: [[String: AnyObject]] = dictionary["tags"] as? [[String: AnyObject]] {
            for dic in tagsArray {
                guard let value: ItemTag = ItemTag(fromDictionary: dic) else { continue }
                tags.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        if let title = title {
            dictionary["title"] = title as AnyObject
        }
        if let group = group {
            dictionary["group"] = group as AnyObject
        }
        if let tags = tags {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for tagsElement in tags {
                dictionaryElements.append(tagsElement.toDictionary())
            }
            dictionary["tags"] = dictionaryElements as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
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
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let title = title {
//            aCoder.encode(title, forKey: "title")
//        }
//        if let group = group {
//            aCoder.encode(group, forKey: "group")
//        }
//        if let tags = tags {
//            aCoder.encode(tags, forKey: "tags")
//        }
//
//    }
}
