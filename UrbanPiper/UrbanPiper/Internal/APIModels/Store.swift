// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let store = try Store(json)

import Foundation

// MARK: - Store
@objcMembers public class Store: NSObject, Codable, NSCoding {
    public let address: String
    public let bizLocationid: Int
    public let city: String
    public let closingDay: Bool
    public let closingTime: String
    public let deliveryCharge: Double
    public let deliveryMinOffsetTime: Int?
    public let gst: String?
    public let hideStoreName: Bool
    public let itemTaxes: Double?
    public let lat, lng: Double
    public let minOrderTotal: Double?
    public let name: String
    public let onCloseMsg: String?
    public let onSelectMsg: String?
    public let openingTime: String
    public let packagingCharge: Double
    public let pgKey: String
    public let phone: String?
    public let pickupMinOffsetTime: Int?
    public let sortOrder: Int
    public let taxRate: Float
    public let temporarilyClosed: Bool
    public let timeSlots: [TimeSlot]
    public let fulfillmentModes: [String]?

    public var storeId: NSNumber {
        return NSNumber(integerLiteral: bizLocationid)
    }

    enum CodingKeys: String, CodingKey {
        case address
        case bizLocationid = "biz_location_id"
        case city
        case closingDay = "closing_day"
        case closingTime = "closing_time"
        case deliveryCharge = "delivery_charge"
        case deliveryMinOffsetTime = "delivery_min_offset_time"
        case gst
        case hideStoreName = "hide_store_name"
        case itemTaxes = "item_taxes"
        case lat, lng
        case minOrderTotal = "min_order_total"
        case name
        case onCloseMsg = "on_close_msg"
        case onSelectMsg = "on_select_msg"
        case openingTime = "opening_time"
        case packagingCharge = "packaging_charge"
        case pgKey = "pg_key"
        case phone
        case pickupMinOffsetTime = "pickup_min_offset_time"
        case sortOrder = "sort_order"
        case taxRate = "tax_rate"
        case temporarilyClosed = "temporarily_closed"
        case timeSlots = "time_slots"
        case fulfillmentModes = "fulfillment_modes"
    }

    init(address: String, bizLocationid: Int, city: String, closingDay: Bool, closingTime: String, deliveryCharge: Double, deliveryMinOffsetTime: Int?, gst: String?, hideStoreName: Bool, itemTaxes: Double?, lat: Double, lng: Double, minOrderTotal: Double?, name: String, onCloseMsg: String?, onSelectMsg: String?, openingTime: String, packagingCharge: Double, pgKey: String, phone: String?, pickupMinOffsetTime: Int?, sortOrder: Int, taxRate: Float, temporarilyClosed: Bool, timeSlots: [TimeSlot], fulfillmentModes: [String]?) {
        self.address = address
        self.bizLocationid = bizLocationid
        self.city = city
        self.closingDay = closingDay
        self.closingTime = closingTime
        self.deliveryCharge = deliveryCharge
        self.deliveryMinOffsetTime = deliveryMinOffsetTime
        self.gst = gst
        self.hideStoreName = hideStoreName
        self.itemTaxes = itemTaxes
        self.lat = lat
        self.lng = lng
        self.minOrderTotal = minOrderTotal
        self.name = name
        self.onCloseMsg = onCloseMsg
        self.onSelectMsg = onSelectMsg
        self.openingTime = openingTime
        self.packagingCharge = packagingCharge
        self.pgKey = pgKey
        self.phone = phone
        self.pickupMinOffsetTime = pickupMinOffsetTime
        self.sortOrder = sortOrder
        self.taxRate = taxRate
        self.temporarilyClosed = temporarilyClosed
        self.timeSlots = timeSlots
        self.fulfillmentModes = fulfillmentModes
    }
    
    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    required public init(coder aDecoder: NSCoder)
    {
        address = (aDecoder.decodeObject(forKey: "address") as? String)!
        bizLocationid = aDecoder.decodeInteger(forKey: "biz_location_id")
        gst = aDecoder.decodeObject(forKey: "gst") as? String
        fulfillmentModes = aDecoder.decodeObject(forKey: "fulfillment_modes") as? [String]
        city = (aDecoder.decodeObject(forKey: "city") as? String)!
        closingDay = aDecoder.decodeBool(forKey: "closing_day")
        closingTime = (aDecoder.decodeObject(forKey: "closing_time") as? String)!
        deliveryCharge = aDecoder.decodeDouble(forKey: "delivery_charge")
         deliveryMinOffsetTime = aDecoder.decodeObject(forKey: "delivery_min_offset_time") as? Int
        hideStoreName = aDecoder.decodeBool(forKey: "hide_store_name")
        itemTaxes = aDecoder.decodeObject(forKey: "item_taxes") as? Double
         lat = aDecoder.decodeDouble(forKey: "lat")
         lng = aDecoder.decodeDouble(forKey: "lng")
         minOrderTotal = aDecoder.decodeObject(forKey: "min_order_total") as? Double
        name = (aDecoder.decodeObject(forKey: "name") as? String)!
        onCloseMsg = aDecoder.decodeObject(forKey: "on_close_msg") as? String
         onSelectMsg = aDecoder.decodeObject(forKey: "on_select_msg") as? String
        openingTime = (aDecoder.decodeObject(forKey: "opening_time") as? String)!
        packagingCharge = aDecoder.decodeDouble(forKey: "packaging_charge")
        pgKey = (aDecoder.decodeObject(forKey: "pg_key") as? String)!
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         pickupMinOffsetTime = aDecoder.decodeObject(forKey: "pickup_min_offset_time") as? Int
        sortOrder = aDecoder.decodeInteger(forKey: "sort_order")
        taxRate = aDecoder.decodeFloat(forKey: "tax_rate")
        
        temporarilyClosed = aDecoder.decodeBool(forKey: "temporarily_closed")

        timeSlots = (aDecoder.decodeObject(forKey: "time_slots") as? [TimeSlot])!
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Store.self, from: data)
        self.init(address: me.address, bizLocationid: me.bizLocationid, city: me.city, closingDay: me.closingDay, closingTime: me.closingTime, deliveryCharge: me.deliveryCharge, deliveryMinOffsetTime: me.deliveryMinOffsetTime, gst: me.gst, hideStoreName: me.hideStoreName, itemTaxes: me.itemTaxes, lat: me.lat, lng: me.lng, minOrderTotal: me.minOrderTotal, name: me.name, onCloseMsg: me.onCloseMsg, onSelectMsg: me.onSelectMsg, openingTime: me.openingTime, packagingCharge: me.packagingCharge, pgKey: me.pgKey, phone: me.phone, pickupMinOffsetTime: me.pickupMinOffsetTime, sortOrder: me.sortOrder, taxRate: me.taxRate, temporarilyClosed: me.temporarilyClosed, timeSlots: me.timeSlots, fulfillmentModes: me.fulfillmentModes)
    }
}

// MARK: Store convenience initializers and mutators

extension Store {

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    public func with(
        address: String? = nil,
        bizLocationid: Int? = nil,
        city: String? = nil,
        closingDay: Bool? = nil,
        closingTime: String? = nil,
        deliveryCharge: Double? = nil,
        deliveryMinOffsetTime: Int? = nil,
        enabledForOrdering: Int? = nil,
        gst: String? = nil,
        hideStoreName: Bool? = nil,
        lat: Double? = nil,
        lng: Double? = nil,
        minOrderTotal: Double? = nil,
        name: String? = nil,
        onCloseMsg: String? = nil,
        onSelectMsg: String? = nil,
        openingTime: String? = nil,
        packagingCharge: Double? = nil,
        pgKey: String? = nil,
        phone: String? = nil,
        pickupMinOffsetTime: Int? = nil,
        sortOrder: Int? = nil,
        taxRate: Float? = nil,
        temporarilyClosed: Bool? = nil,
        timeSlots: [TimeSlot]? = nil,
        fulfillmentModes: [String]? = nil
    ) -> Store {
        return Store(
            address: address ?? self.address,
            bizLocationid: bizLocationid ?? self.bizLocationid,
            city: city ?? self.city,
            closingDay: closingDay ?? self.closingDay,
            closingTime: closingTime ?? self.closingTime,
            deliveryCharge: deliveryCharge ?? self.deliveryCharge,
            deliveryMinOffsetTime: deliveryMinOffsetTime ?? self.deliveryMinOffsetTime,
            gst: gst ?? self.gst,
            hideStoreName: hideStoreName ?? self.hideStoreName,
            itemTaxes: itemTaxes ?? self.itemTaxes,
            lat: lat ?? self.lat,
            lng: lng ?? self.lng,
            minOrderTotal: minOrderTotal ?? self.minOrderTotal,
            name: name ?? self.name,
            onCloseMsg: onCloseMsg ?? self.onCloseMsg,
            onSelectMsg: onSelectMsg ?? self.onSelectMsg,
            openingTime: openingTime ?? self.openingTime,
            packagingCharge: packagingCharge ?? self.packagingCharge,
            pgKey: pgKey ?? self.pgKey,
            phone: phone ?? self.phone,
            pickupMinOffsetTime: pickupMinOffsetTime ?? self.pickupMinOffsetTime,
            sortOrder: sortOrder ?? self.sortOrder,
            taxRate: taxRate ?? self.taxRate,
            temporarilyClosed: temporarilyClosed ?? self.temporarilyClosed,
            timeSlots: timeSlots ?? self.timeSlots,
            fulfillmentModes: fulfillmentModes ?? self.fulfillmentModes
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    
    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
            aCoder.encode(address, forKey: "address")
        aCoder.encode(bizLocationid, forKey: "biz_location_id")
            aCoder.encode(city, forKey: "city")
        aCoder.encode(closingDay, forKey: "closing_day")
            aCoder.encode(closingTime, forKey: "closing_time")
            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
            aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
        aCoder.encode(hideStoreName, forKey: "hide_store_name")
            aCoder.encode(itemTaxes, forKey: "item_taxes")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
            aCoder.encode(minOrderTotal, forKey: "min_order_total")
            aCoder.encode(name, forKey: "name")
            aCoder.encode(onCloseMsg, forKey: "on_close_msg")
            aCoder.encode(onSelectMsg, forKey: "on_select_msg")
            aCoder.encode(openingTime, forKey: "opening_time")
            aCoder.encode(packagingCharge, forKey: "packaging_charge")
            aCoder.encode(pgKey, forKey: "pg_key")
            aCoder.encode(phone, forKey: "phone")
            aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
            aCoder.encode(sortOrder, forKey: "sort_order")
            aCoder.encode(taxRate, forKey: "tax_rate")
        aCoder.encode(temporarilyClosed, forKey: "temporarily_closed")
        aCoder.encode(timeSlots, forKey: "time_slots")
        aCoder.encode(gst, forKey: "gst")
        aCoder.encode(fulfillmentModes, forKey: "fulfillment_modes")
    }
}
