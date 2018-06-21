//
//	MyOrderObject.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class MyOrderObject : NSObject, NSCoding{

	public var body : String!
	public var detail : String!
	public var extras : MyOrderExtra!
	public var subject : String!
	public var time : Int!
	public var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		body = dictionary["body"] as? String
		detail = dictionary["detail"] as? String
		if let extrasData = dictionary["extras"] as? [String:Any]{
			extras = MyOrderExtra(fromDictionary: extrasData)
		}
		subject = dictionary["subject"] as? String
		time = dictionary["time"] as? Int
		type = dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if body != nil{
			dictionary["body"] = body
		}
		if detail != nil{
			dictionary["detail"] = detail
		}
		if extras != nil{
			dictionary["extras"] = extras.toDictionary()
		}
		if subject != nil{
			dictionary["subject"] = subject
		}
		if time != nil{
			dictionary["time"] = time
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         body = aDecoder.decodeObject(forKey: "body") as? String
         detail = aDecoder.decodeObject(forKey: "detail") as? String
         extras = aDecoder.decodeObject(forKey: "extras") as? MyOrderExtra
         subject = aDecoder.decodeObject(forKey: "subject") as? String
         time = aDecoder.decodeObject(forKey: "time") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if body != nil{
			aCoder.encode(body, forKey: "body")
		}
		if detail != nil{
			aCoder.encode(detail, forKey: "detail")
		}
		if extras != nil{
			aCoder.encode(extras, forKey: "extras")
		}
		if subject != nil{
			aCoder.encode(subject, forKey: "subject")
		}
		if time != nil{
			aCoder.encode(time, forKey: "time")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}
