//
//	AddUpdateAddressResponse.swift
//
//	Create by Vidhyadharan Mohanram on 4/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class AddUpdateAddressResponse : NSObject{

	public var addressId : Int!
	public var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		addressId = dictionary["address_id"] as? Int
		msg = dictionary["msg"] as? String
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if addressId != nil{
            dictionary["address_id"] = addressId
        }
        if msg != nil{
            dictionary["msg"] = msg
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         addressId = aDecoder.decodeObject(forKey: "address_id") as? Int
//         msg = aDecoder.decodeObject(forKey: "msg") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if addressId != nil{
//            aCoder.encode(addressId, forKey: "address_id")
//        }
//        if msg != nil{
//            aCoder.encode(msg, forKey: "msg")
//        }
//
//    }

}
