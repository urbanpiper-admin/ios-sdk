//
//	MyOrderStore.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objc public class MyOrderStore: NSObject, Codable {
    public var bizLocationid: Int?
    public var name: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        bizLocationid = dictionary["biz_location_id"] as? Int
        name = dictionary["name"] as? String
    }

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let bizLocationid = bizLocationid {
//            dictionary["biz_location_id"] = bizLocationid as AnyObject
//        }
//        if let name = name {
//            dictionary["name"] = name as AnyObject
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
//         bizLocationid = aDecoder.decodeObject(forKey: "biz_location_id") as? Int
//         name = aDecoder.decodeObject(forKey: "name") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let bizLocationid = bizLocationid {
//            aCoder.encode(bizLocationid, forKey: "biz_location_id")
//        }
//        if let name = name {
//            aCoder.encode(name, forKey: "name")
//        }
//
//    }
}
