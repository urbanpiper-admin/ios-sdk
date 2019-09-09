//
//	ItemExtra.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemExtra : NSObject, JSONDecodable{

	public var id : Int!
	public var keyValues : [ItemKeyValue]!
	public var name : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		id = dictionary["id"] as? Int
		keyValues = [ItemKeyValue]()
		if let keyValuesArray: [[String : AnyObject]] = dictionary["key_values"] as? [[String : AnyObject]]{
			for dic in keyValuesArray{
				guard let value: ItemKeyValue = ItemKeyValue(fromDictionary: dic) else { continue }
				keyValues.append(value)
			}
		}
		name = dictionary["name"] as? String
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let id = id {
            dictionary["id"] = id as AnyObject
        }
        if let keyValues = keyValues {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for keyValuesElement in keyValues {
                dictionaryElements.append(keyValuesElement.toDictionary())
            }
            dictionary["key_values"] = dictionaryElements as AnyObject
        }
        if let name = name {
            dictionary["name"] = name as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         id = aDecoder.decodeInteger(forKey: "id")
//         keyValues = aDecoder.decodeObject(forKey :"key_values") as? [ItemKeyValue]
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
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let keyValues = keyValues {
//            aCoder.encode(keyValues, forKey: "key_values")
//        }
//        if let name = name {
//            aCoder.encode(name, forKey: "name")
//        }
//
//    }

}
