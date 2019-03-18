//
//	ItemCategory.swift
//
//	Create by Vidhyadharan Mohanram on 19/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemCategory : NSObject{

	public var id : Int!
	public var name : String!
    public var sortOrder: Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
        sortOrder = dictionary["sort_order"] as? Int ?? 0
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if sortOrder != nil{
            dictionary["sort_order"] = sortOrder
        }
        return dictionary
    }
    
    func equitableCheckDictionary() -> [String: Any] {
        var dictionary: [String:Any] = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
//        if name != nil{
//            dictionary["name"] = name
//        }
//        if sortOrder != nil{
//            dictionary["sort_order"] = sortOrder
//        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         name = aDecoder.decodeObject(forKey: "name") as? String
//        sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if name != nil{
//            aCoder.encode(name, forKey: "name")
//        }
//        if sortOrder != nil{
//            aCoder.encode(id, forKey: "sort_order")
//        }
//
//    }

}

extension ItemCategory {
    static internal func == (lhs: ItemCategory, rhs: ItemCategory) -> Bool {
            return lhs.id  == rhs.id  &&
                lhs.name  == rhs.name &&
                lhs.sortOrder  == rhs.sortOrder
    }
}
