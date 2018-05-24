//
//	StoreResponse.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class StoreResponse : NSObject, NSCoding{

    @objc public var biz : Biz!
    @objc public var store : Store?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		if let bizData = dictionary["biz"] as? [String:Any]{
			biz = Biz(fromDictionary: bizData)
		}
		if let storeData = dictionary["store"] as? [String:Any]{
			store = Store(fromDictionary: storeData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    @objc public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if biz != nil{
			dictionary["biz"] = biz.toDictionary()
		}
		if store != nil{
			dictionary["store"] = store!.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
        biz = aDecoder.decodeObject(forKey: "biz") as? Biz
        store = aDecoder.decodeObject(forKey: "store") as? Store
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if biz != nil{
			aCoder.encode(biz, forKey: "biz")
		}
		if store != nil{
			aCoder.encode(store, forKey: "store")
		}

	}

}