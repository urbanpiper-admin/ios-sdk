//
//	Store.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class Store: NSObject, JSONDecodable, NSCoding {
    public var address: String!
    public var bizLocationId: Int = 0
    public var city: String!
    public var closingDay: Bool = false
    @objc public var closingTime: String!
    public var deliveryCharge: Decimal!
    public var deliveryMinOffsetTime: Int?
    public var discount: Decimal!
    public var fulfillmentModes: [String]?
    public var hideStoreName: Bool
    public var itemTaxes: Decimal!
    public var lat: Double = 0
    public var lng: Double = 0
    public var minOrderTotal: Decimal!
    @objc public var name: String!
    public var onCloseMsg: String!
    public var onSelectMsg: String!
    @objc public var openingTime: String!
    public var packagingCharge: Decimal!
    public var pgKey: String!
    public var phone: String!
    public var pickupMinOffsetTime: Int?
    public var sortOrder: Int?
    public var taxRate: Float!
    public var temporarilyClosed: Bool = false
    public var timeSlots: [TimeSlot]!
    public var merchantRefId: String!

    @objc public var storeId: NSNumber {
        return NSNumber(integerLiteral: bizLocationId)
    }

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        merchantRefId = dictionary["merchant_ref_id"] as? String
        address = dictionary["address"] as? String
        bizLocationId = dictionary["biz_location_id"] as? Int ?? dictionary["id"] as? Int ?? 0
        city = dictionary["city"] as? String
        closingDay = dictionary["closing_day"] as? Bool ?? false
        closingTime = dictionary["closing_time"] as? String

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
        
        fulfillmentModes = dictionary["fulfillment_modes"] as? [String]

        hideStoreName = dictionary["hide_store_name"] as? Bool ?? false
        priceVal = dictionary["item_taxes"]
        if let val: Decimal = priceVal as? Decimal {
            itemTaxes = val
        } else if let val: Double = priceVal as? Double {
            itemTaxes = Decimal(val).rounded
        } else {
            itemTaxes = Decimal.zero
        }
        lat = dictionary["lat"] as? Double ?? dictionary["latitude"] as? Double ?? 0
        lng = dictionary["lng"] as? Double ?? dictionary["longitude"] as? Double ?? 0

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
        if let timeSlotsArray: [[String: AnyObject]] = dictionary["time_slots"] as? [[String: AnyObject]], timeSlotsArray.count > 0 {
            for dic in timeSlotsArray {
                guard let value: TimeSlot = TimeSlot(fromDictionary: dic) else { continue }
                timeSlots?.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let address = address {
            dictionary["address"] = address as AnyObject
        }
        dictionary["biz_location_id"] = bizLocationId as AnyObject
        if let city = city {
            dictionary["city"] = city as AnyObject
        }

        dictionary["closing_day"] = closingDay as AnyObject

        if let closingTime = closingTime {
            dictionary["closing_time"] = closingTime as AnyObject
        }
        if let deliveryCharge = deliveryCharge {
            dictionary["delivery_charge"] = deliveryCharge as AnyObject
        }
        if let deliveryMinOffsetTime = deliveryMinOffsetTime {
            dictionary["delivery_min_offset_time"] = deliveryMinOffsetTime as AnyObject
        }
        if let discount = discount {
            dictionary["discount"] = discount as AnyObject
        }

        dictionary["hide_store_name"] = hideStoreName as AnyObject

        if let itemTaxes = itemTaxes {
            dictionary["item_taxes"] = itemTaxes as AnyObject
        }
        dictionary["lat"] = lat as AnyObject
        dictionary["lng"] = lng as AnyObject
        if let minOrderTotal = minOrderTotal {
            dictionary["min_order_total"] = minOrderTotal as AnyObject
        }
        
        if let fulfillmentModes = fulfillmentModes {
            dictionary["fulfillment_modes"] = fulfillmentModes as AnyObject
        }
        
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
        if let packagingCharge = packagingCharge {
            dictionary["packaging_charge"] = packagingCharge as AnyObject
        }
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
        if let taxRate = taxRate {
            dictionary["tax_rate"] = taxRate as AnyObject
        }
        dictionary["temporarily_closed"] = temporarilyClosed as AnyObject
        if let timeSlots = timeSlots {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for timeSlotsElement in timeSlots {
                dictionaryElements.append(timeSlotsElement.toDictionary())
            }
            dictionary["time_slots"] = dictionaryElements as AnyObject
        }
        if let merchantRefId = merchantRefId {
            dictionary["merchant_ref_id"] = merchantRefId as AnyObject
        }

        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        address = aDecoder.decodeObject(forKey: "address") as? String
        if let val = aDecoder.decodeObject(forKey: "biz_location_id") as? Int {
            bizLocationId = val
        } else {
            bizLocationId = aDecoder.decodeInteger(forKey: "biz_location_id")
        }
        city = aDecoder.decodeObject(forKey: "city") as? String
        closingDay = aDecoder.decodeBool(forKey: "closing_day")
        closingTime = aDecoder.decodeObject(forKey: "closing_time") as? String
        deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? Decimal
        deliveryMinOffsetTime = aDecoder.decodeObject(forKey: "delivery_min_offset_time") as? Int
        discount = aDecoder.decodeObject(forKey: "discount") as? Decimal
        hideStoreName = aDecoder.decodeBool(forKey: "hide_store_name")
        itemTaxes = aDecoder.decodeObject(forKey: "item_taxes") as? Decimal
        lat = aDecoder.decodeObject(forKey: "lat") as? Double ?? 0
        lng = aDecoder.decodeObject(forKey: "lng") as? Double ?? 0
        minOrderTotal = aDecoder.decodeObject(forKey: "min_order_total") as? Decimal
        name = aDecoder.decodeObject(forKey: "name") as? String
        fulfillmentModes = aDecoder.decodeObject(forKey: "fulfillment_modes") as? [String]
        onCloseMsg = aDecoder.decodeObject(forKey: "on_close_msg") as? String
        onSelectMsg = aDecoder.decodeObject(forKey: "on_select_msg") as? String
        openingTime = aDecoder.decodeObject(forKey: "opening_time") as? String
        packagingCharge = aDecoder.decodeObject(forKey: "packaging_charge") as? Decimal
        pgKey = aDecoder.decodeObject(forKey: "pg_key") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        pickupMinOffsetTime = aDecoder.decodeObject(forKey: "pickup_min_offset_time") as? Int
        sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
        taxRate = aDecoder.decodeObject(forKey: "tax_rate") as? Float

        if let numberVal = aDecoder.decodeObject(forKey: "temporarily_closed") as? NSNumber {
            temporarilyClosed = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "temporarily_closed") {
            temporarilyClosed = aDecoder.decodeBool(forKey: "temporarily_closed")
        } else {
            temporarilyClosed = false
        }

        timeSlots = aDecoder.decodeObject(forKey: "time_slots") as? [TimeSlot]
        merchantRefId = aDecoder.decodeObject(forKey: "merchant_ref_id") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        // if let address = address {
            aCoder.encode(address, forKey: "address")
        // }
        aCoder.encode(bizLocationId, forKey: "biz_location_id")
        // if let city = city {
            aCoder.encode(city, forKey: "city")
        // }
        aCoder.encode(closingDay, forKey: "closing_day")
        // if let closingTime = closingTime {
            aCoder.encode(closingTime, forKey: "closing_time")
        // }
        // if let deliveryCharge = deliveryCharge {
            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
        // }
//        // if let deliveryMinOffsetTime = deliveryMinOffsetTime {
            aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
//        // }
        // if let discount = discount {
            aCoder.encode(discount, forKey: "discount")
        // }

        aCoder.encode(hideStoreName, forKey: "hide_store_name")

        // if let itemTaxes = itemTaxes {
            aCoder.encode(itemTaxes, forKey: "item_taxes")
        // }
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
        // if let minOrderTotal = minOrderTotal {
            aCoder.encode(minOrderTotal, forKey: "min_order_total")
        // }
        // if let name = name {
            aCoder.encode(name, forKey: "name")
        // }
        // if let onCloseMsg = onCloseMsg {
            aCoder.encode(onCloseMsg, forKey: "on_close_msg")
        // }
        // if let onSelectMsg = onSelectMsg {
            aCoder.encode(onSelectMsg, forKey: "on_select_msg")
        // }
        // if let openingTime = openingTime {
            aCoder.encode(openingTime, forKey: "opening_time")
        // }
        // if let packagingCharge = packagingCharge {
            aCoder.encode(packagingCharge, forKey: "packaging_charge")
        // }
        // if let pgKey = pgKey {
            aCoder.encode(pgKey, forKey: "pg_key")
        // }
        // if let phone = phone {
            aCoder.encode(phone, forKey: "phone")
        // }
        aCoder.encode(fulfillmentModes, forKey: "fulfillment_modes")
        // if let pickupMinOffsetTime = pickupMinOffsetTime {
            aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
        // }
        // if let sortOrder = sortOrder {
            aCoder.encode(sortOrder, forKey: "sort_order")
        // }
        // if let taxRate = taxRate {
            aCoder.encode(taxRate, forKey: "tax_rate")
        // }
        aCoder.encode(temporarilyClosed, forKey: "temporarily_closed")
        // if let timeSlots = timeSlots {
            aCoder.encode(timeSlots, forKey: "time_slots")
        // }
        // if let merchantRefId = merchantRefId {
            aCoder.encode(merchantRefId, forKey: "merchant_ref_id")
        // }
    }
}
