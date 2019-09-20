//
//	ItemCategory.swift
//
//	Create by Vidhyadharan Mohanram on 19/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class ItemCategory: NSObject, JSONDecodable {
    public var id: Int = 0
    public var name: String!
    public var sortOrder: Int = 0

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String
        sortOrder = dictionary["sort_order"] as? Int ?? 0
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        if let name = name {
            dictionary["name"] = name as AnyObject
        }

        dictionary["sort_order"] = sortOrder as AnyObject

        return dictionary
    }

    func equitableCheckDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
//        if let name = name {
//            dictionary["name"] = name as AnyObject
//        }
//        if let sortOrder = sortOrder {
//            dictionary["sort_order"] = sortOrder as AnyObject
//        }
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
//         name = aDecoder.decodeObject(forKey: "name") as? String
//        sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
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
//        if let name = name {
//            aCoder.encode(name, forKey: "name")
//        }
//        if let sortOrder = sortOrder {
//            aCoder.encode(id, forKey: "sort_order")
//        }
//
//    }
}

extension ItemCategory {
    internal static func == (lhs: ItemCategory, rhs: ItemCategory) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.sortOrder == rhs.sortOrder
    }
}
