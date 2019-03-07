//
//	Like.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Like : NSObject{

	public private(set)  var item : Item!
	public private(set)  var likedOn : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		if let itemData: [String:Any] = dictionary["item"] as? [String:Any]{
			item = Item(fromDictionary: itemData)
		}
		likedOn = dictionary["liked_on"] as? Int
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if item != nil{
//            dictionary["item"] = item.toDictionary()
//        }
//        if likedOn != nil{
//            dictionary["liked_on"] = likedOn
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
//        if item != nil{
//            aCoder.encode(item, forKey: "item")
//        }
//        if likedOn != nil{
//            aCoder.encode(likedOn, forKey: "liked_on")
//        }
//
//    }

}
