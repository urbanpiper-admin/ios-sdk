// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let order = try Order(json)

import Foundation

// MARK: - Order
@objcMembers public class Order: NSObject, JSONDecodable {
    public let applyWalletCredit: Bool
    public let bizLocationid: Int
    public let channel: String
    public let charges: [Charge]
    public let deliveryCharge: Double
    public let discount: Discount?
    public let itemLevelTotalCharges, itemLevelTotalTaxes, itemTaxes: Double
    public let items: [OrderItem]
    public let orderLevelTotalCharges, orderLevelTotalTaxes, orderSubtotal, orderTotal: Double
    public let orderType: String
    public let packagingCharge, payableAmount: Double
    public let paymentModes: [String]?
    public let taxes: [JSONAny]
    public let totalCharges, totalTaxes, totalWeight: Double
    public let walletCreditApplicable: Bool
    public let taxRate: Float?
    public let walletCreditApplied: Double

    enum CodingKeys: String, CodingKey {
        case applyWalletCredit = "apply_wallet_credit"
        case bizLocationid = "biz_location_id"
        case channel, charges
        case deliveryCharge = "delivery_charge"
        case discount
        case itemLevelTotalCharges = "item_level_total_charges"
        case itemLevelTotalTaxes = "item_level_total_taxes"
        case itemTaxes = "item_taxes"
        case items
        case orderLevelTotalCharges = "order_level_total_charges"
        case orderLevelTotalTaxes = "order_level_total_taxes"
        case orderSubtotal = "order_subtotal"
        case orderTotal = "order_total"
        case orderType = "order_type"
        case packagingCharge = "packaging_charge"
        case payableAmount = "payable_amount"
        case paymentModes = "payment_modes"
        case taxes
        case totalCharges = "total_charges"
        case totalTaxes = "total_taxes"
        case totalWeight = "total_weight"
        case walletCreditApplicable = "wallet_credit_applicable"
        case walletCreditApplied = "wallet_credit_applied"
        case taxRate = "tax_rate"
    }

    init(applyWalletCredit: Bool, bizLocationid: Int, channel: String, charges: [Charge], deliveryCharge: Double, discount: Discount?, itemLevelTotalCharges: Double, itemLevelTotalTaxes: Double, itemTaxes: Double, items: [OrderItem], orderLevelTotalCharges: Double, orderLevelTotalTaxes: Double, orderSubtotal: Double, orderTotal: Double, orderType: String, packagingCharge: Double, payableAmount: Double, paymentModes: [String]?, taxes: [JSONAny], totalCharges: Double, totalTaxes: Double, totalWeight: Double, walletCreditApplicable: Bool, walletCreditApplied: Double, taxRate: Float?) {
        self.applyWalletCredit = applyWalletCredit
        self.bizLocationid = bizLocationid
        self.channel = channel
        self.charges = charges
        self.deliveryCharge = deliveryCharge
        self.discount = discount
        self.itemLevelTotalCharges = itemLevelTotalCharges
        self.itemLevelTotalTaxes = itemLevelTotalTaxes
        self.itemTaxes = itemTaxes
        self.items = items
        self.orderLevelTotalCharges = orderLevelTotalCharges
        self.orderLevelTotalTaxes = orderLevelTotalTaxes
        self.orderSubtotal = orderSubtotal
        self.orderTotal = orderTotal
        self.orderType = orderType
        self.packagingCharge = packagingCharge
        self.payableAmount = payableAmount
        self.paymentModes = paymentModes
        self.taxes = taxes
        self.totalCharges = totalCharges
        self.totalTaxes = totalTaxes
        self.totalWeight = totalWeight
        self.walletCreditApplicable = walletCreditApplicable
        self.walletCreditApplied = walletCreditApplied
        self.taxRate = taxRate
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Order.self, from: data)
        self.init(applyWalletCredit: me.applyWalletCredit, bizLocationid: me.bizLocationid, channel: me.channel, charges: me.charges, deliveryCharge: me.deliveryCharge, discount: me.discount, itemLevelTotalCharges: me.itemLevelTotalCharges, itemLevelTotalTaxes: me.itemLevelTotalTaxes, itemTaxes: me.itemTaxes, items: me.items, orderLevelTotalCharges: me.orderLevelTotalCharges, orderLevelTotalTaxes: me.orderLevelTotalTaxes, orderSubtotal: me.orderSubtotal, orderTotal: me.orderTotal, orderType: me.orderType, packagingCharge: me.packagingCharge, payableAmount: me.payableAmount, paymentModes: me.paymentModes, taxes: me.taxes, totalCharges: me.totalCharges, totalTaxes: me.totalTaxes, totalWeight: me.totalWeight, walletCreditApplicable: me.walletCreditApplicable, walletCreditApplied: me.walletCreditApplied, taxRate: me.taxRate)
    }
}

// MARK: Order convenience initializers and mutators

extension Order {

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
        applyWalletCredit: Bool? = nil,
        bizLocationid: Int? = nil,
        channel: String? = nil,
        charges: [Charge]? = nil,
        deliveryCharge: Double? = nil,
        discount: Discount? = nil,
        itemLevelTotalCharges: Double? = nil,
        itemLevelTotalTaxes: Double? = nil,
        itemTaxes: Double? = nil,
        items: [OrderItem]? = nil,
        orderLevelTotalCharges: Double? = nil,
        orderLevelTotalTaxes: Double? = nil,
        orderSubtotal: Double? = nil,
        orderTotal: Double? = nil,
        orderType: String? = nil,
        packagingCharge: Double? = nil,
        payableAmount: Double? = nil,
        paymentModes: [String]? = nil,
        taxes: [JSONAny]? = nil,
        totalCharges: Double? = nil,
        totalTaxes: Double? = nil,
        totalWeight: Double? = nil,
        walletCreditApplicable: Bool? = nil,
        walletCreditApplied: Double? = nil,
        taxRate: Float? = nil
    ) -> Order {
        return Order(
            applyWalletCredit: applyWalletCredit ?? self.applyWalletCredit,
            bizLocationid: bizLocationid ?? self.bizLocationid,
            channel: channel ?? self.channel,
            charges: charges ?? self.charges,
            deliveryCharge: deliveryCharge ?? self.deliveryCharge,
            discount: discount ?? self.discount,
            itemLevelTotalCharges: itemLevelTotalCharges ?? self.itemLevelTotalCharges,
            itemLevelTotalTaxes: itemLevelTotalTaxes ?? self.itemLevelTotalTaxes,
            itemTaxes: itemTaxes ?? self.itemTaxes,
            items: items ?? self.items,
            orderLevelTotalCharges: orderLevelTotalCharges ?? self.orderLevelTotalCharges,
            orderLevelTotalTaxes: orderLevelTotalTaxes ?? self.orderLevelTotalTaxes,
            orderSubtotal: orderSubtotal ?? self.orderSubtotal,
            orderTotal: orderTotal ?? self.orderTotal,
            orderType: orderType ?? self.orderType,
            packagingCharge: packagingCharge ?? self.packagingCharge,
            payableAmount: payableAmount ?? self.payableAmount,
            paymentModes: paymentModes ?? self.paymentModes,
            taxes: taxes ?? self.taxes,
            totalCharges: totalCharges ?? self.totalCharges,
            totalTaxes: totalTaxes ?? self.totalTaxes,
            totalWeight: totalWeight ?? self.totalWeight,
            walletCreditApplicable: walletCreditApplicable ?? self.walletCreditApplicable,
            walletCreditApplied: walletCreditApplied ?? self.walletCreditApplied,
            taxRate: taxRate ?? self.taxRate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
