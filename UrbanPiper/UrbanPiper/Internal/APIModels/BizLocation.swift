// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let bizLocation = try BizLocation(json)

import Foundation

// MARK: - BizLocation
@objc public class BizLocation: NSObject, Codable {
    @objc public let address: String
    @objc public let bizLocationid: Int
    @objc public let city: String
    @objc public let closingDay: Bool
    @objc public let closingTime: Date?
    @objc public let deliveryCharge, deliveryMinOffsetTime: Int
    @objc public let gst: String?
    @objc public let hideStoreName: Bool
    @objc public let lat, lng: Double
    @objc public let minOrderTotal: Int
    @objc public let name, onCloseMsg: String
    @objc public let onSelectMsg: String?
    @objc public let openingTime: Date?
    @objc public let packagingCharge: Int
    @objc public let pgKey, phone: String
    @objc public let pickupMinOffsetTime, sortOrder, taxRate: Int
    @objc public let temporarilyClosed: Bool
    @objc public let timeSlots: [TimeSlot]

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
    }

    init(address: String, bizLocationid: Int, city: String, closingDay: Bool, closingTime: Date?, deliveryCharge: Int, deliveryMinOffsetTime: Int, gst: String?, hideStoreName: Bool, lat: Double, lng: Double, minOrderTotal: Int, name: String, onCloseMsg: String, onSelectMsg: String?, openingTime: Date?, packagingCharge: Int, pgKey: String, phone: String, pickupMinOffsetTime: Int, sortOrder: Int, taxRate: Int, temporarilyClosed: Bool, timeSlots: [TimeSlot]) {
        self.address = address
        self.bizLocationid = bizLocationid
        self.city = city
        self.closingDay = closingDay
        self.closingTime = closingTime
        self.deliveryCharge = deliveryCharge
        self.deliveryMinOffsetTime = deliveryMinOffsetTime
        self.gst = gst
        self.hideStoreName = hideStoreName
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
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(BizLocation.self, from: data)
        self.init(address: me.address, bizLocationid: me.bizLocationid, city: me.city, closingDay: me.closingDay, closingTime: me.closingTime, deliveryCharge: me.deliveryCharge, deliveryMinOffsetTime: me.deliveryMinOffsetTime, gst: me.gst, hideStoreName: me.hideStoreName, lat: me.lat, lng: me.lng, minOrderTotal: me.minOrderTotal, name: me.name, onCloseMsg: me.onCloseMsg, onSelectMsg: me.onSelectMsg, openingTime: me.openingTime, packagingCharge: me.packagingCharge, pgKey: me.pgKey, phone: me.phone, pickupMinOffsetTime: me.pickupMinOffsetTime, sortOrder: me.sortOrder, taxRate: me.taxRate, temporarilyClosed: me.temporarilyClosed, timeSlots: me.timeSlots)
    }
}

// MARK: BizLocation convenience initializers and mutators

extension BizLocation {

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
        closingTime: Date? = nil,
        deliveryCharge: Int? = nil,
        deliveryMinOffsetTime: Int? = nil,
        gst: String? = nil,
        hideStoreName: Bool? = nil,
        lat: Double? = nil,
        lng: Double? = nil,
        minOrderTotal: Int? = nil,
        name: String? = nil,
        onCloseMsg: String? = nil,
        onSelectMsg: String? = nil,
        openingTime: Date? = nil,
        packagingCharge: Int? = nil,
        pgKey: String? = nil,
        phone: String? = nil,
        pickupMinOffsetTime: Int? = nil,
        sortOrder: Int? = nil,
        taxRate: Int? = nil,
        temporarilyClosed: Bool? = nil,
        timeSlots: [TimeSlot]? = nil
    ) -> BizLocation {
        return BizLocation(
            address: address ?? self.address,
            bizLocationid: bizLocationid ?? self.bizLocationid,
            city: city ?? self.city,
            closingDay: closingDay ?? self.closingDay,
            closingTime: closingTime ?? self.closingTime,
            deliveryCharge: deliveryCharge ?? self.deliveryCharge,
            deliveryMinOffsetTime: deliveryMinOffsetTime ?? self.deliveryMinOffsetTime,
            gst: gst ?? self.gst,
            hideStoreName: hideStoreName ?? self.hideStoreName,
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
            timeSlots: timeSlots ?? self.timeSlots
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
