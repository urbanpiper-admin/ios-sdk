//
//	CardAPIResponse.swift
//
//	Create by Vidhyadharan Mohanram on 11/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class CardAPIResponse : NSObject{

	public var approvalCode : String!
	public var authKey : String!
	public var cardNumber : String!
	public var customerEmail : String!
	public var customerName : String!
	public var customerPhone : String!
	public var message : String!
	public var points : Float!
	public var prepaidBalance : Float!
	public var result : String!
	public var success : Bool!
	public var timestamp : String!
	public var totalBalance : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		approvalCode = dictionary["approval_code"] as? String
		authKey = dictionary["auth_key"] as? String
		cardNumber = dictionary["card_number"] as? String
		customerEmail = dictionary["customer_email"] as? String
		customerName = dictionary["customer_name"] as? String
		customerPhone = dictionary["customer_phone"] as? String
		message = dictionary["message"] as? String
		points = dictionary["points"] as? Float
		prepaidBalance = dictionary["prepaid_balance"] as? Float
		result = dictionary["result"] as? String
		success = dictionary["success"] as? Bool
		timestamp = dictionary["timestamp"] as? String
		totalBalance = dictionary["total_balance"] as? Float
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if approvalCode != nil{
//            dictionary["approval_code"] = approvalCode
//        }
//        if authKey != nil{
//            dictionary["auth_key"] = authKey
//        }
//        if cardNumber != nil{
//            dictionary["card_number"] = cardNumber
//        }
//        if customerEmail != nil{
//            dictionary["customer_email"] = customerEmail
//        }
//        if customerName != nil{
//            dictionary["customer_name"] = customerName
//        }
//        if customerPhone != nil{
//            dictionary["customer_phone"] = customerPhone
//        }
//        if message != nil{
//            dictionary["message"] = message
//        }
//        if points != nil{
//            dictionary["points"] = points
//        }
//        if prepaidBalance != nil{
//            dictionary["prepaid_balance"] = prepaidBalance
//        }
//        if result != nil{
//            dictionary["result"] = result
//        }
//        if success != nil{
//            dictionary["success"] = success
//        }
//        if timestamp != nil{
//            dictionary["timestamp"] = timestamp
//        }
//        if totalBalance != nil{
//            dictionary["total_balance"] = totalBalance
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
//         approvalCode = aDecoder.decodeObject(forKey: "approval_code") as? String
//         authKey = aDecoder.decodeObject(forKey: "auth_key") as? String
//         cardNumber = aDecoder.decodeObject(forKey: "card_number") as? String
//         customerEmail = aDecoder.decodeObject(forKey: "customer_email") as? String
//         customerName = aDecoder.decodeObject(forKey: "customer_name") as? String
//         customerPhone = aDecoder.decodeObject(forKey: "customer_phone") as? String
//         message = aDecoder.decodeObject(forKey: "message") as? String
//         points = aDecoder.decodeObject(forKey: "points") as? Float
//         prepaidBalance = aDecoder.decodeObject(forKey: "prepaid_balance") as? Float
//         result = aDecoder.decodeObject(forKey: "result") as? String
//         success = aDecoder.decodeObject(forKey: "success") as? Bool
//         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
//         totalBalance = aDecoder.decodeObject(forKey: "total_balance") as? Float
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if approvalCode != nil{
//            aCoder.encode(approvalCode, forKey: "approval_code")
//        }
//        if authKey != nil{
//            aCoder.encode(authKey, forKey: "auth_key")
//        }
//        if cardNumber != nil{
//            aCoder.encode(cardNumber, forKey: "card_number")
//        }
//        if customerEmail != nil{
//            aCoder.encode(customerEmail, forKey: "customer_email")
//        }
//        if customerName != nil{
//            aCoder.encode(customerName, forKey: "customer_name")
//        }
//        if customerPhone != nil{
//            aCoder.encode(customerPhone, forKey: "customer_phone")
//        }
//        if message != nil{
//            aCoder.encode(message, forKey: "message")
//        }
//        if points != nil{
//            aCoder.encode(points, forKey: "points")
//        }
//        if prepaidBalance != nil{
//            aCoder.encode(prepaidBalance, forKey: "prepaid_balance")
//        }
//        if result != nil{
//            aCoder.encode(result, forKey: "result")
//        }
//        if success != nil{
//            aCoder.encode(success, forKey: "success")
//        }
//        if timestamp != nil{
//            aCoder.encode(timestamp, forKey: "timestamp")
//        }
//        if totalBalance != nil{
//            aCoder.encode(totalBalance, forKey: "total_balance")
//        }
//
//    }

}
