//
//	AddUpdateAddressResponse.swift
//
//	Create by Vidhyadharan Mohanram on 4/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class AddUpdateAddressResponse : NSObject, JSONDecodable{

	public var addressId : Int!
	public var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		addressId = dictionary["address_id"] as? Int
		msg = dictionary["msg"] as? String
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let addressId = addressId {
            dictionary["address_id"] = addressId as AnyObject
        }
        if let msg = msg {
            dictionary["msg"] = msg as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         addressId = aDecoder.decodeInteger(forKey: "address_id")
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
//        if let addressId = addressId {
//            aCoder.encode(addressId, forKey: "address_id")
//        }
//        if let msg = msg {
//            aCoder.encode(msg, forKey: "msg")
//        }
//
//    }

}
