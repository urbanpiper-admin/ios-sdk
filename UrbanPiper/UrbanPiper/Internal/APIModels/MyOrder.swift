// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let pastOrder = try PastOrder(json)

import Foundation


import Foundation

public enum OrderStatus: String {
    case cancelled
    case expired
    case completed
    case placed
    case acknowledged
    case dispatched
    case awaitingPayment = "awaiting_payment"

    public var displayName: String {
        switch self {
        case .cancelled:
            return "Cancelled"
        case .expired:
            return "Expired"
        case .completed:
            return "Completed"
        case .placed:
            return "Placed"
        case .acknowledged:
            return "Acknowledged"
        case .dispatched:
            return "Dispatched"
        case .awaitingPayment:
            return "Awaiting Payment"
        }
    }

    public var displayColor: UIColor {
        switch self {
        case .cancelled:
            return #colorLiteral(red: 0.631372549, green: 0.1529411765, blue: 0, alpha: 1)
        case .expired:
            return #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
        case .completed:
            return #colorLiteral(red: 0, green: 0.4235294118, blue: 0.2235294118, alpha: 1)
        case .placed:
            return #colorLiteral(red: 0.5568627451, green: 0.2666666667, blue: 0.6784313725, alpha: 1)
        case .acknowledged:
            return #colorLiteral(red: 0.1607843137, green: 0.5019607843, blue: 0.7254901961, alpha: 1)
        case .dispatched:
            return #colorLiteral(red: 0.1725490196, green: 0.2431372549, blue: 0.3137254902, alpha: 1)
        case .awaitingPayment:
            return #colorLiteral(red: 0.0862745098, green: 0.6274509804, blue: 0.5215686275, alpha: 1.0)
        }
    }
}

// MARK: - PastOrder
@objcMembers public class PastOrder: NSObject, Codable {
    public let address: String?
    public let bizLocationid: Int
    public let bizLocationName, channel: String
    public let charges: [Charge]
    public let coupon: String?
    public let created: Date
    public let customerName: String
    public let deliveryAddressRef: Int?
    public let deliveryDatetime: Int
    public let discount: Double?
    public let extPlatformid: Int?
    public let id: Int
    public let instructions: String
    public let itemLevelTotalCharges, itemLevelTotalTaxes: Double
    public let merchantRefid: Int?
    public let orderLevelTotalCharges, orderLevelTotalTaxes: Double
    public let orderState: String
    public let orderSubtotal, orderTotal: Double
    public let orderType, paymentOption, phone: String
    public let taxAmt: Double
    public let taxRate: Float
    public let taxes: [JSONAny]
    public let totalCharges, totalTaxes: Double
    public let timeSlotEnd, timeSlotStart: String?
    public var myOrderDetailsResponse: PastOrderDetailsResponse?

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

    enum CodingKeys: String, CodingKey {
        case address
        case bizLocationid = "biz_location_id"
        case bizLocationName = "biz_location_name"
        case channel, charges, coupon, created
        case customerName = "customer_name"
        case deliveryAddressRef = "delivery_address_ref"
        case deliveryDatetime = "delivery_datetime"
        case discount
        case extPlatformid = "ext_platform_id"
        case id, instructions
        case itemLevelTotalCharges = "item_level_total_charges"
        case itemLevelTotalTaxes = "item_level_total_taxes"
        case merchantRefid = "merchant_ref_id"
        case orderLevelTotalCharges = "order_level_total_charges"
        case orderLevelTotalTaxes = "order_level_total_taxes"
        case orderState = "order_state"
        case orderSubtotal = "order_subtotal"
        case orderTotal = "order_total"
        case orderType = "order_type"
        case paymentOption = "payment_option"
        case phone
        case taxAmt = "tax_amt"
        case taxRate = "tax_rate"
        case taxes
        case totalCharges = "total_charges"
        case totalTaxes = "total_taxes"
        case timeSlotEnd = "time_slot_end"
        case timeSlotStart = "time_slot_start"
    }

    init(address: String?, bizLocationid: Int, bizLocationName: String, channel: String, charges: [Charge], coupon: String?, created: Date, customerName: String, deliveryAddressRef: Int?, deliveryDatetime: Int, discount: Double?, extPlatformid: Int?, id: Int, instructions: String, itemLevelTotalCharges: Double, itemLevelTotalTaxes: Double, merchantRefid: Int?, orderLevelTotalCharges: Double, orderLevelTotalTaxes: Double, orderState: String, orderSubtotal: Double, orderTotal: Double, orderType: String, paymentOption: String, phone: String, taxAmt: Double, taxRate: Float, taxes: [JSONAny], totalCharges: Double, totalTaxes: Double, timeSlotEnd: String?, timeSlotStart: String?) {
        self.address = address
        self.bizLocationid = bizLocationid
        self.bizLocationName = bizLocationName
        self.channel = channel
        self.charges = charges
        self.coupon = coupon
        self.created = created
        self.customerName = customerName
        self.deliveryAddressRef = deliveryAddressRef
        self.deliveryDatetime = deliveryDatetime
        self.discount = discount
        self.extPlatformid = extPlatformid
        self.id = id
        self.instructions = instructions
        self.itemLevelTotalCharges = itemLevelTotalCharges
        self.itemLevelTotalTaxes = itemLevelTotalTaxes
        self.merchantRefid = merchantRefid
        self.orderLevelTotalCharges = orderLevelTotalCharges
        self.orderLevelTotalTaxes = orderLevelTotalTaxes
        self.orderState = orderState
        self.orderSubtotal = orderSubtotal
        self.orderTotal = orderTotal
        self.orderType = orderType
        self.paymentOption = paymentOption
        self.phone = phone
        self.taxAmt = taxAmt
        self.taxRate = taxRate
        self.taxes = taxes
        self.totalCharges = totalCharges
        self.totalTaxes = totalTaxes
        self.timeSlotEnd = timeSlotEnd
        self.timeSlotStart = timeSlotStart
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PastOrder.self, from: data)
        self.init(address: me.address, bizLocationid: me.bizLocationid, bizLocationName: me.bizLocationName, channel: me.channel, charges: me.charges, coupon: me.coupon, created: me.created, customerName: me.customerName, deliveryAddressRef: me.deliveryAddressRef, deliveryDatetime: me.deliveryDatetime, discount: me.discount, extPlatformid: me.extPlatformid, id: me.id, instructions: me.instructions, itemLevelTotalCharges: me.itemLevelTotalCharges, itemLevelTotalTaxes: me.itemLevelTotalTaxes, merchantRefid: me.merchantRefid, orderLevelTotalCharges: me.orderLevelTotalCharges, orderLevelTotalTaxes: me.orderLevelTotalTaxes, orderState: me.orderState, orderSubtotal: me.orderSubtotal, orderTotal: me.orderTotal, orderType: me.orderType, paymentOption: me.paymentOption, phone: me.phone, taxAmt: me.taxAmt, taxRate: me.taxRate, taxes: me.taxes, totalCharges: me.totalCharges, totalTaxes: me.totalTaxes, timeSlotEnd: me.timeSlotEnd, timeSlotStart: me.timeSlotStart)
    }
}

// MARK: Order convenience initializers and mutators

extension PastOrder {

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        address: String? = nil,
        bizLocationid: Int? = nil,
        bizLocationName: String? = nil,
        channel: String? = nil,
        charges: [Charge]? = nil,
        coupon: String? = nil,
        created: Date? = nil,
        customerName: String? = nil,
        deliveryAddressRef: Int? = nil,
        deliveryDatetime: Int? = nil,
        discount: Double? = nil,
        extPlatformid: Int? = nil,
        id: Int? = nil,
        instructions: String? = nil,
        itemLevelTotalCharges: Double? = nil,
        itemLevelTotalTaxes: Double? = nil,
        merchantRefid: Int? = nil,
        orderLevelTotalCharges: Double? = nil,
        orderLevelTotalTaxes: Double? = nil,
        orderState: String? = nil,
        orderSubtotal: Double? = nil,
        orderTotal: Double? = nil,
        orderType: String? = nil,
        paymentOption: String? = nil,
        phone: String? = nil,
        taxAmt: Double? = nil,
        taxRate: Float? = nil,
        taxes: [JSONAny]? = nil,
        totalCharges: Double? = nil,
        totalTaxes: Double? = nil,
        timeSlotEnd: String? = nil,
        timeSlotStart: String? = nil
    ) -> PastOrder {
        return PastOrder(
            address: address ?? self.address,
            bizLocationid: bizLocationid ?? self.bizLocationid,
            bizLocationName: bizLocationName ?? self.bizLocationName,
            channel: channel ?? self.channel,
            charges: charges ?? self.charges,
            coupon: coupon ?? self.coupon,
            created: created ?? self.created,
            customerName: customerName ?? self.customerName,
            deliveryAddressRef: deliveryAddressRef ?? self.deliveryAddressRef,
            deliveryDatetime: deliveryDatetime ?? self.deliveryDatetime,
            discount: discount ?? self.discount,
            extPlatformid: extPlatformid ?? self.extPlatformid,
            id: id ?? self.id,
            instructions: instructions ?? self.instructions,
            itemLevelTotalCharges: itemLevelTotalCharges ?? self.itemLevelTotalCharges,
            itemLevelTotalTaxes: itemLevelTotalTaxes ?? self.itemLevelTotalTaxes,
            merchantRefid: merchantRefid ?? self.merchantRefid,
            orderLevelTotalCharges: orderLevelTotalCharges ?? self.orderLevelTotalCharges,
            orderLevelTotalTaxes: orderLevelTotalTaxes ?? self.orderLevelTotalTaxes,
            orderState: orderState ?? self.orderState,
            orderSubtotal: orderSubtotal ?? self.orderSubtotal,
            orderTotal: orderTotal ?? self.orderTotal,
            orderType: orderType ?? self.orderType,
            paymentOption: paymentOption ?? self.paymentOption,
            phone: phone ?? self.phone,
            taxAmt: taxAmt ?? self.taxAmt,
            taxRate: taxRate ?? self.taxRate,
            taxes: taxes ?? self.taxes,
            totalCharges: totalCharges ?? self.totalCharges,
            totalTaxes: totalTaxes ?? self.totalTaxes,
            timeSlotEnd: timeSlotEnd ?? self.timeSlotEnd,
            timeSlotStart: timeSlotStart ?? self.timeSlotStart
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
