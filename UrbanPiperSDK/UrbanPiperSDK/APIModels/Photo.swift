//
//	Photo.swift
//
//	Create by Vidhyadharan Mohanram on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Photo : NSObject{

	public private(set)  var height : Int!
	public private(set)  var htmlAttributions : [String]!
	public private(set)  var photoReference : String!
	public private(set)  var width : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		height = dictionary["height"] as? Int
		htmlAttributions = dictionary["html_attributions"] as? [String]
		photoReference = dictionary["photo_reference"] as? String
		width = dictionary["width"] as? Int
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if height != nil{
//            dictionary["height"] = height
//        }
//        if htmlAttributions != nil{
//            dictionary["html_attributions"] = htmlAttributions
//        }
//        if photoReference != nil{
//            dictionary["photo_reference"] = photoReference
//        }
//        if width != nil{
//            dictionary["width"] = width
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
//         height = aDecoder.decodeObject(forKey: "height") as? Int
//         htmlAttributions = aDecoder.decodeObject(forKey: "html_attributions") as? [String]
//         photoReference = aDecoder.decodeObject(forKey: "photo_reference") as? String
//         width = aDecoder.decodeObject(forKey: "width") as? Int
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if height != nil{
//            aCoder.encode(height, forKey: "height")
//        }
//        if htmlAttributions != nil{
//            aCoder.encode(htmlAttributions, forKey: "html_attributions")
//        }
//        if photoReference != nil{
//            aCoder.encode(photoReference, forKey: "photo_reference")
//        }
//        if width != nil{
//            aCoder.encode(width, forKey: "width")
//        }
//
//    }

}
