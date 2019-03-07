//
//	Message.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public enum MessageType: String {
    case info = "info"
    case alert = "alert"
    case promo = "promo"
    case coupon = "coupon"
    case reward = "reward"
    case cashback = "cashback"
}


public class Message : NSObject{

	public private(set)  var bannerImg : String!
	public private(set)  var body : String!
	public private(set)  var channel : String!
	public private(set)  var created : Int!
	public private(set)  var id : Int!
	public private(set)  var target : AnyObject!
	public private(set)  var title : String!
	public private(set)  var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		bannerImg = dictionary["banner_img"] as? String
		body = dictionary["body"] as? String
		channel = dictionary["channel"] as? String
		created = dictionary["created"] as? Int
		id = dictionary["id"] as? Int
		target = dictionary["target"] as AnyObject
		title = dictionary["title"] as? String
		type = dictionary["type"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if bannerImg != nil{
//            dictionary["banner_img"] = bannerImg
//        }
//        if body != nil{
//            dictionary["body"] = body
//        }
//        if channel != nil{
//            dictionary["channel"] = channel
//        }
//        if created != nil{
//            dictionary["created"] = created
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if target != nil{
//            dictionary["target"] = target
//        }
//        if title != nil{
//            dictionary["title"] = title
//        }
//        if type != nil{
//            dictionary["type"] = type
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
//         bannerImg = aDecoder.decodeObject(forKey: "banner_img") as? String
//         body = aDecoder.decodeObject(forKey: "body") as? String
//         channel = aDecoder.decodeObject(forKey: "channel") as? String
//         created = aDecoder.decodeObject(forKey: "created") as? Int
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         target = aDecoder.decodeObject(forKey: "target") as AnyObject
//         title = aDecoder.decodeObject(forKey: "title") as? String
//         type = aDecoder.decodeObject(forKey: "type") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if bannerImg != nil{
//            aCoder.encode(bannerImg, forKey: "banner_img")
//        }
//        if body != nil{
//            aCoder.encode(body, forKey: "body")
//        }
//        if channel != nil{
//            aCoder.encode(channel, forKey: "channel")
//        }
//        if created != nil{
//            aCoder.encode(created, forKey: "created")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if target != nil{
//            aCoder.encode(target, forKey: "target")
//        }
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
//        if type != nil{
//            aCoder.encode(type, forKey: "type")
//        }
//
//    }

}
