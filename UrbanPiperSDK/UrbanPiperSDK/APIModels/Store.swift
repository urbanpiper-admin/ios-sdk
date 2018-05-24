//
//	Store.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Store : NSObject, NSCoding{

	public var address : String!
	public var bizLocationId : Int!
	public var city : String!
	public var closingDay : Bool!
	public var closingTime : String!
	public var deliveryCharge : Decimal!
	public var deliveryMinOffsetTime : Int!
    public var discount : Decimal!
	public var hideStoreName : Bool!
    public var itemTaxes : Decimal!
	public var lat : Float!
	public var lng : Float!
	public var minOrderTotal : Decimal!
	@objc public var name : String!
	public var onCloseMsg : String!
	public var onSelectMsg : String!
	public var openingTime : String!
	public var packagingCharge : Decimal!
	public var pgKey : String!
	public var phone : String!
	public var pickupMinOffsetTime : Int!
	public var sortOrder : Int!
	public var taxRate : Float!
	public var temporarilyClosed : Bool!
	public var timeSlots : [AnyObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		address = dictionary["address"] as? String
		bizLocationId = dictionary["biz_location_id"] as? Int
		city = dictionary["city"] as? String
		closingDay = dictionary["closing_day"] as? Bool
		closingTime = dictionary["closing_time"] as? String
        
        var priceVal = dictionary["delivery_charge"]
        if let val = priceVal as? Decimal {
            print("decimal amount value \(val)")
            deliveryCharge = val
        } else if let val = priceVal as? Double {
            print("double amount value \(val)")
            deliveryCharge = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: deliveryCharge).doubleValue))")
        } else if let val = priceVal as? Float {
            deliveryCharge = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = priceVal as? Int {
            print("int amount value \(val)")
            deliveryCharge = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: deliveryCharge).doubleValue))")
        } else {
            deliveryCharge = Decimal(0).rounded
            print("amount value nil")
        }
        
        deliveryMinOffsetTime = dictionary["delivery_min_offset_time"] as? Int
        
        priceVal = dictionary["discount"]
        if let val = priceVal as? Decimal {
            print("decimal amount value \(val)")
            discount = val
        } else if let val = priceVal as? Double {
            print("double amount value \(val)")
            discount = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: discount).doubleValue))")
        } else if let val = priceVal as? Float {
            discount = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = priceVal as? Int {
            print("int amount value \(val)")
            discount = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: discount).doubleValue))")
        } else {
            discount = Decimal(0).rounded
            print("amount value nil")
        }
        
		hideStoreName = dictionary["hide_store_name"] as? Bool
        priceVal = dictionary["item_taxes"]
        if let val = priceVal as? Decimal {
            print("decimal amount value \(val)")
            itemTaxes = val
        } else if let val = priceVal as? Double {
            print("double amount value \(val)")
            itemTaxes = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: itemTaxes).doubleValue))")
        } else if let val = priceVal as? Float {
            itemTaxes = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = priceVal as? Int {
            print("int amount value \(val)")
            itemTaxes = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: itemTaxes).doubleValue))")
        } else {
            itemTaxes = Decimal(0).rounded
            print("amount value nil")
        }
		lat = dictionary["lat"] as? Float
		lng = dictionary["lng"] as? Float
        
        if let val = dictionary["min_order_total"] as? Decimal {
            print("decimal amount value \(val)")
            minOrderTotal = val
        } else if let val = dictionary["min_order_total"] as? Double {
            print("double amount value \(val)")
            minOrderTotal = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: minOrderTotal).doubleValue))")
        } else if let val = dictionary["min_order_total"] as? Float {
            minOrderTotal = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = dictionary["min_order_total"] as? Int {
            print("int amount value \(val)")
            minOrderTotal = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: minOrderTotal).doubleValue))")
        } else {
            minOrderTotal = Decimal(0).rounded
            print("amount value nil")
        }
        
        name = dictionary["name"] as? String
		onCloseMsg = dictionary["on_close_msg"] as? String
		onSelectMsg = dictionary["on_select_msg"] as? String
		openingTime = dictionary["opening_time"] as? String
        
        if let val = dictionary["packaging_charge"] as? Decimal {
            print("decimal amount value \(val)")
            packagingCharge = val
        } else if let val = dictionary["packaging_charge"] as? Double {
            print("double amount value \(val)")
            packagingCharge = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: packagingCharge).doubleValue))")
        } else if let val = dictionary["packaging_charge"] as? Float {
            packagingCharge = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = dictionary["packaging_charge"] as? Int {
            print("int amount value \(val)")
            packagingCharge = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: packagingCharge).doubleValue))")
        } else {
            packagingCharge = Decimal(0).rounded
            print("amount value nil")
        }
        
		pgKey = dictionary["pg_key"] as? String
		phone = dictionary["phone"] as? String
		pickupMinOffsetTime = dictionary["pickup_min_offset_time"] as? Int
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		taxRate = dictionary["tax_rate"] as? Float
		temporarilyClosed = dictionary["temporarily_closed"] as? Bool
		timeSlots = dictionary["time_slots"] as? [AnyObject]
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
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
		if deliveryCharge != nil{
			dictionary["delivery_charge"] = deliveryCharge
		}
		if deliveryMinOffsetTime != nil{
			dictionary["delivery_min_offset_time"] = deliveryMinOffsetTime
		}
        if discount != nil{
            dictionary["discount"] = discount
        }
		if hideStoreName != nil{
			dictionary["hide_store_name"] = hideStoreName
		}
        if itemTaxes != nil{
            dictionary["item_taxes"] = itemTaxes
        }
		if lat != nil{
			dictionary["lat"] = lat
		}
		if lng != nil{
			dictionary["lng"] = lng
		}
		if minOrderTotal != nil{
			dictionary["min_order_total"] = minOrderTotal
		}
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
		if packagingCharge != nil{
			dictionary["packaging_charge"] = packagingCharge
		}
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
		if taxRate != nil{
			dictionary["tax_rate"] = taxRate
		}
		if temporarilyClosed != nil{
			dictionary["temporarily_closed"] = temporarilyClosed
		}
		if timeSlots != nil{
			dictionary["time_slots"] = timeSlots
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         bizLocationId = aDecoder.decodeObject(forKey: "biz_location_id") as? Int
         city = aDecoder.decodeObject(forKey: "city") as? String
         closingDay = aDecoder.decodeObject(forKey: "closing_day") as? Bool
         closingTime = aDecoder.decodeObject(forKey: "closing_time") as? String
         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? Decimal
         deliveryMinOffsetTime = aDecoder.decodeObject(forKey: "delivery_min_offset_time") as? Int
        discount = aDecoder.decodeObject(forKey: "discount") as? Decimal
         hideStoreName = aDecoder.decodeObject(forKey: "hide_store_name") as? Bool
        itemTaxes = aDecoder.decodeObject(forKey: "item_taxes") as? Decimal
         lat = aDecoder.decodeObject(forKey: "lat") as? Float
         lng = aDecoder.decodeObject(forKey: "lng") as? Float
         minOrderTotal = aDecoder.decodeObject(forKey: "min_order_total") as? Decimal
         name = aDecoder.decodeObject(forKey: "name") as? String
         onCloseMsg = aDecoder.decodeObject(forKey: "on_close_msg") as? String
         onSelectMsg = aDecoder.decodeObject(forKey: "on_select_msg") as? String
         openingTime = aDecoder.decodeObject(forKey: "opening_time") as? String
         packagingCharge = aDecoder.decodeObject(forKey: "packaging_charge") as? Decimal
         pgKey = aDecoder.decodeObject(forKey: "pg_key") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         pickupMinOffsetTime = aDecoder.decodeObject(forKey: "pickup_min_offset_time") as? Int
         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
         taxRate = aDecoder.decodeObject(forKey: "tax_rate") as? Float
         temporarilyClosed = aDecoder.decodeObject(forKey: "temporarily_closed") as? Bool
         timeSlots = aDecoder.decodeObject(forKey: "time_slots") as? [AnyObject]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if bizLocationId != nil{
			aCoder.encode(bizLocationId, forKey: "biz_location_id")
		}
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if closingDay != nil{
			aCoder.encode(closingDay, forKey: "closing_day")
		}
		if closingTime != nil{
			aCoder.encode(closingTime, forKey: "closing_time")
		}
		if deliveryCharge != nil{
			aCoder.encode(deliveryCharge, forKey: "delivery_charge")
		}
		if deliveryMinOffsetTime != nil{
			aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
		}
        if discount != nil{
            aCoder.encode(discount, forKey: "discount")
        }
		if hideStoreName != nil{
			aCoder.encode(hideStoreName, forKey: "hide_store_name")
		}
        if itemTaxes != nil{
            aCoder.encode(itemTaxes, forKey: "item_taxes")
        }
		if lat != nil{
			aCoder.encode(lat, forKey: "lat")
		}
		if lng != nil{
			aCoder.encode(lng, forKey: "lng")
		}
		if minOrderTotal != nil{
			aCoder.encode(minOrderTotal, forKey: "min_order_total")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if onCloseMsg != nil{
			aCoder.encode(onCloseMsg, forKey: "on_close_msg")
		}
		if onSelectMsg != nil{
			aCoder.encode(onSelectMsg, forKey: "on_select_msg")
		}
		if openingTime != nil{
			aCoder.encode(openingTime, forKey: "opening_time")
		}
		if packagingCharge != nil{
			aCoder.encode(packagingCharge, forKey: "packaging_charge")
		}
		if pgKey != nil{
			aCoder.encode(pgKey, forKey: "pg_key")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if pickupMinOffsetTime != nil{
			aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
		}
		if sortOrder != nil{
			aCoder.encode(sortOrder, forKey: "sort_order")
		}
		if taxRate != nil{
			aCoder.encode(taxRate, forKey: "tax_rate")
		}
		if temporarilyClosed != nil{
			aCoder.encode(temporarilyClosed, forKey: "temporarily_closed")
		}
		if timeSlots != nil{
			aCoder.encode(timeSlots, forKey: "time_slots")
		}

	}

}