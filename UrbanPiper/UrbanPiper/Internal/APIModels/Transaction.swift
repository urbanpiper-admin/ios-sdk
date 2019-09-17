//
//	Transaction.swift
//
//	Create by Vidhyadharan Mohanram on 29/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Transaction : NSObject, JSONDecodable{

	public var billNumber : String!
	public var comments : String!
	public var created : Int = 0
	public var id : Int = 0
	public var paymentAmount : Decimal!
	public var paymentSrc : String!
	public var paymentType : String!
	public var posMcId : AnyObject!
	public var posOperatorUname : AnyObject!
	public var store : Store!
	public var transactionId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		billNumber = dictionary["bill_number"] as? String
		comments = dictionary["comments"] as? String
		created = dictionary["created"] as? Int ?? 0
		id = dictionary["id"] as? Int ?? 0
        
        let priceVal = dictionary["payment_amount"]
        if let val: Decimal = priceVal as? Decimal {
            paymentAmount = val
        } else if let val: Double = priceVal as? Double {
            paymentAmount = Decimal(val).rounded
        } else {
            paymentAmount = Decimal.zero
        }
        
		paymentSrc = dictionary["payment_src"] as? String
		paymentType = dictionary["payment_type"] as? String
		posMcId = dictionary["pos_mc_id"] as AnyObject
		posOperatorUname = dictionary["pos_operator_uname"] as AnyObject
		if let storeData: [String : AnyObject] = dictionary["store"] as? [String : AnyObject]{
			store = Store(fromDictionary: storeData)
		}
		transactionId = dictionary["transaction_id"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let billNumber = billNumber {
//            dictionary["bill_number"] = billNumber as AnyObject
//        }
//        if let comments = comments {
//            dictionary["comments"] = comments as AnyObject
//        }
//        if let created = created {
//            dictionary["created"] = created as AnyObject
//        }
//        if let id = id {
//            dictionary["id"] = id as AnyObject
//        }
//        if let paymentAmount = paymentAmount {
//            dictionary["payment_amount"] = paymentAmount as AnyObject
//        }
//        if let paymentSrc = paymentSrc {
//            dictionary["payment_src"] = paymentSrc as AnyObject
//        }
//        if let paymentType = paymentType {
//            dictionary["payment_type"] = paymentType as AnyObject
//        }
//        if let posMcId = posMcId {
//            dictionary["pos_mc_id"] = posMcId as AnyObject
//        }
//        if let posOperatorUname = posOperatorUname {
//            dictionary["pos_operator_uname"] = posOperatorUname as AnyObject
//        }
//        if let store = store {
//            dictionary["store"] = store.toDictionary() as AnyObject
//        }
//        if let transactionId = transactionId {
//            dictionary["transaction_id"] = transactionId as AnyObject
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
//         billNumber = aDecoder.decodeObject(forKey: "bill_number") as? String
//         comments = aDecoder.decodeObject(forKey: "comments") as? String
//         created = aDecoder.decodeObject(forKey: "created") as? Int
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
//         paymentAmount = aDecoder.decodeObject(forKey: "payment_amount") as? Int
//         paymentSrc = aDecoder.decodeObject(forKey: "payment_src") as? String
//         paymentType = aDecoder.decodeObject(forKey: "payment_type") as? String
//         posMcId = aDecoder.decodeObject(forKey: "pos_mc_id") as AnyObject
//         posOperatorUname = aDecoder.decodeObject(forKey: "pos_operator_uname") as AnyObject
//         store = aDecoder.decodeObject(forKey: "store") as? Store
//         transactionId = aDecoder.decodeObject(forKey: "transaction_id") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let billNumber = billNumber {
//            aCoder.encode(billNumber, forKey: "bill_number")
//        }
//        if let comments = comments {
//            aCoder.encode(comments, forKey: "comments")
//        }
//        if let created = created {
//            aCoder.encode(created, forKey: "created")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let paymentAmount = paymentAmount {
//            aCoder.encode(paymentAmount, forKey: "payment_amount")
//        }
//        if let paymentSrc = paymentSrc {
//            aCoder.encode(paymentSrc, forKey: "payment_src")
//        }
//        if let paymentType = paymentType {
//            aCoder.encode(paymentType, forKey: "payment_type")
//        }
//        if let posMcId = posMcId {
//            aCoder.encode(posMcId, forKey: "pos_mc_id")
//        }
//        if let posOperatorUname = posOperatorUname {
//            aCoder.encode(posOperatorUname, forKey: "pos_operator_uname")
//        }
//        if let store = store {
//            aCoder.encode(store, forKey: "store")
//        }
//        if let transactionId = transactionId {
//            aCoder.encode(transactionId, forKey: "transaction_id")
//        }
//
//    }

}
