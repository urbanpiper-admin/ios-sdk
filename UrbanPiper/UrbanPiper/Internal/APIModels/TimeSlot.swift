//
//	TimeSlot.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class TimeSlot: NSObject, JSONDecodable, NSCoding {
    public var day: String!
    public var endTime: String!
    public var startTime: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        day = dictionary["day"] as? String
        endTime = dictionary["end_time"] as? String
        startTime = dictionary["start_time"] as? String
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let day = day {
            dictionary["day"] = day as AnyObject
        }
        if let endTime = endTime {
            dictionary["end_time"] = endTime as AnyObject
        }
        if let startTime = startTime {
            dictionary["start_time"] = startTime as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        day = aDecoder.decodeObject(forKey: "day") as? String
        endTime = aDecoder.decodeObject(forKey: "end_time") as? String
        startTime = aDecoder.decodeObject(forKey: "start_time") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if let day = day {
            aCoder.encode(day, forKey: "day")
        }
        if let endTime = endTime {
            aCoder.encode(endTime, forKey: "end_time")
        }
        if let startTime = startTime {
            aCoder.encode(startTime, forKey: "start_time")
        }
    }
}
