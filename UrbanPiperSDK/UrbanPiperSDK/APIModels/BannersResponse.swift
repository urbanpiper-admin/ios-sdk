//
//	BannersResponse.swift
//
//	Create by Vidhyadharan Mohanram on 19/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class BannersResponse : NSObject{

	public var images : [BannerImage]!
	public var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		images = [BannerImage]()
		if let imagesArray: [[String:Any]] = dictionary["images"] as? [[String:Any]]{
			for dic in imagesArray{
				let value: BannerImage = BannerImage(fromDictionary: dic)
				images.append(value)
			}
		}
		if let metaData: [String:Any] = dictionary["meta"] as? [String:Any]{
			meta = Meta(fromDictionary: metaData)
		}
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if images != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for imagesElement in images {
//                dictionaryElements.append(imagesElement.toDictionary())
//            }
//            dictionary["images"] = dictionaryElements
//        }
//        if meta != nil{
//            dictionary["meta"] = meta.toDictionary()
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
//         images = aDecoder.decodeObject(forKey :"images") as? [Image]
//         meta = aDecoder.decodeObject(forKey: "meta") as? Meta
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if images != nil{
//            aCoder.encode(images, forKey: "images")
//        }
//        if meta != nil{
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }

}
