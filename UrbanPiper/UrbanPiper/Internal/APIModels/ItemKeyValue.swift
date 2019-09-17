//
//	ItemKeyValue.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemKeyValue : NSObject, JSONDecodable{

	public var id : Int = 0
	public var key : String!
	public var value : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		id = dictionary["id"] as? Int ?? 0
		key = dictionary["key"] as? String
		value = dictionary["value"] as? String
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        dictionary["id"] = id as AnyObject
        if let key = key {
            dictionary["key"] = key as AnyObject
        }
        if let value = value {
            dictionary["value"] = value as AnyObject
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
//         key = aDecoder.decodeObject(forKey: "key") as? String
//         value = aDecoder.decodeObject(forKey: "value") as? String
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
//        if let key = key {
//            aCoder.encode(key, forKey: "key")
//        }
//        if let value = value {
//            aCoder.encode(value, forKey: "value")
//        }
//
//    }

}
