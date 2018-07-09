//
//	Transaction.swift
//
//	Create by Vidhyadharan Mohanram on 29/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Transaction : NSObject{

	public var billNumber : String!
	public var comments : String!
	public var created : Int!
	public var id : Int!
	public var paymentAmount : Int!
	public var paymentSrc : String!
	public var paymentType : String!
	public var posMcId : AnyObject!
	public var posOperatorUname : AnyObject!
	public var store : Store!
	public var transactionId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		billNumber = dictionary["bill_number"] as? String
		comments = dictionary["comments"] as? String
		created = dictionary["created"] as? Int
		id = dictionary["id"] as? Int
		paymentAmount = dictionary["payment_amount"] as? Int
		paymentSrc = dictionary["payment_src"] as? String
		paymentType = dictionary["payment_type"] as? String
		posMcId = dictionary["pos_mc_id"] as AnyObject
		posOperatorUname = dictionary["pos_operator_uname"] as AnyObject
		if let storeData: [String:Any] = dictionary["store"] as? [String:Any]{
			store = Store(fromDictionary: storeData)
		}
		transactionId = dictionary["transaction_id"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if billNumber != nil{
//            dictionary["bill_number"] = billNumber
//        }
//        if comments != nil{
//            dictionary["comments"] = comments
//        }
//        if created != nil{
//            dictionary["created"] = created
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if paymentAmount != nil{
//            dictionary["payment_amount"] = paymentAmount
//        }
//        if paymentSrc != nil{
//            dictionary["payment_src"] = paymentSrc
//        }
//        if paymentType != nil{
//            dictionary["payment_type"] = paymentType
//        }
//        if posMcId != nil{
//            dictionary["pos_mc_id"] = posMcId
//        }
//        if posOperatorUname != nil{
//            dictionary["pos_operator_uname"] = posOperatorUname
//        }
//        if store != nil{
//            dictionary["store"] = store.toDictionary()
//        }
//        if transactionId != nil{
//            dictionary["transaction_id"] = transactionId
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
//         id = aDecoder.decodeObject(forKey: "id") as? Int
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
//        if billNumber != nil{
//            aCoder.encode(billNumber, forKey: "bill_number")
//        }
//        if comments != nil{
//            aCoder.encode(comments, forKey: "comments")
//        }
//        if created != nil{
//            aCoder.encode(created, forKey: "created")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if paymentAmount != nil{
//            aCoder.encode(paymentAmount, forKey: "payment_amount")
//        }
//        if paymentSrc != nil{
//            aCoder.encode(paymentSrc, forKey: "payment_src")
//        }
//        if paymentType != nil{
//            aCoder.encode(paymentType, forKey: "payment_type")
//        }
//        if posMcId != nil{
//            aCoder.encode(posMcId, forKey: "pos_mc_id")
//        }
//        if posOperatorUname != nil{
//            aCoder.encode(posOperatorUname, forKey: "pos_operator_uname")
//        }
//        if store != nil{
//            aCoder.encode(store, forKey: "store")
//        }
//        if transactionId != nil{
//            aCoder.encode(transactionId, forKey: "transaction_id")
//        }
//
//    }

}
