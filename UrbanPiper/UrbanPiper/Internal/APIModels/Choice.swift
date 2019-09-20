//
//	Choice.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class Choice: NSObject, JSONDecodable, NSCoding {
    public var id: Int = 0
    public var sortOrder: Int?
    public var text: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        id = dictionary["id"] as? Int ?? 0
        sortOrder = dictionary["sort_order"] as? Int ?? 0
        text = dictionary["text"] as? String
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        if let sortOrder = sortOrder {
            dictionary["sort_order"] = sortOrder as AnyObject
        }
        if let text = text {
            dictionary["text"] = text as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        if let val = aDecoder.decodeObject(forKey: "id") as? Int {
            id = val
        } else {
            id = aDecoder.decodeInteger(forKey: "id")
        }
        sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
        text = aDecoder.decodeObject(forKey: "text") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        if let sortOrder = sortOrder {
            aCoder.encode(sortOrder, forKey: "sort_order")
        }
        if let text = text {
            aCoder.encode(text, forKey: "text")
        }
    }
}
