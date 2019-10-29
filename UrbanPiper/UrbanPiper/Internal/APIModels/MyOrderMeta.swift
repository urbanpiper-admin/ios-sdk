//
//	MyOrderMeta.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class MyOrderMeta: NSObject, JSONDecodable {
    public var limit: Int = 20
    public var next: String!
    public var offset: Int = 0
    public var previous: String!
    public var totalCount: Int = 0

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        limit = dictionary["limit"] as? Int ?? 20
        next = dictionary["next"] as? String
        offset = dictionary["offset"] as? Int ?? 0
        previous = dictionary["previous"] as? String
        totalCount = dictionary["total_count"] as? Int ?? 0
    }

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let limit = limit {
//            dictionary["limit"] = limit as AnyObject
//        }
//        if let next = next {
//            dictionary["next"] = next as AnyObject
//        }
//        if let offset = offset {
//            dictionary["offset"] = offset as AnyObject
//        }
//        if let previous = previous {
//            dictionary["previous"] = previous as AnyObject
//        }
//        if let totalCount = totalCount {
//            dictionary["total_count"] = totalCount as AnyObject
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
//         limit = aDecoder.decodeObject(forKey: "limit") as? Int
//         next = aDecoder.decodeObject(forKey: "next") as? String
//         offset = aDecoder.decodeObject(forKey: "offset") as? Int
//         previous = aDecoder.decodeObject(forKey: "previous") as AnyObject
//         totalCount = aDecoder.decodeObject(forKey: "total_count") as? Int
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let limit = limit {
//            aCoder.encode(limit, forKey: "limit")
//        }
//        if let next = next {
//            aCoder.encode(next, forKey: "next")
//        }
//        if let offset = offset {
//            aCoder.encode(offset, forKey: "offset")
//        }
//        if let previous = previous {
//            aCoder.encode(previous, forKey: "previous")
//        }
//        if let totalCount = totalCount {
//            aCoder.encode(totalCount, forKey: "total_count")
//        }
//
//    }
}
