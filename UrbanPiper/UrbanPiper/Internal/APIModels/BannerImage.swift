//
//	Image.swift
//
//	Create by Vidhyadharan Mohanram on 19/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class BannerImage : NSObject, JSONDecodable{

	public var created : String!
	public var id : Int!
	public var image : String!
	public var imgType : String!
	public var markups : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		created = dictionary["created"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		imgType = dictionary["img_type"] as? String
		markups = dictionary["markups"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let created = created {
//            dictionary["created"] = created as AnyObject
//        }
//        if let id = id {
//            dictionary["id"] = id as AnyObject
//        }
//        if let image = image {
//            dictionary["image"] = image as AnyObject
//        }
//        if let imgType = imgType {
//            dictionary["img_type"] = imgType as AnyObject
//        }
//        if let markups = markups {
//            dictionary["markups"] = markups as AnyObject
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
//         created = aDecoder.decodeObject(forKey: "created") as? String
//         id = aDecoder.decodeInteger(forKey: "id")
//         image = aDecoder.decodeObject(forKey: "image") as? String
//         imgType = aDecoder.decodeObject(forKey: "img_type") as? String
//         markups = aDecoder.decodeObject(forKey: "markups") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let created = created {
//            aCoder.encode(created, forKey: "created")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let image = image {
//            aCoder.encode(image, forKey: "image")
//        }
//        if let imgType = imgType {
//            aCoder.encode(imgType, forKey: "img_type")
//        }
//        if let markups = markups {
//            aCoder.encode(markups, forKey: "markups")
//        }
//
//    }

}
