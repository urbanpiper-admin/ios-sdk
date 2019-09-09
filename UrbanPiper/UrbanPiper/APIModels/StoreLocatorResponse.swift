//
//	StoreListResponse.swift
//
//	Create by Vidhyadharan Mohanram on 4/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class StoreListResponse : NSObject, JSONDecodable{

	public var biz : Biz!
	public var stores : [Store]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		if let bizData = dictionary["biz"] as? [String : AnyObject]{
			biz = Biz(fromDictionary: bizData)
		}
		stores = [Store]()
		if let storesArray = dictionary["stores"] as? [[String : AnyObject]]{
			for dic in storesArray{
				guard let value = Store(fromDictionary: dic) else { continue }
                guard !value.hideStoreName else { continue }
				stores.append(value)
			}
		}
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let biz = biz {
            dictionary["biz"] = biz.toDictionary() as AnyObject
        }
        if let stores = stores {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for storesElement in stores {
                dictionaryElements.append(storesElement.toDictionary())
            }
            dictionary["stores"] = dictionaryElements as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         biz = aDecoder.decodeObject(forKey: "biz") as? Biz
//         stores = aDecoder.decodeObject(forKey :"stores") as? [Store]
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let biz = biz {
//            aCoder.encode(biz, forKey: "biz")
//        }
//        if let stores = stores {
//            aCoder.encode(stores, forKey: "stores")
//        }
//
//    }

}
