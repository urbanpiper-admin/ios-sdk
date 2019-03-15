//
//	Customer.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class Customer : NSObject{

	@objc public private(set) var address : Address!
	@objc public private(set) var email : String!
	@objc public private(set) var name : String!
	@objc public private(set) var phone : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let addressData = dictionary["address"] as? [String:Any]{
			address = Address(fromDictionary: addressData)
		}
		email = dictionary["email"] as? String
		name = dictionary["name"] as? String
		phone = dictionary["phone"] as? String
	}

/*	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if address != nil{
			dictionary["address"] = address.toDictionary()
		}
		if email != nil{
			dictionary["email"] = email
		}
		if name != nil{
			dictionary["name"] = name
		}
		if phone != nil{
			dictionary["phone"] = phone
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
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}

	}*/

}
