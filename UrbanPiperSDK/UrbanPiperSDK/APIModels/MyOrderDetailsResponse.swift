//
//	MyOrderDetailsResponse.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class MyOrderDetailsResponse : NSObject{

	public var customer : Customer!
	public var order : OrderDetails!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let customerData = dictionary["customer"] as? [String:Any]{
			customer = Customer(fromDictionary: customerData)
		}
		if let orderData = dictionary["order"] as? [String:Any]{
			order = OrderDetails(fromDictionary: orderData)
		}
	}

/*	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if customer != nil{
			dictionary["customer"] = customer.toDictionary()
		}
		if order != nil{
			dictionary["order"] = order.toDictionary()
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
		if customer != nil{
			aCoder.encode(customer, forKey: "customer")
		}
		if order != nil{
			aCoder.encode(order, forKey: "order")
		}

	}*/

}
