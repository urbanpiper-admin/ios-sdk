//
//	Image.swift
//
//	Create by Vidhyadharan Mohanram on 19/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class BannerImage : NSObject{

	public private(set)  var created : String!
	public private(set)  var id : Int!
	public private(set)  var image : String!
	public private(set)  var imgType : String!
	public private(set)  var markups : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		created = dictionary["created"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		imgType = dictionary["img_type"] as? String
		markups = dictionary["markups"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if created != nil{
//            dictionary["created"] = created
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if image != nil{
//            dictionary["image"] = image
//        }
//        if imgType != nil{
//            dictionary["img_type"] = imgType
//        }
//        if markups != nil{
//            dictionary["markups"] = markups
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
//         id = aDecoder.decodeObject(forKey: "id") as? Int
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
//        if created != nil{
//            aCoder.encode(created, forKey: "created")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if image != nil{
//            aCoder.encode(image, forKey: "image")
//        }
//        if imgType != nil{
//            aCoder.encode(imgType, forKey: "img_type")
//        }
//        if markups != nil{
//            aCoder.encode(markups, forKey: "markups")
//        }
//
//    }

}
