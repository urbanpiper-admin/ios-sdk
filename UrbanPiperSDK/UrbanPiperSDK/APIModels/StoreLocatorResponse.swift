//
//	StoreListResponse.swift
//
//	Create by Vidhyadharan Mohanram on 4/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class StoreListResponse : NSObject{

	public private(set)  var biz : Biz!
	public internal(set)  var stores : [Store]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let bizData = dictionary["biz"] as? [String:Any]{
			biz = Biz(fromDictionary: bizData)
		}
		stores = [Store]()
		if let storesArray = dictionary["stores"] as? [[String:Any]]{
			for dic in storesArray{
				let value = Store(fromDictionary: dic)
                guard !value.hideStoreName else { continue }
				stores.append(value)
			}
		}
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if biz != nil{
            dictionary["biz"] = biz.toDictionary()
        }
        if stores != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for storesElement in stores {
                dictionaryElements.append(storesElement.toDictionary())
            }
            dictionary["stores"] = dictionaryElements
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
//        if biz != nil{
//            aCoder.encode(biz, forKey: "biz")
//        }
//        if stores != nil{
//            aCoder.encode(stores, forKey: "stores")
//        }
//
//    }

}
