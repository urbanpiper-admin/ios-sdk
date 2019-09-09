//
//	RegistrationResponse.swift
//
//	Create by Vidhyadharan Mohanram on 11/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class RegistrationResponse : NSObject, JSONDecodable{

//    public var approvalCode : String!
//    public var authKey : String!
//    public var cardNumber : String!
//    public var customerEmail : String!
//    public var customerName : String!
//    public var customerPhone : String!
	public var message : String!
//    public var points : Float!
//    public var prepaidBalance : Float!
	public var result : String!
    public var success : Bool
//    public var timestamp : String!
//    public var totalBalance : Float!
    public var token : String?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
//        approvalCode = dictionary["approval_code"] as? String
//        authKey = dictionary["auth_key"] as? String
//        cardNumber = dictionary["card_number"] as? String
//        customerEmail = dictionary["customer_email"] as? String
//        customerName = dictionary["customer_name"] as? String
//        customerPhone = dictionary["customer_phone"] as? String
		message = dictionary["message"] as? String
//        points = dictionary["points"] as? Float
//        prepaidBalance = dictionary["prepaid_balance"] as? Float
		result = dictionary["result"] as? String
		success = dictionary["success"] as? Bool ?? false
//        timestamp = dictionary["timestamp"] as? String
//        totalBalance = dictionary["total_balance"] as? Float
        token = dictionary["access_token"] as? String
        if token == nil {
            token = dictionary["token"] as? String
        }
	}

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let approvalCode = approvalCode {
//            dictionary["approval_code"] = approvalCode as AnyObject
//        }
//        if let authKey = authKey {
//            dictionary["auth_key"] = authKey as AnyObject
//        }
//        if let cardNumber = cardNumber {
//            dictionary["card_number"] = cardNumber as AnyObject
//        }
//        if let customerEmail = customerEmail {
//            dictionary["customer_email"] = customerEmail as AnyObject
//        }
//        if let customerName = customerName {
//            dictionary["customer_name"] = customerName as AnyObject
//        }
//        if let customerPhone = customerPhone {
//            dictionary["customer_phone"] = customerPhone as AnyObject
//        }
//        if let message = message {
//            dictionary["message"] = message as AnyObject
//        }
//        if let points = points {
//            dictionary["points"] = points as AnyObject
//        }
//        if let prepaidBalance = prepaidBalance {
//            dictionary["prepaid_balance"] = prepaidBalance as AnyObject
//        }
//        if let result = result {
//            dictionary["result"] = result as AnyObject
//        }
//
//        dictionary["success"] = success as AnyObject
//        
//        if let timestamp = timestamp {
//            dictionary["timestamp"] = timestamp as AnyObject
//        }
//        if let totalBalance = totalBalance {
//            dictionary["total_balance"] = totalBalance as AnyObject
//        }
//        if let token = token {
//            dictionary["token"] = token as AnyObject
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
//         success = val as? Bool ?? false
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
//        if let approvalCode = approvalCode {
//            aCoder.encode(approvalCode, forKey: "approval_code")
//        }
//        if let authKey = authKey {
//            aCoder.encode(authKey, forKey: "auth_key")
//        }
//        if let cardNumber = cardNumber {
//            aCoder.encode(cardNumber, forKey: "card_number")
//        }
//        if let customerEmail = customerEmail {
//            aCoder.encode(customerEmail, forKey: "customer_email")
//        }
//        if let customerName = customerName {
//            aCoder.encode(customerName, forKey: "customer_name")
//        }
//        if let customerPhone = customerPhone {
//            aCoder.encode(customerPhone, forKey: "customer_phone")
//        }
//        if let message = message {
//            aCoder.encode(message, forKey: "message")
//        }
//        if let points = points {
//            aCoder.encode(points, forKey: "points")
//        }
//        if let prepaidBalance = prepaidBalance {
//            aCoder.encode(prepaidBalance, forKey: "prepaid_balance")
//        }
//        if let result = result {
//            aCoder.encode(result, forKey: "result")
//        }
//        if let success = success {
//            aCoder.encode(success, forKey: "success")
//        }
//        if let timestamp = timestamp {
//            aCoder.encode(timestamp, forKey: "timestamp")
//        }
//        if let totalBalance = totalBalance {
//            aCoder.encode(totalBalance, forKey: "total_balance")
//        }
//
//    }

}
