//
//	BizLocation.swift
//
//	Create by Vidhyadharan Mohanram on 19/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class BizLocation : NSObject{

	public var address : String!
	public var bizLocationId : Int!
	public var city : String!
    public var closingDay : Bool
	public var closingTime : AnyObject!
//    public var deliveryCharge : Float!
	public var deliveryMinOffsetTime : Int!
    public var hideStoreName : Bool
	public var lat : Double!
	public var lng : Double!
//    public var minOrderTotal : Float!
	public var name : String!
	public var onCloseMsg : String!
	public var onSelectMsg : AnyObject!
	public var openingTime : AnyObject!
//    public var packagingCharge : Float!
	public var pgKey : String!
	public var phone : String!
	public var pickupMinOffsetTime : Int!
	public var sortOrder : Int!
//    public var taxRate : Float!
    public var temporarilyClosed : Bool
	public var timeSlots : [AnyObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		address = dictionary["address"] as? String
		bizLocationId = dictionary["biz_location_id"] as? Int
		city = dictionary["city"] as? String
		closingDay = dictionary["closing_day"] as? Bool ?? false
		closingTime = dictionary["closing_time"] as AnyObject
//        deliveryCharge = dictionary["delivery_charge"] as? Float
		deliveryMinOffsetTime = dictionary["delivery_min_offset_time"] as? Int
		hideStoreName = dictionary["hide_store_name"] as? Bool ?? false
		lat = dictionary["lat"] as? Double
		lng = dictionary["lng"] as? Double
//        minOrderTotal = dictionary["min_order_total"] as? Float
		name = dictionary["name"] as? String
		onCloseMsg = dictionary["on_close_msg"] as? String
		onSelectMsg = dictionary["on_select_msg"] as AnyObject
		openingTime = dictionary["opening_time"] as AnyObject
//        packagingCharge = dictionary["packaging_charge"] as? Float
		pgKey = dictionary["pg_key"] as? String
		phone = dictionary["phone"] as? String
		pickupMinOffsetTime = dictionary["pickup_min_offset_time"] as? Int
		sortOrder = dictionary["sort_order"] as? Int
//        taxRate = dictionary["tax_rate"] as? Float
		temporarilyClosed = dictionary["temporarily_closed"] as? Bool ?? false
		timeSlots = dictionary["time_slots"] as? [AnyObject]
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if bizLocationId != nil{
            dictionary["biz_location_id"] = bizLocationId
        }
        if city != nil{
            dictionary["city"] = city
        }
        if closingDay != nil{
            dictionary["closing_day"] = closingDay
        }
        if closingTime != nil{
            dictionary["closing_time"] = closingTime
        }
//        if deliveryCharge != nil{
//            dictionary["delivery_charge"] = deliveryCharge
//        }
        if deliveryMinOffsetTime != nil{
            dictionary["delivery_min_offset_time"] = deliveryMinOffsetTime
        }
        if hideStoreName != nil{
            dictionary["hide_store_name"] = hideStoreName
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if lng != nil{
            dictionary["lng"] = lng
        }
//        if minOrderTotal != nil{
//            dictionary["min_order_total"] = minOrderTotal
//        }
        if name != nil{
            dictionary["name"] = name
        }
        if onCloseMsg != nil{
            dictionary["on_close_msg"] = onCloseMsg
        }
        if onSelectMsg != nil{
            dictionary["on_select_msg"] = onSelectMsg
        }
        if openingTime != nil{
            dictionary["opening_time"] = openingTime
        }
//        if packagingCharge != nil{
//            dictionary["packaging_charge"] = packagingCharge
//        }
        if pgKey != nil{
            dictionary["pg_key"] = pgKey
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if pickupMinOffsetTime != nil{
            dictionary["pickup_min_offset_time"] = pickupMinOffsetTime
        }
        if sortOrder != nil{
            dictionary["sort_order"] = sortOrder
        }
//        if taxRate != nil{
//            dictionary["tax_rate"] = taxRate
//        }
        if temporarilyClosed != nil{
            dictionary["temporarily_closed"] = temporarilyClosed
        }
        if timeSlots != nil{
            dictionary["time_slots"] = timeSlots
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         address = aDecoder.decodeObject(forKey: "address") as? String
//         bizLocationId = aDecoder.decodeObject(forKey: "biz_location_id") as? Int
//         city = aDecoder.decodeObject(forKey: "city") as? String
//         closingDay = val as? Bool ?? false
//         closingTime = aDecoder.decodeObject(forKey: "closing_time") as AnyObject
//         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? Float
//         deliveryMinOffsetTime = aDecoder.decodeObject(forKey: "delivery_min_offset_time") as? Int
//         hideStoreName = val as? Bool ?? false
//         lat = aDecoder.decodeObject(forKey: "lat") as? Double
//         lng = aDecoder.decodeObject(forKey: "lng") as? Double
//         minOrderTotal = aDecoder.decodeObject(forKey: "min_order_total") as? Float
//         name = aDecoder.decodeObject(forKey: "name") as? String
//         onCloseMsg = aDecoder.decodeObject(forKey: "on_close_msg") as? String
//         onSelectMsg = aDecoder.decodeObject(forKey: "on_select_msg") as AnyObject
//         openingTime = aDecoder.decodeObject(forKey: "opening_time") as AnyObject
//         packagingCharge = aDecoder.decodeObject(forKey: "packaging_charge") as? Float
//         pgKey = aDecoder.decodeObject(forKey: "pg_key") as? String
//         phone = aDecoder.decodeObject(forKey: "phone") as? String
//         pickupMinOffsetTime = aDecoder.decodeObject(forKey: "pickup_min_offset_time") as? Int
//         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
//         taxRate = aDecoder.decodeObject(forKey: "tax_rate") as? Float
//         temporarilyClosed = val as? Bool ?? false
//         timeSlots = aDecoder.decodeObject(forKey: "time_slots") as? [AnyObject]
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if address != nil{
//            aCoder.encode(address, forKey: "address")
//        }
//        if bizLocationId != nil{
//            aCoder.encode(bizLocationId, forKey: "biz_location_id")
//        }
//        if city != nil{
//            aCoder.encode(city, forKey: "city")
//        }
//        if closingDay != nil{
//            aCoder.encode(closingDay, forKey: "closing_day")
//        }
//        if closingTime != nil{
//            aCoder.encode(closingTime, forKey: "closing_time")
//        }
//        if deliveryCharge != nil{
//            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
//        }
//        if deliveryMinOffsetTime != nil{
//            aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
//        }
//        if hideStoreName != nil{
//            aCoder.encode(hideStoreName, forKey: "hide_store_name")
//        }
//        if lat != nil{
//            aCoder.encode(lat, forKey: "lat")
//        }
//        if lng != nil{
//            aCoder.encode(lng, forKey: "lng")
//        }
//        if minOrderTotal != nil{
//            aCoder.encode(minOrderTotal, forKey: "min_order_total")
//        }
//        if name != nil{
//            aCoder.encode(name, forKey: "name")
//        }
//        if onCloseMsg != nil{
//            aCoder.encode(onCloseMsg, forKey: "on_close_msg")
//        }
//        if onSelectMsg != nil{
//            aCoder.encode(onSelectMsg, forKey: "on_select_msg")
//        }
//        if openingTime != nil{
//            aCoder.encode(openingTime, forKey: "opening_time")
//        }
//        if packagingCharge != nil{
//            aCoder.encode(packagingCharge, forKey: "packaging_charge")
//        }
//        if pgKey != nil{
//            aCoder.encode(pgKey, forKey: "pg_key")
//        }
//        if phone != nil{
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if pickupMinOffsetTime != nil{
//            aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
//        }
//        if sortOrder != nil{
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if taxRate != nil{
//            aCoder.encode(taxRate, forKey: "tax_rate")
//        }
//        if temporarilyClosed != nil{
//            aCoder.encode(temporarilyClosed, forKey: "temporarily_closed")
//        }
//        if timeSlots != nil{
//            aCoder.encode(timeSlots, forKey: "time_slots")
//        }
//
//    }

}
