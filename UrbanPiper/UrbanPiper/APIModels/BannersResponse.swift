//
//	BannersResponse.swift
//
//	Create by Vidhyadharan Mohanram on 19/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class BannersResponse: NSObject, JSONDecodable {
    public var images: [BannerImage]!
    public var meta: Meta!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        images = [BannerImage]()
        if let imagesArray: [[String: AnyObject]] = dictionary["images"] as? [[String: AnyObject]] {
            for dic in imagesArray {
                guard let value: BannerImage = BannerImage(fromDictionary: dic) else { continue }
                images.append(value)
            }
        }
        if let metaData: [String: AnyObject] = dictionary["meta"] as? [String: AnyObject] {
            meta = Meta(fromDictionary: metaData)
        }
    }

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let images = images {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for imagesElement in images {
//                dictionaryElements.append(imagesElement.toDictionary())
//            }
//            dictionary["images"] = dictionaryElements as AnyObject
//        }
//        if let meta = meta {
//            dictionary["meta"] = meta.toDictionary() as AnyObject
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
//        if let images = images {
//            aCoder.encode(images, forKey: "images")
//        }
//        if let meta = meta {
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }
}
