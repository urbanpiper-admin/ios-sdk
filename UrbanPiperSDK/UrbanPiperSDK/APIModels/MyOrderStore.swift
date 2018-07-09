//
//	MyOrderStore.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class MyOrderStore : NSObject{

	public var bizLocationId : Int!
	public var name : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		bizLocationId = dictionary["biz_location_id"] as? Int
		name = dictionary["name"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if bizLocationId != nil{
//            dictionary["biz_location_id"] = bizLocationId
//        }
//        if name != nil{
//            dictionary["name"] = name
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
//         bizLocationId = aDecoder.decodeObject(forKey: "biz_location_id") as? Int
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
//        if bizLocationId != nil{
//            aCoder.encode(bizLocationId, forKey: "biz_location_id")
//        }
//        if name != nil{
//            aCoder.encode(name, forKey: "name")
//        }
//
//    }

}
