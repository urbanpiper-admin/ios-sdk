//
//	UserLikesResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class UserLikesResponse: NSObject, JSONDecodable {
    public var likes: [Like]!
    public var meta: Meta!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        likes = [Like]()
        if let likesArray: [[String: AnyObject]] = dictionary["likes"] as? [[String: AnyObject]] {
            for dic in likesArray {
                guard let value: Like = Like(fromDictionary: dic) else { continue }
                likes.append(value)
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
//        if let likes = likes {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for likesElement in likes {
//                dictionaryElements.append(likesElement.toDictionary())
//            }
//            dictionary["likes"] = dictionaryElements as AnyObject
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
//         likes = aDecoder.decodeObject(forKey :"likes") as? [Like]
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
//        if let likes = likes {
//            aCoder.encode(likes, forKey: "likes")
//        }
//        if let meta = meta {
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }
}
