//
//	UserAddressesResponse.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class UserAddressesResponse : NSObject, NSCoding{

	public var addresses : [Address]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		addresses = [Address]()
		if let addressesArray = dictionary["addresses"] as? [[String:Any]]{
			for dic in addressesArray{
				let value = Address(fromDictionary: dic)
				addresses.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if addresses != nil{
			var dictionaryElements = [[String:Any]]()
			for addressesElement in addresses {
				dictionaryElements.append(addressesElement.toDictionary())
			}
			dictionary["addresses"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         addresses = aDecoder.decodeObject(forKey :"addresses") as? [Address]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if addresses != nil{
			aCoder.encode(addresses, forKey: "addresses")
		}

	}

}
