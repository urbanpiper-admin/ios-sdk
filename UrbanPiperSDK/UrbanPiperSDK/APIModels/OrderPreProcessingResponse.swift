//
//	OrderPreProcessingResponse.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class OrderPreProcessingResponse : NSObject, NSCoding{

	public var order : Order!
    public var discount : Decimal?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		if let orderData = dictionary["order"] as? [String:Any]{
			order = Order(fromDictionary: orderData)
		}
        
        let priceVal = dictionary["discount"]
        if let val = priceVal as? Decimal {
            print("decimal amount value \(val)")
            discount = val
        } else if let val = priceVal as? Double {
            print("double amount value \(val)")
            discount = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: discount!).doubleValue))")
        } else if let val = priceVal as? Float {
            discount = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = priceVal as? Int {
            print("int amount value \(val)")
            discount = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: discount!).doubleValue))")
        } else {
            discount = Decimal(0).rounded
            print("amount value nil")
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if order != nil{
			dictionary["order"] = order.toDictionary()
		}
        if discount != nil{
            dictionary["discount"] = discount
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         order = aDecoder.decodeObject(forKey: "order") as? Order
        discount = aDecoder.decodeObject(forKey: "discount") as? Decimal

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if order != nil{
			aCoder.encode(order, forKey: "order")
		}
        if discount != nil{
            aCoder.encode(discount, forKey: "discount")
        }

	}

}