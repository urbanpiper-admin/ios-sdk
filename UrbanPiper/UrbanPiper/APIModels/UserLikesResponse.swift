//
//	UserLikesResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class UserLikesResponse : NSObject{

	public private(set) var likes : [Like]!
	public private(set) var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		likes = [Like]()
		if let likesArray: [[String:Any]] = dictionary["likes"] as? [[String:Any]]{
			for dic in likesArray{
				let value: Like = Like(fromDictionary: dic)
				likes.append(value)
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
//        var dictionary: [String: Any] = [String:Any]()
//        if likes != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for likesElement in likes {
//                dictionaryElements.append(likesElement.toDictionary())
//            }
//            dictionary["likes"] = dictionaryElements
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
//        if likes != nil{
//            aCoder.encode(likes, forKey: "likes")
//        }
//        if meta != nil{
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }

}
