//
//	LoginResponse.swift
//
//	Create by Vidhyadharan Mohanram on 11/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class LoginResponse : NSObject{//}, NSCoding {
    
    @objc public internal(set) var message : String?

    public internal(set) var status: String?

    internal var token: String?

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    @objc internal init(fromDictionary dictionary:  [String:Any]){
        super.init()
        message = dictionary["message"] as? String
        status = dictionary["status"] as? String
        token = dictionary["token"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        if token != nil{
            dictionary["token"] = token
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
//        if message != nil{
//            aCoder.encode(message, forKey: "message")
//        }
//        if status != nil{
//            aCoder.encode(status, forKey: "status")
//        }
//        if token != nil{
//            aCoder.encode(token, forKey: "token")
//        }
//    }

}
