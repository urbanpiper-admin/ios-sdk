//
//	PaymentInitResponse.swift
//
//	Create by Vidhyadharan Mohanram on 1/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class PaymentInitResponse: NSObject, JSONDecodable {
    public var data: OnlinePaymentData!
    public var message: String!
    public var success: Bool
    public var transactionId: String!
    public var url: AnyObject!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let dataData: [String: AnyObject] = dictionary["data"] as? [String: AnyObject] {
            data = OnlinePaymentData(fromDictionary: dataData)
        }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool ?? false
        transactionId = dictionary["transaction_id"] as? String
        url = dictionary["url"] as AnyObject
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let data = data {
            dictionary["data"] = data.toDictionary() as AnyObject
        }
        if let message = message {
            dictionary["message"] = message as AnyObject
        }

        dictionary["success"] = success as AnyObject

        if let transactionId = transactionId {
            dictionary["transaction_id"] = transactionId as AnyObject
        }
        if let url = url {
            dictionary["url"] = url as AnyObject
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
//         success = val as? Bool ?? false
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
//        if let data = data {
//            aCoder.encode(data, forKey: "data")
//        }
//        if let message = message {
//            aCoder.encode(message, forKey: "message")
//        }
//        if let success = success {
//            aCoder.encode(success, forKey: "success")
//        }
//        if let transactionId = transactionId {
//            aCoder.encode(transactionId, forKey: "transaction_id")
//        }
//        if let url = url {
//            aCoder.encode(url, forKey: "url")
//        }
//
//    }
}
