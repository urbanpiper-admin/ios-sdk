//
//  SocialLoginResponse.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on February 6, 2019

import Foundation

public class SocialLoginResponse: NSObject, JSONDecodable { // }, NSCoding{
//    vcvvgvc var authKey : String!
//    public var biz : AnyObject!
    public var email : String!
    public var message: String!
    public var name : String!
    public var phone: String!
    public var success: Bool
    //   var timestamp : String!
    internal var token: String!
//    public var username : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
//        authKey = dictionary["authKey"] as? String
//        biz = dictionary["biz"] as AnyObject
        email = dictionary["email"] as? String
        message = dictionary["message"] as? String
        name = dictionary["name"] as? String
        phone = dictionary["phone"] as? String
        success = dictionary["success"] as? Bool ?? false
//        timestamp = dictionary["timestamp"] as? String
        token = dictionary["token"] as? String
//        username = dictionary["username"] as? String
    }

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary = [String : AnyObject]()
//        if let authKey = authKey {
//            dictionary["authKey"] = authKey as AnyObject
//        }
//        if let biz = biz {
//            dictionary["biz"] = biz as AnyObject
//        }
//        if let email = email {
//            dictionary["email"] = email as AnyObject
//        }
//        if let message = message {
//            dictionary["message"] = message as AnyObject
//        }
//        if let name = name {
//            dictionary["name"] = name as AnyObject
//        }
//        if let phone = phone {
//            dictionary["phone"] = phone as AnyObject
//        }
//        if let success = success {
//            dictionary["success"] = success as AnyObject
//        }
//        if let timestamp = timestamp {
//            dictionary["timestamp"] = timestamp as AnyObject
//        }
//        if let token = token {
//            dictionary["token"] = token as AnyObject
//        }
//        if let username = username {
//            dictionary["username"] = username as AnyObject
//        }
//        return dictionary
//    }
//
//    /**
//     * NSCoding required initializer.
//     * Fills the data from the passed decoder
//     */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//        authKey = aDecoder.decodeObject(forKey: "authKey") as? String
//        biz = aDecoder.decodeObject(forKey: "biz") as AnyObject
//        email = aDecoder.decodeObject(forKey: "email") as? String
//        message = aDecoder.decodeObject(forKey: "message") as? String
//        name = aDecoder.decodeObject(forKey: "name") as? String
//        phone = aDecoder.decodeObject(forKey: "phone") as? String
//        success = aDecoder.decodeBool(forKey: "success")
//        timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
//        token = aDecoder.decodeObject(forKey: "token") as? String
//        username = aDecoder.decodeObject(forKey: "username") as? String
//    }
//
//    /**
//     * NSCoding required method.
//     * Encodes mode properties into the decoder
//     */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let authKey = authKey {
//            aCoder.encode(authKey, forKey: "authKey")
//        }
//        if let biz = biz {
//            aCoder.encode(biz, forKey: "biz")
//        }
//        if let email = email {
//            aCoder.encode(email, forKey: "email")
//        }
//        if let message = message {
//            aCoder.encode(message, forKey: "message")
//        }
//        if let name = name {
//            aCoder.encode(name, forKey: "name")
//        }
//        if let phone = phone {
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if let success = success {
//            aCoder.encode(success, forKey: "success")
//        }
//        if let timestamp = timestamp {
//            aCoder.encode(timestamp, forKey: "timestamp")
//        }
//        if let token = token {
//            aCoder.encode(token, forKey: "token")
//        }
//        if let username = username {
//            aCoder.encode(username, forKey: "username")
//        }
//    }
}
