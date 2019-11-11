// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let store = try Store(json)

import Foundation

// MARK: - Store

@objcMembers public class Store: NSObject, Codable {
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
        NSNumber(integerLiteral: bizLocationid)
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
        enabledForOrdering _: Int? = nil,
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
        Store(
            address: address ?? self.address,
            bizLocationid: bizLocationid ?? self.bizLocationid,
            city: city ?? self.city,
            closingDay: closingDay ?? self.closingDay,
            closingTime: closingTime ?? self.closingTime,
            deliveryCharge: deliveryCharge ?? self.deliveryCharge,
            deliveryMinOffsetTime: deliveryMinOffsetTime ?? self.deliveryMinOffsetTime,
            gst: gst ?? self.gst,
            hideStoreName: hideStoreName ?? self.hideStoreName,
            itemTaxes: itemTaxes ?? itemTaxes,
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
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

}
