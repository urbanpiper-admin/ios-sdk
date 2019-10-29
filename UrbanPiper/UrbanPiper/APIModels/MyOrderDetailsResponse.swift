//
//	PastOrderDetailsResponse.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class PastOrderDetailsResponse: NSObject, JSONDecodable {
    @objc public var customer: Customer!
    @objc public var order: OrderDetails!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let customerData = dictionary["customer"] as? [String: AnyObject] {
            customer = Customer(fromDictionary: customerData)
        }
        if let orderData = dictionary["order"] as? [String: AnyObject] {
            order = OrderDetails(fromDictionary: orderData)
        }
    }

    /*	/**
         * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String : AnyObject]
    {
    	var dictionary = [String : AnyObject]()
    	if let customer = customer {
    		dictionary["customer"] = customer.toDictionary() as AnyObject
    	}
    	if let order = order {
    		dictionary["order"] = order.toDictionary() as AnyObject
    	}
    	return dictionary
    }

    /**
        * NSCoding required initializer.
        * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
    customer = aDecoder.decodeObject(forKey: "customer") as? Customer
    order = aDecoder.decodeObject(forKey: "order") as? Order

    }

    /**
        * NSCoding required method.
        * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
    	if let customer = customer {
    		aCoder.encode(customer, forKey: "customer")
    	}
    	if let order = order {
    		aCoder.encode(order, forKey: "order")
    	}

    }*/
}
