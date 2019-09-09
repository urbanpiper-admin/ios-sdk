//
//	LoginResponse.swift
//
//	Create by Vidhyadharan Mohanram on 11/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class LoginResponse : NSObject, JSONDecodable{//}, NSCoding {
    
    @objc public var message : String?

    public var status: String?

    internal var token: String?

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    @objc internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        super.init()
        message = dictionary["message"] as? String
        status = dictionary["status"] as? String
        token = dictionary["token"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let message = message {
            dictionary["message"] = message as AnyObject
        }
        if let status = status {
            dictionary["status"] = status as AnyObject
        }
        if let token = token {
            dictionary["token"] = token as AnyObject
        }
        
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         message = aDecoder.decodeObject(forKey: "message") as? String
//        status = aDecoder.decodeObject(forKey: "status") as? String
//         token = aDecoder.decodeObject(forKey: "token") as? String
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let message = message {
//            aCoder.encode(message, forKey: "message")
//        }
//        if let status = status {
//            aCoder.encode(status, forKey: "status")
//        }
//        if let token = token {
//            aCoder.encode(token, forKey: "token")
//        }
//    }

}
