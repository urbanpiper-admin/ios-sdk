//
//	Like.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Like : NSObject, JSONDecodable{

	public var item : Item!
	public var likedOn : Int?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		if let itemData: [String : AnyObject] = dictionary["item"] as? [String : AnyObject]{
			item = Item(fromDictionary: itemData)
		}
		likedOn = dictionary["liked_on"] as? Int
	}

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let item = item {
//            dictionary["item"] = item.toDictionary() as AnyObject
//        }
//        if let likedOn = likedOn {
//            dictionary["liked_on"] = likedOn as AnyObject
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
//         item = aDecoder.decodeObject(forKey: "item") as? Item
//         likedOn = aDecoder.decodeObject(forKey: "liked_on") as? Int
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let item = item {
//            aCoder.encode(item, forKey: "item")
//        }
//        if let likedOn = likedOn {
//            aCoder.encode(likedOn, forKey: "liked_on")
//        }
//
//    }

}
