//
//	MatchedSubstring.swift
//
//	Create by Vidhyadharan Mohanram on 10/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class MatchedSubstring : NSObject, NSCoding{

	public private(set)  var length : Int!
	public private(set)  var offset : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		length = dictionary["length"] as? Int
		offset = dictionary["offset"] as? Int
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if length != nil{
//            dictionary["length"] = length
//        }
//        if offset != nil{
//            dictionary["offset"] = offset
//        }
//        return dictionary
//    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         length = aDecoder.decodeObject(forKey: "length") as? Int
         offset = aDecoder.decodeObject(forKey: "offset") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if length != nil{
			aCoder.encode(length, forKey: "length")
		}
		if offset != nil{
			aCoder.encode(offset, forKey: "offset")
		}

	}

}
