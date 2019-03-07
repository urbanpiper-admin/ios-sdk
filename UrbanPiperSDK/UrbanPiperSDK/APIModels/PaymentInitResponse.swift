//
//	PaymentInitResponse.swift
//
//	Create by Vidhyadharan Mohanram on 1/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class PaymentInitResponse : NSObject{

	public private(set)  var data : OnlinePaymentData!
	public private(set)  var message : String!
	public private(set)  var success : Bool!
	public private(set)  var transactionId : String!
	public private(set)  var url : AnyObject!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		if let dataData: [String:Any] = dictionary["data"] as? [String:Any]{
			data = OnlinePaymentData(fromDictionary: dataData)
		}
		message = dictionary["message"] as? String
		success = dictionary["success"] as? Bool
		transactionId = dictionary["transaction_id"] as? String
		url = dictionary["url"] as AnyObject
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if message != nil{
            dictionary["message"] = message
        }
        if success != nil{
            dictionary["success"] = success
        }
        if transactionId != nil{
            dictionary["transaction_id"] = transactionId
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         data = aDecoder.decodeObject(forKey: "data") as? OnlinePaymentData
//         message = aDecoder.decodeObject(forKey: "message") as? String
//         success = aDecoder.decodeObject(forKey: "success") as? Bool
//         transactionId = aDecoder.decodeObject(forKey: "transaction_id") as? String
//         url = aDecoder.decodeObject(forKey: "url") as AnyObject
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if data != nil{
//            aCoder.encode(data, forKey: "data")
//        }
//        if message != nil{
//            aCoder.encode(message, forKey: "message")
//        }
//        if success != nil{
//            aCoder.encode(success, forKey: "success")
//        }
//        if transactionId != nil{
//            aCoder.encode(transactionId, forKey: "transaction_id")
//        }
//        if url != nil{
//            aCoder.encode(url, forKey: "url")
//        }
//
//    }

}
