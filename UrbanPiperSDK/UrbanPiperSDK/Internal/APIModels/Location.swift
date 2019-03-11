//
//	Location.swift
//
//	Create by Vidhyadharan Mohanram on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Location : NSObject{

	public private(set)  var lat : Double!
	public private(set)  var lng : Double!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		lat = dictionary["lat"] as? Double
		lng = dictionary["lng"] as? Double
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if lat != nil{
//            dictionary["lat"] = lat
//        }
//        if lng != nil{
//            dictionary["lng"] = lng
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
//         lat = aDecoder.decodeObject(forKey: "lat") as? Double
//         lng = aDecoder.decodeObject(forKey: "lng") as? Double
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if lat != nil{
//            aCoder.encode(lat, forKey: "lat")
//        }
//        if lng != nil{
//            aCoder.encode(lng, forKey: "lng")
//        }
//
//    }

}
