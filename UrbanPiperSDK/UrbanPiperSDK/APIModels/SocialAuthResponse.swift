//
//  SocialLoginResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 6, 2019

import Foundation


public class SocialLoginResponse : NSObject {//}, NSCoding{

//    public private(set) var authKey : String!
//    public private(set) var biz : AnyObject!
//    public private(set) var email : String!
    public private(set) var message : String!
//    public private(set) var name : String!
//    public private(set) var phone : String!
    public private(set) var success : Bool!
//   var timestamp : String!
    internal var token : String!
//    public private(set) var username : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
//        authKey = dictionary["authKey"] as? String
//        biz = dictionary["biz"] as AnyObject
//        email = dictionary["email"] as? String
        message = dictionary["message"] as? String
//        name = dictionary["name"] as? String
//        phone = dictionary["phone"] as? String
        success = dictionary["success"] as? Bool
//        timestamp = dictionary["timestamp"] as? String
        token = dictionary["token"] as? String
//        username = dictionary["username"] as? String
    }

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if authKey != nil{
//            dictionary["authKey"] = authKey
//        }
//        if biz != nil{
//            dictionary["biz"] = biz
//        }
//        if email != nil{
//            dictionary["email"] = email
//        }
//        if message != nil{
//            dictionary["message"] = message
//        }
//        if name != nil{
//            dictionary["name"] = name
//        }
//        if phone != nil{
//            dictionary["phone"] = phone
//        }
//        if success != nil{
//            dictionary["success"] = success
//        }
//        if timestamp != nil{
//            dictionary["timestamp"] = timestamp
//        }
//        if token != nil{
//            dictionary["token"] = token
//        }
//        if username != nil{
//            dictionary["username"] = username
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
//        success = aDecoder.decodeObject(forKey: "success") as? Bool
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
//        if authKey != nil{
//            aCoder.encode(authKey, forKey: "authKey")
//        }
//        if biz != nil{
//            aCoder.encode(biz, forKey: "biz")
//        }
//        if email != nil{
//            aCoder.encode(email, forKey: "email")
//        }
//        if message != nil{
//            aCoder.encode(message, forKey: "message")
//        }
//        if name != nil{
//            aCoder.encode(name, forKey: "name")
//        }
//        if phone != nil{
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if success != nil{
//            aCoder.encode(success, forKey: "success")
//        }
//        if timestamp != nil{
//            aCoder.encode(timestamp, forKey: "timestamp")
//        }
//        if token != nil{
//            aCoder.encode(token, forKey: "token")
//        }
//        if username != nil{
//            aCoder.encode(username, forKey: "username")
//        }
//    }
}
