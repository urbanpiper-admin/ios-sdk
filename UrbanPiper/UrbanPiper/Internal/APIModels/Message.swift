//
//	Message.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public enum MessageType: String {
    case info
    case alert
    case promo
    case coupon
    case reward
    case cashback
}

public class Message: NSObject, JSONDecodable {
    public var bannerImg: String!
    public var body: String!
    public var channel: String!
    public var created: Int = 0
    public var id: Int = 0
    public var target: AnyObject!
    public var title: String!
    public var type: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        bannerImg = dictionary["banner_img"] as? String
        body = dictionary["body"] as? String
        channel = dictionary["channel"] as? String
        created = dictionary["created"] as? Int ?? 0
        id = dictionary["id"] as? Int ?? 0
        target = dictionary["target"] as AnyObject
        title = dictionary["title"] as? String
        type = dictionary["type"] as? String
    }

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let bannerImg = bannerImg {
//            dictionary["banner_img"] = bannerImg as AnyObject
//        }
//        if let body = body {
//            dictionary["body"] = body as AnyObject
//        }
//        if let channel = channel {
//            dictionary["channel"] = channel as AnyObject
//        }
//        if let created = created {
//            dictionary["created"] = created as AnyObject
//        }
//        if let id = id {
//            dictionary["id"] = id as AnyObject
//        }
//        if let target = target {
//            dictionary["target"] = target as AnyObject
//        }
//        if let title = title {
//            dictionary["title"] = title as AnyObject
//        }
//        if let type = type {
//            dictionary["type"] = type as AnyObject
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
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
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
//        if let bannerImg = bannerImg {
//            aCoder.encode(bannerImg, forKey: "banner_img")
//        }
//        if let body = body {
//            aCoder.encode(body, forKey: "body")
//        }
//        if let channel = channel {
//            aCoder.encode(channel, forKey: "channel")
//        }
//        if let created = created {
//            aCoder.encode(created, forKey: "created")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let target = target {
//            aCoder.encode(target, forKey: "target")
//        }
//        if let title = title {
//            aCoder.encode(title, forKey: "title")
//        }
//        if let type = type {
//            aCoder.encode(type, forKey: "type")
//        }
//
//    }
}
