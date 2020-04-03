// PastOrderDetails.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pastOrderDetails = try PastOrderDetails(json)

import Foundation

// MARK: - PastOrderDetails

@objcMembers public class PastOrderDetails: NSObject, Codable {
    public let channel: String
    public let charges: [Charge]
    public let coupon: String?
    public let created, deliveryDatetime: Date
    public let discount: Double?
    public let extPlatforms: [String]
    public let id: Int
    public let instructions: String
    public let itemLevelTotalCharges, itemLevelTotalTaxes, itemTaxes: Double
    public let merchantRefid: Int?
    public let orderLevelTotalCharges, orderLevelTotalTaxes: Double
    public let orderState: String
    public let orderSubtotal, orderTotal: Double
    public let orderType, state: String
    public let taxes: [JSONAny]
    public let taxAmt: Double?
    public let timeSlotEnd, timeSlotStart: String?
    public let totalCharges, totalExternalDiscount, totalTaxes: Double

    public var packagingCharge: Double? {
        var charge = charges.filter { $0.title == "Packaging charge" }.last?.value

        if charge == nil {
            charge = charges.filter { $0.title == "Packaging charges" }.last?.value
        }

        return charge
    }

    public var deliveryCharge: Double? {
        var charge = charges.filter { $0.title == "Delivery charge" }.last?.value

        if charge == nil {
            charge = charges.filter { $0.title == "Delivery charges" }.last?.value
        }

        return charge
    }

    public var merchantRefIdNum: NSNumber? {
        guard let val = merchantRefid else { return nil }
        return NSNumber(value: val)
    }

    public var discountDecimalNumber: NSDecimalNumber? {
        guard let val = discount else { return nil }
        return NSDecimalNumber(value: val)
    }

    public var packingChargeDecimalNumber: NSDecimalNumber? {
        guard let charge = packagingCharge else { return nil }
        return NSDecimalNumber(value: charge)
    }

    public var deliveryChargeDecimalNumber: NSDecimalNumber? {
        guard let charge = deliveryCharge else { return nil }
        return NSDecimalNumber(value: charge)
    }

    public var itemTaxesDecimalNumber: NSDecimalNumber? {
        NSDecimalNumber(value: totalTaxes)
    }

    public var taxAmtDecimalNumber: NSDecimalNumber? {
        guard let val = taxAmt else { return nil }
        return NSDecimalNumber(value: val)
    }

    enum CodingKeys: String, CodingKey {
        case channel, charges, coupon, created
        case deliveryDatetime = "delivery_datetime"
        case discount
        case extPlatforms = "ext_platforms"
        case id, instructions
        case itemLevelTotalCharges = "item_level_total_charges"
        case itemLevelTotalTaxes = "item_level_total_taxes"
        case itemTaxes = "item_taxes"
        case merchantRefid = "merchant_ref_id"
        case orderLevelTotalCharges = "order_level_total_charges"
        case orderLevelTotalTaxes = "order_level_total_taxes"
        case orderState = "order_state"
        case orderSubtotal = "order_subtotal"
        case orderTotal = "order_total"
        case orderType = "order_type"
        case state, taxes
        case timeSlotEnd = "time_slot_end"
        case timeSlotStart = "time_slot_start"
        case totalCharges = "total_charges"
        case taxAmt = "tax_amt"
        case totalExternalDiscount = "total_external_discount"
        case totalTaxes = "total_taxes"
    }

//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.channel = try values.decode(String.self, forKey: CodingKeys.channel)
//        self.charges = try values.decode([Charge].self, forKey: CodingKeys.charges)
//        self.coupon = try values.decode(String.self, forKey: CodingKeys.coupon)
//        self.created = try values.decode(Date.self, forKey: CodingKeys.created)
//        self.deliveryDatetime = try values.decode(Date.self, forKey: CodingKeys.deliveryDatetime)
//        self.discount = try values.decode(Double.self, forKey: CodingKeys.discount)
//        self.extPlatforms = try values.decode([String].self, forKey: CodingKeys.extPlatforms)
//        self.id = try values.decode(Int.self, forKey: CodingKeys.id)
//        self.instructions = try values.decode(String.self, forKey: CodingKeys.instructions)
//        self.itemLevelTotalCharges = try values.decode(Double.self, forKey: CodingKeys.itemLevelTotalCharges)
//        self.itemLevelTotalTaxes = try values.decode(Double.self, forKey: CodingKeys.itemLevelTotalTaxes)
//        self.itemTaxes = try values.decode(Double.self, forKey: CodingKeys.itemTaxes)
//        if let val = try values.decodeIfPresent(Int.self, forKey: CodingKeys.merchantRefid) {
//            merchantRefid = NSNumber(value: val)
//        } else {
//            merchantRefid = nil
//        }
//        self.orderLevelTotalCharges = try values.decode(Double.self, forKey: CodingKeys.orderLevelTotalCharges)
//        self.orderLevelTotalTaxes = try values.decode(Double.self, forKey: CodingKeys.orderLevelTotalTaxes)
//        self.orderState = try values.decode(String.self, forKey: CodingKeys.orderState)
//        self.orderSubtotal = try values.decode(Double.self, forKey: CodingKeys.orderSubtotal)
//        self.orderTotal = try values.decode(Double.self, forKey: CodingKeys.orderTotal)
//        self.orderType = try values.decode(String.self, forKey: CodingKeys.orderType)
//        self.state = try values.decode(String.self, forKey: CodingKeys.state)
//        self.taxes = try values.decode([JSONAny].self, forKey: CodingKeys.taxes)
//        self.timeSlotEnd = try values.decodeIfPresent(String.self, forKey: CodingKeys.timeSlotEnd)
//        self.timeSlotStart = try values.decodeIfPresent(String.self, forKey: CodingKeys.timeSlotStart)
//        self.totalCharges = try values.decode(Double.self, forKey: CodingKeys.totalCharges)
//        self.totalExternalDiscount = try values.decode(Double.self, forKey: CodingKeys.totalExternalDiscount)
//        self.totalTaxes = try values.decode(Double.self, forKey: CodingKeys.totalTaxes)
//        self.taxAmt = try values.decodeIfPresent(Double.self, forKey: CodingKeys.taxAmt)
//    }

    init(channel: String, charges: [Charge], coupon: String?, created: Date, deliveryDatetime: Date, discount: Double?, extPlatforms: [String], id: Int, instructions: String, itemLevelTotalCharges: Double, itemLevelTotalTaxes: Double, itemTaxes: Double, merchantRefid: Int?, orderLevelTotalCharges: Double, orderLevelTotalTaxes: Double, orderState: String, orderSubtotal: Double, orderTotal: Double, orderType: String, state: String, taxes: [JSONAny], timeSlotEnd: String?, timeSlotStart: String?, totalCharges: Double, totalExternalDiscount: Double, totalTaxes: Double, taxAmt: Double?) {
        self.channel = channel
        self.charges = charges
        self.coupon = coupon
        self.created = created
        self.deliveryDatetime = deliveryDatetime
        self.discount = discount
        self.extPlatforms = extPlatforms
        self.id = id
        self.instructions = instructions
        self.itemLevelTotalCharges = itemLevelTotalCharges
        self.itemLevelTotalTaxes = itemLevelTotalTaxes
        self.itemTaxes = itemTaxes
        self.merchantRefid = merchantRefid
        self.orderLevelTotalCharges = orderLevelTotalCharges
        self.orderLevelTotalTaxes = orderLevelTotalTaxes
        self.orderState = orderState
        self.orderSubtotal = orderSubtotal
        self.orderTotal = orderTotal
        self.orderType = orderType
        self.state = state
        self.taxes = taxes
        self.timeSlotEnd = timeSlotEnd
        self.timeSlotStart = timeSlotStart
        self.totalCharges = totalCharges
        self.totalExternalDiscount = totalExternalDiscount
        self.totalTaxes = totalTaxes
        self.taxAmt = taxAmt
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PastOrderDetails.self, from: data)
        self.init(channel: me.channel, charges: me.charges, coupon: me.coupon, created: me.created, deliveryDatetime: me.deliveryDatetime, discount: me.discount, extPlatforms: me.extPlatforms, id: me.id, instructions: me.instructions, itemLevelTotalCharges: me.itemLevelTotalCharges, itemLevelTotalTaxes: me.itemLevelTotalTaxes, itemTaxes: me.itemTaxes, merchantRefid: me.merchantRefid, orderLevelTotalCharges: me.orderLevelTotalCharges, orderLevelTotalTaxes: me.orderLevelTotalTaxes, orderState: me.orderState, orderSubtotal: me.orderSubtotal, orderTotal: me.orderTotal, orderType: me.orderType, state: me.state, taxes: me.taxes, timeSlotEnd: me.timeSlotEnd, timeSlotStart: me.timeSlotStart, totalCharges: me.totalCharges, totalExternalDiscount: me.totalExternalDiscount, totalTaxes: me.totalTaxes, taxAmt: me.taxAmt)
    }
}

// MARK: PastOrderDetails convenience initializers and mutators

extension PastOrderDetails {
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
        channel: String? = nil,
        charges: [Charge]? = nil,
        coupon: String? = nil,
        created: Date? = nil,
        deliveryDatetime: Date? = nil,
        discount: Double? = nil,
        extPlatforms: [String]? = nil,
        id: Int? = nil,
        instructions: String? = nil,
        itemLevelTotalCharges: Double? = nil,
        itemLevelTotalTaxes: Double? = nil,
        itemTaxes: Double? = nil,
        merchantRefid: Int? = nil,
        orderLevelTotalCharges: Double? = nil,
        orderLevelTotalTaxes: Double? = nil,
        orderState: String? = nil,
        orderSubtotal: Double? = nil,
        orderTotal: Double? = nil,
        orderType: String? = nil,
        state: String? = nil,
        taxes: [JSONAny]? = nil,
        timeSlotEnd: String? = nil,
        timeSlotStart: String? = nil,
        totalCharges: Double? = nil,
        totalExternalDiscount: Double? = nil,
        totalTaxes: Double? = nil,
        taxAmt: Double?
    ) -> PastOrderDetails {
        PastOrderDetails(
            channel: channel ?? self.channel,
            charges: charges ?? self.charges,
            coupon: coupon ?? self.coupon,
            created: created ?? self.created,
            deliveryDatetime: deliveryDatetime ?? self.deliveryDatetime,
            discount: discount ?? self.discount,
            extPlatforms: extPlatforms ?? self.extPlatforms,
            id: id ?? self.id,
            instructions: instructions ?? self.instructions,
            itemLevelTotalCharges: itemLevelTotalCharges ?? self.itemLevelTotalCharges,
            itemLevelTotalTaxes: itemLevelTotalTaxes ?? self.itemLevelTotalTaxes,
            itemTaxes: itemTaxes ?? self.itemTaxes,
            merchantRefid: merchantRefid ?? self.merchantRefid,
            orderLevelTotalCharges: orderLevelTotalCharges ?? self.orderLevelTotalCharges,
            orderLevelTotalTaxes: orderLevelTotalTaxes ?? self.orderLevelTotalTaxes,
            orderState: orderState ?? self.orderState,
            orderSubtotal: orderSubtotal ?? self.orderSubtotal,
            orderTotal: orderTotal ?? self.orderTotal,
            orderType: orderType ?? self.orderType,
            state: state ?? self.state,
            taxes: taxes ?? self.taxes,
            timeSlotEnd: timeSlotEnd ?? self.timeSlotEnd,
            timeSlotStart: timeSlotStart ?? self.timeSlotStart,
            totalCharges: totalCharges ?? self.totalCharges,
            totalExternalDiscount: totalExternalDiscount ?? self.totalExternalDiscount,
            totalTaxes: totalTaxes ?? self.totalTaxes,
            taxAmt: taxAmt ?? self.taxAmt
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}