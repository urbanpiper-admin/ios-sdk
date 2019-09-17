//
//	BizLocation.swift
//
//	Create by Vidhyadharan Mohanram on 19/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class BizLocation : NSObject, JSONDecodable{

	public var address : String!
	public var bizLocationId : Int?
	public var city : String!
    public var closingDay : Bool
	public var closingTime : AnyObject!
//    public var deliveryCharge : Float!
	public var deliveryMinOffsetTime : Int?
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
	public var pickupMinOffsetTime : Int?
	public var sortOrder : Int?
//    public var taxRate : Float!
    public var temporarilyClosed : Bool
	public var timeSlots : [AnyObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
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
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let address = address {
            dictionary["address"] = address as AnyObject
        }
        if let bizLocationId = bizLocationId {
            dictionary["biz_location_id"] = bizLocationId as AnyObject
        }
        if let city = city {
            dictionary["city"] = city as AnyObject
        }
        dictionary["closing_day"] = closingDay as AnyObject
        if let closingTime = closingTime {
            dictionary["closing_time"] = closingTime as AnyObject
        }
//        if let deliveryCharge = deliveryCharge {
//            dictionary["delivery_charge"] = deliveryCharge as AnyObject
//        }
        if let deliveryMinOffsetTime = deliveryMinOffsetTime {
            dictionary["delivery_min_offset_time"] = deliveryMinOffsetTime as AnyObject
        }
        dictionary["hide_store_name"] = hideStoreName as AnyObject
        if let lat = lat {
            dictionary["lat"] = lat as AnyObject
        }
        if let lng = lng {
            dictionary["lng"] = lng as AnyObject
        }
//        if let minOrderTotal = minOrderTotal {
//            dictionary["min_order_total"] = minOrderTotal as AnyObject
//        }
        if let name = name {
            dictionary["name"] = name as AnyObject
        }
        if let onCloseMsg = onCloseMsg {
            dictionary["on_close_msg"] = onCloseMsg as AnyObject
        }
        if let onSelectMsg = onSelectMsg {
            dictionary["on_select_msg"] = onSelectMsg as AnyObject
        }
        if let openingTime = openingTime {
            dictionary["opening_time"] = openingTime as AnyObject
        }
//        if let packagingCharge = packagingCharge {
//            dictionary["packaging_charge"] = packagingCharge as AnyObject
//        }
        if let pgKey = pgKey {
            dictionary["pg_key"] = pgKey as AnyObject
        }
        if let phone = phone {
            dictionary["phone"] = phone as AnyObject
        }
        if let pickupMinOffsetTime = pickupMinOffsetTime {
            dictionary["pickup_min_offset_time"] = pickupMinOffsetTime as AnyObject
        }
        if let sortOrder = sortOrder {
            dictionary["sort_order"] = sortOrder as AnyObject
        }
//        if let taxRate = taxRate {
//            dictionary["tax_rate"] = taxRate as AnyObject
//        }
        dictionary["temporarily_closed"] = temporarilyClosed as AnyObject
        if let timeSlots = timeSlots {
            dictionary["time_slots"] = timeSlots as AnyObject
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
//        if let address = address {
//            aCoder.encode(address, forKey: "address")
//        }
//        if let bizLocationId = bizLocationId {
//            aCoder.encode(bizLocationId, forKey: "biz_location_id")
//        }
//        if let city = city {
//            aCoder.encode(city, forKey: "city")
//        }
//        if let closingDay = closingDay {
//            aCoder.encode(closingDay, forKey: "closing_day")
//        }
//        if let closingTime = closingTime {
//            aCoder.encode(closingTime, forKey: "closing_time")
//        }
//        if let deliveryCharge = deliveryCharge {
//            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
//        }
//        if let deliveryMinOffsetTime = deliveryMinOffsetTime {
//            aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
//        }
//        if let hideStoreName = hideStoreName {
//            aCoder.encode(hideStoreName, forKey: "hide_store_name")
//        }
//        if let lat = lat {
//            aCoder.encode(lat, forKey: "lat")
//        }
//        if let lng = lng {
//            aCoder.encode(lng, forKey: "lng")
//        }
//        if let minOrderTotal = minOrderTotal {
//            aCoder.encode(minOrderTotal, forKey: "min_order_total")
//        }
//        if let name = name {
//            aCoder.encode(name, forKey: "name")
//        }
//        if let onCloseMsg = onCloseMsg {
//            aCoder.encode(onCloseMsg, forKey: "on_close_msg")
//        }
//        if let onSelectMsg = onSelectMsg {
//            aCoder.encode(onSelectMsg, forKey: "on_select_msg")
//        }
//        if let openingTime = openingTime {
//            aCoder.encode(openingTime, forKey: "opening_time")
//        }
//        if let packagingCharge = packagingCharge {
//            aCoder.encode(packagingCharge, forKey: "packaging_charge")
//        }
//        if let pgKey = pgKey {
//            aCoder.encode(pgKey, forKey: "pg_key")
//        }
//        if let phone = phone {
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if let pickupMinOffsetTime = pickupMinOffsetTime {
//            aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
//        }
//        if let sortOrder = sortOrder {
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if let taxRate = taxRate {
//            aCoder.encode(taxRate, forKey: "tax_rate")
//        }
//        if let temporarilyClosed = temporarilyClosed {
//            aCoder.encode(temporarilyClosed, forKey: "temporarily_closed")
//        }
//        if let timeSlots = timeSlots {
//            aCoder.encode(timeSlots, forKey: "time_slots")
//        }
//
//    }

}
