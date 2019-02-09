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
	public var closingDay : Bool = false
	public var closingTime : String!
    public var isPickupEnabled : Bool = false
	public var deliveryCharge : Decimal!
	public var deliveryMinOffsetTime : Int!
    public var discount : Decimal!
	public var hideStoreName : Bool!
    public var itemTaxes : Decimal!
	public var lat : Double!
	public var lng : Double!
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
	public var temporarilyClosed : Bool = false
	public var timeSlots : [TimeSlot]!
    public var distance: Double!
    public var merchantRefId: String!

    @objc public var locationID: NSNumber {
        return NSNumber(integerLiteral: bizLocationId)
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
        merchantRefId = dictionary["merchant_ref_id"] as? String
		address = dictionary["address"] as? String
		bizLocationId = dictionary["biz_location_id"] as? Int ?? dictionary["id"] as? Int
		city = dictionary["city"] as? String
		closingDay = dictionary["closing_day"] as? Bool ?? false
		closingTime = dictionary["closing_time"] as? String
        isPickupEnabled = dictionary["is_pickup_enabled"] as? Bool ?? false

        var priceVal: Any? = dictionary["delivery_charge"]
        if let val: Decimal = priceVal as? Decimal {
            deliveryCharge = val
        } else if let val: Double = priceVal as? Double {
            deliveryCharge = Decimal(val).rounded
        } else {
            deliveryCharge = Decimal.zero
        }
        
        deliveryMinOffsetTime = dictionary["delivery_min_offset_time"] as? Int
        
        priceVal = dictionary["discount"]
        if let val: Decimal = priceVal as? Decimal {
            discount = val
        } else if let val: Double = priceVal as? Double {
            discount = Decimal(val).rounded
        } else {
            discount = Decimal.zero
        }
        
		hideStoreName = dictionary["hide_store_name"] as? Bool
        priceVal = dictionary["item_taxes"]
        if let val: Decimal = priceVal as? Decimal {
            itemTaxes = val
        } else if let val: Double = priceVal as? Double {
            itemTaxes = Decimal(val).rounded
        } else {
            itemTaxes = Decimal.zero
        }
		lat = dictionary["lat"] as? Double ?? dictionary["latitude"] as? Double
		lng = dictionary["lng"] as? Double ?? dictionary["longitude"] as? Double
        
        if let val: Decimal = dictionary["min_order_total"] as? Decimal {
            minOrderTotal = val
        } else if let val: Double = dictionary["min_order_total"] as? Double {
            minOrderTotal = Decimal(val).rounded
        } else {
            minOrderTotal = Decimal.zero
        }
        
        name = dictionary["name"] as? String
		onCloseMsg = dictionary["on_close_msg"] as? String
		onSelectMsg = dictionary["on_select_msg"] as? String
		openingTime = dictionary["opening_time"] as? String
        
        if let val: Decimal = dictionary["packaging_charge"] as? Decimal {
            packagingCharge = val
        } else if let val: Double = dictionary["packaging_charge"] as? Double {
            packagingCharge = Decimal(val).rounded
        } else {
            packagingCharge = Decimal.zero
        }
        
		pgKey = dictionary["pg_key"] as? String
		phone = dictionary["phone"] as? String
		pickupMinOffsetTime = dictionary["pickup_min_offset_time"] as? Int
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		taxRate = dictionary["tax_rate"] as? Float
		temporarilyClosed = dictionary["temporarily_closed"] as? Bool ?? false
        timeSlots = [TimeSlot]()
        if let timeSlotsArray: [[String:Any]] = dictionary["time_slots"] as? [[String:Any]], timeSlotsArray.count > 0 {
            for dic in timeSlotsArray{
                let value: TimeSlot = TimeSlot(fromDictionary: dic)
                timeSlots?.append(value)
            }
        }
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
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
        dictionary["is_pickup_enabled"] = isPickupEnabled

        dictionary["closing_day"] = closingDay
        
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
        dictionary["temporarily_closed"] = temporarilyClosed
        if timeSlots != nil{
            dictionary["time_slots"] = timeSlots
        }
        if merchantRefId != nil{
            dictionary["merchant_ref_id"] = merchantRefId
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
        isPickupEnabled = aDecoder.decodeObject(forKey: "is_pickup_enabled") as? Bool ?? false
         closingDay = aDecoder.decodeObject(forKey: "closing_day") as? Bool ?? false
         closingTime = aDecoder.decodeObject(forKey: "closing_time") as? String
         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? Decimal
         deliveryMinOffsetTime = aDecoder.decodeObject(forKey: "delivery_min_offset_time") as? Int
        discount = aDecoder.decodeObject(forKey: "discount") as? Decimal
         hideStoreName = aDecoder.decodeObject(forKey: "hide_store_name") as? Bool
        itemTaxes = aDecoder.decodeObject(forKey: "item_taxes") as? Decimal
         lat = aDecoder.decodeObject(forKey: "lat") as? Double
         lng = aDecoder.decodeObject(forKey: "lng") as? Double
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
         temporarilyClosed = aDecoder.decodeObject(forKey: "temporarily_closed") as? Bool ?? false
         timeSlots = aDecoder.decodeObject(forKey: "time_slots") as? [TimeSlot]
        merchantRefId = aDecoder.decodeObject(forKey: "merchant_ref_id") as? String

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
        aCoder.encode(isPickupEnabled, forKey: "is_pickup_enabled")
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
        aCoder.encode(closingDay, forKey: "closing_day")
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
        aCoder.encode(temporarilyClosed, forKey: "temporarily_closed")
		if timeSlots != nil{
			aCoder.encode(timeSlots, forKey: "time_slots")
		}
        if merchantRefId != nil{
            aCoder.encode(merchantRefId, forKey: "merchant_ref_id")
        }

	}

}
