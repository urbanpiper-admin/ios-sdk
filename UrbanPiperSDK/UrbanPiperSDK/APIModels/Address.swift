//
//	Address.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Address : NSObject, NSCoding{

	public var address1 : String!
	public var address2 : String!
	public var city : String!
	public var id : Int!
	public var lat : AnyObject!
	public var lng : AnyObject!
	public var pin : String!
	public var podId : AnyObject!
	public var subLocality : String!
	public var tag : String!
    
    public var fullAddress: String? {
        var fullAddress = ""
        if let string = address1 {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = address2 {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = subLocality {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = city {
            fullAddress = "\(fullAddress + string)"
        }
        if let string = pin {
            fullAddress = "\(fullAddress) - \(string)\n"
        }
        guard fullAddress.count > 0 else { return nil }
        return fullAddress
    }


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		address1 = dictionary["address_1"] as? String
		address2 = dictionary["address_2"] as? String
		city = dictionary["city"] as? String
		id = dictionary["id"] as? Int
		lat = dictionary["lat"] as AnyObject
		lng = dictionary["lng"] as AnyObject
		pin = dictionary["pin"] as? String
		podId = dictionary["pod_id"] as AnyObject
		subLocality = dictionary["sub_locality"] as? String
		tag = dictionary["tag"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if address1 != nil{
			dictionary["address_1"] = address1
		}
		if address2 != nil{
			dictionary["address_2"] = address2
		}
		if city != nil{
			dictionary["city"] = city
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lat != nil{
			dictionary["lat"] = lat
		}
		if lng != nil{
			dictionary["lng"] = lng
		}
		if pin != nil{
			dictionary["pin"] = pin
		}
		if podId != nil{
			dictionary["pod_id"] = podId
		}
		if subLocality != nil{
			dictionary["sub_locality"] = subLocality
		}
		if tag != nil{
			dictionary["tag"] = tag
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         address1 = aDecoder.decodeObject(forKey: "address_1") as? String
         address2 = aDecoder.decodeObject(forKey: "address_2") as? String
         city = aDecoder.decodeObject(forKey: "city") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lat = aDecoder.decodeObject(forKey: "lat") as AnyObject
         lng = aDecoder.decodeObject(forKey: "lng") as AnyObject
         pin = aDecoder.decodeObject(forKey: "pin") as? String
         podId = aDecoder.decodeObject(forKey: "pod_id") as AnyObject
         subLocality = aDecoder.decodeObject(forKey: "sub_locality") as? String
         tag = aDecoder.decodeObject(forKey: "tag") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if address1 != nil{
			aCoder.encode(address1, forKey: "address_1")
		}
		if address2 != nil{
			aCoder.encode(address2, forKey: "address_2")
		}
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lat != nil{
			aCoder.encode(lat, forKey: "lat")
		}
		if lng != nil{
			aCoder.encode(lng, forKey: "lng")
		}
		if pin != nil{
			aCoder.encode(pin, forKey: "pin")
		}
		if podId != nil{
			aCoder.encode(podId, forKey: "pod_id")
		}
		if subLocality != nil{
			aCoder.encode(subLocality, forKey: "sub_locality")
		}
		if tag != nil{
			aCoder.encode(tag, forKey: "tag")
		}

	}

}
