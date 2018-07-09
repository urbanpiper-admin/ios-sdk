//
//	Meta.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Meta : NSObject, NSCoding{

	public var limit : Int!
	public var next : String!
	public var offset : Int!
	public var previous : String!
	public var totalCount : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		limit = dictionary["limit"] as? Int
		next = dictionary["next"] as? String
		offset = dictionary["offset"] as? Int
		previous = dictionary["previous"] as? String
		totalCount = dictionary["total_count"] as? Int
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if limit != nil{
//            dictionary["limit"] = limit
//        }
//        if next != nil{
//            dictionary["next"] = next
//        }
//        if offset != nil{
//            dictionary["offset"] = offset
//        }
//        if previous != nil{
//            dictionary["previous"] = previous
//        }
//        if totalCount != nil{
//            dictionary["total_count"] = totalCount
//        }
//        return dictionary
//    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         limit = aDecoder.decodeObject(forKey: "limit") as? Int
         next = aDecoder.decodeObject(forKey: "next") as? String
         offset = aDecoder.decodeObject(forKey: "offset") as? Int
         previous = aDecoder.decodeObject(forKey: "previous") as? String
         totalCount = aDecoder.decodeObject(forKey: "total_count") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if limit != nil{
			aCoder.encode(limit, forKey: "limit")
		}
		if next != nil{
			aCoder.encode(next, forKey: "next")
		}
		if offset != nil{
			aCoder.encode(offset, forKey: "offset")
		}
		if previous != nil{
			aCoder.encode(previous, forKey: "previous")
		}
		if totalCount != nil{
			aCoder.encode(totalCount, forKey: "total_count")
		}

	}

}
