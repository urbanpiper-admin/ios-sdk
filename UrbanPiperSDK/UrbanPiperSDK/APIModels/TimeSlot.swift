//
//	TimeSlot.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class TimeSlot : NSObject, NSCoding{

	public var day : String!
	public var endTime : String!
	public var startTime : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		day = dictionary["day"] as? String
		endTime = dictionary["end_time"] as? String
		startTime = dictionary["start_time"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if day != nil{
			dictionary["day"] = day
		}
		if endTime != nil{
			dictionary["end_time"] = endTime
		}
		if startTime != nil{
			dictionary["start_time"] = startTime
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         day = aDecoder.decodeObject(forKey: "day") as? String
         endTime = aDecoder.decodeObject(forKey: "end_time") as? String
         startTime = aDecoder.decodeObject(forKey: "start_time") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if day != nil{
			aCoder.encode(day, forKey: "day")
		}
		if endTime != nil{
			aCoder.encode(endTime, forKey: "end_time")
		}
		if startTime != nil{
			aCoder.encode(startTime, forKey: "start_time")
		}

	}

}
