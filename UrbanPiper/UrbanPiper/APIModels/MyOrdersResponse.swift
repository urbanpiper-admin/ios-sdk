//
//	MyOrdersResponse.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class PastOrdersResponse: NSObject, JSONDecodable {
    public var meta: Meta!
    @objc public var orders: [PastOrder]!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let metaData = dictionary["meta"] as? [String: AnyObject] {
            meta = Meta(fromDictionary: metaData)
        }
        orders = [PastOrder]()
        if let ordersArray = dictionary["orders"] as? [[String: AnyObject]] {
            for dic in ordersArray {
                guard let value = PastOrder(fromDictionary: dic) else { continue }
                orders.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        if let meta = meta {
            dictionary["meta"] = meta.toDictionary() as AnyObject
        }
        if let orders = orders {
            var dictionaryElements = [[String: AnyObject]]()
            for ordersElement in orders {
                dictionaryElements.append(ordersElement.toDictionary())
            }
            dictionary["orders"] = dictionaryElements as AnyObject
        }
        return dictionary
    }

    /*    /**
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
    	if let meta = meta {
    		aCoder.encode(meta, forKey: "meta")
    	}
    	if let orders = orders {
    		aCoder.encode(orders, forKey: "orders")
    	}

    }*/
}
