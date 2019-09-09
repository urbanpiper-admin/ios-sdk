//
//	OrderPayment.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class OrderPayment : NSObject, JSONDecodable{

	public var amount : Decimal!
	@objc public var option : String!
	public var srvrTrxId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let val: Decimal = dictionary["amount"] as? Decimal {
            amount = val
        } else if let val: Double = dictionary["amount"] as? Double {
            amount = Decimal(val).rounded
        } else if let val: Float = dictionary["amount"] as? Float {
            amount = Decimal(Double(val)).rounded
        } else {
            amount = Decimal.zero
        }
        
		option = dictionary["option"] as? String
		srvrTrxId = dictionary["srvr_trx_id"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String : AnyObject]
	{
		var dictionary = [String : AnyObject]()
		if let amount = amount {
			dictionary["amount"] = amount as AnyObject
		}
		if let option = option {
			dictionary["option"] = option as AnyObject
		}
		if let srvrTrxId = srvrTrxId {
			dictionary["srvr_trx_id"] = srvrTrxId as AnyObject
		}
		return dictionary
	}

/*    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? Float
         option = aDecoder.decodeObject(forKey: "option") as? String
         srvrTrxId = aDecoder.decodeObject(forKey: "srvr_trx_id") as? AnyObject

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if let amount = amount {
			aCoder.encode(amount, forKey: "amount")
		}
		if let option = option {
			aCoder.encode(option, forKey: "option")
		}
		if let srvrTrxId = srvrTrxId {
			aCoder.encode(srvrTrxId, forKey: "srvr_trx_id")
		}

	}*/

}
