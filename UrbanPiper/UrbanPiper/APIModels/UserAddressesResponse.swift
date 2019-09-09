//
//	UserAddressesResponse.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class UserAddressesResponse : NSObject, JSONDecodable{

	@objc public var addresses : [Address]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		addresses = [Address]()
		if let addressesArray: [[String : AnyObject]] = dictionary["addresses"] as? [[String : AnyObject]]{
			for dic in addressesArray{
				guard let value: Address = Address(fromDictionary: dic) else { continue }
				addresses.append(value)
			}
		}
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let addresses = addresses {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for addressesElement in addresses {
                dictionaryElements.append(addressesElement.toDictionary())
            }
            dictionary["addresses"] = dictionaryElements as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         addresses = aDecoder.decodeObject(forKey :"addresses") as? [Address]
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let addresses = addresses {
//            aCoder.encode(addresses, forKey: "addresses")
//        }
//
//    }

}
