//
//	PreProcessOrderResponse.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class PreProcessOrderResponse : NSObject{

	public var order : Order!
//    public var discount : Decimal?
    public var notification : String?
    public var status : String?
    public var message : String?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		if let orderData: [String:Any] = dictionary["order"] as? [String:Any]{
			order = Order(fromDictionary: orderData)
		}
        
        notification = dictionary["notification"] as? String
        status = dictionary["status"] as? String
        message = dictionary["message"] as? String

//        let priceVal = dictionary["discount"]
//        if let val: Decimal = priceVal as? Decimal {
//            discount = val
//        } else if let val: Double = priceVal as? Double {
//            discount = Decimal(val).rounded
//        } else {
//            discount = Decimal.zero
//        }
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if order != nil{
//            dictionary["order"] = order.toDictionary()
//        }
//        if discount != nil{
//            dictionary["discount"] = discount
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         order = aDecoder.decodeObject(forKey: "order") as? Order
//        discount = aDecoder.decodeObject(forKey: "discount") as? Decimal
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if order != nil{
//            aCoder.encode(order, forKey: "order")
//        }
//        if discount != nil{
//            aCoder.encode(discount, forKey: "discount")
//        }
//
//    }

}
