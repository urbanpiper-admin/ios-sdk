//
//	MyOrdersResponse.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class PastOrdersResponse : NSObject{

	public var meta : Meta!
	public var orders : [PastOrder]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let metaData = dictionary["meta"] as? [String:Any]{
			meta = Meta(fromDictionary: metaData)
		}
		orders = [PastOrder]()
		if let ordersArray = dictionary["orders"] as? [[String:Any]]{
			for dic in ordersArray{
				let value = PastOrder(fromDictionary: dic)
				orders.append(value)
			}
		}
	}

/*	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if meta != nil{
			dictionary["meta"] = meta.toDictionary()
		}
		if orders != nil{
			var dictionaryElements = [[String:Any]]()
			for ordersElement in orders {
				dictionaryElements.append(ordersElement.toDictionary())
			}
			dictionary["orders"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         meta = aDecoder.decodeObject(forKey: "meta") as? Meta
         orders = aDecoder.decodeObject(forKey :"orders") as? [MyOrder]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if meta != nil{
			aCoder.encode(meta, forKey: "meta")
		}
		if orders != nil{
			aCoder.encode(orders, forKey: "orders")
		}

	}*/

}
