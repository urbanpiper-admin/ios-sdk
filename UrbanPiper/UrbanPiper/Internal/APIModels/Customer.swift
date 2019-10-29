//
//	Customer.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objc public class Customer: NSObject, JSONDecodable {
    @objc public var address: Address!
    @objc public var email: String!
    @objc public var name: String!
    @objc public var phone: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let addressData = dictionary["address"] as? [String: AnyObject] {
            address = Address(fromDictionary: addressData)
        }
        email = dictionary["email"] as? String
        name = dictionary["name"] as? String
        phone = dictionary["phone"] as? String
    }

    /*	/**
         * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String : AnyObject]
    {
    	var dictionary = [String : AnyObject]()
    	if let address = address {
    		dictionary["address"] = address.toDictionary() as AnyObject
    	}
    	if let email = email {
    		dictionary["email"] = email as AnyObject
    	}
    	if let name = name {
    		dictionary["name"] = name as AnyObject
    	}
    	if let phone = phone {
    		dictionary["phone"] = phone as AnyObject
    	}
    	return dictionary
    }

    /**
        * NSCoding required initializer.
        * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
    address = aDecoder.decodeObject(forKey: "address") as? Addres
    email = aDecoder.decodeObject(forKey: "email") as? String
    name = aDecoder.decodeObject(forKey: "name") as? String
    phone = aDecoder.decodeObject(forKey: "phone") as? String

    }

    /**
        * NSCoding required method.
        * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
    	if let address = address {
    		aCoder.encode(address, forKey: "address")
    	}
    	if let email = email {
    		aCoder.encode(email, forKey: "email")
    	}
    	if let name = name {
    		aCoder.encode(name, forKey: "name")
    	}
    	if let phone = phone {
    		aCoder.encode(phone, forKey: "phone")
    	}

    }*/
}
