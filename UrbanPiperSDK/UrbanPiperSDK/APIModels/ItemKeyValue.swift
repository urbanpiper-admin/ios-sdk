//
//	ItemKeyValue.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemKeyValue : NSObject{

	public var id : Int!
	public var key : String!
	public var value : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		id = dictionary["id"] as? Int
		key = dictionary["key"] as? String
		value = dictionary["value"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if key != nil{
//            dictionary["key"] = key
//        }
//        if value != nil{
//            dictionary["value"] = value
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
//         id = aDecoder.decodeObject(forKey: "id") as? Int
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
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if key != nil{
//            aCoder.encode(key, forKey: "key")
//        }
//        if value != nil{
//            aCoder.encode(value, forKey: "value")
//        }
//
//    }

}
