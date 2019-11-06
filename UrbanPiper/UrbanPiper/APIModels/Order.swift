// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let order = try Order(json)

import Foundation

// MARK: - Order
@objc public class Order: NSObject, JSONDecodable {
    @objc public let applyWalletCredit: Bool
    @objc public let bizLocationid: Int
    @objc public let channel: String
    @objc public let charges: [Charge]
    @objc public let deliveryCharge: Double
    @objc public let discount: Discount?
    @objc public let itemLevelTotalCharges, itemLevelTotalTaxes, itemTaxes: Double
    @objc public let items: [OrderItem]
    @objc public let orderLevelTotalCharges, orderLevelTotalTaxes, orderSubtotal, orderTotal: Double
    @objc public let orderType: String
    @objc public let packagingCharge, payableAmount: Double
    @objc public let paymentModes: [String]?
    @objc public let taxes: [JSONAny]
    @objc public let totalCharges, totalTaxes, totalWeight: Double
    @objc public let walletCreditApplicable: Bool
    @objc public let taxRate: Float
    @objc public let walletCreditApplied: Double

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

    init(applyWalletCredit: Bool, bizLocationid: Int, channel: String, charges: [Charge], deliveryCharge: Double, discount: Discount?, itemLevelTotalCharges: Double, itemLevelTotalTaxes: Double, itemTaxes: Double, items: [OrderItem], orderLevelTotalCharges: Double, orderLevelTotalTaxes: Double, orderSubtotal: Double, orderTotal: Double, orderType: String, packagingCharge: Double, payableAmount: Double, paymentModes: [String]?, taxes: [JSONAny], totalCharges: Double, totalTaxes: Double, totalWeight: Double, walletCreditApplicable: Bool, walletCreditApplied: Double, taxRate: Float) {
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
    
    // This entire method could have been omitted if children is not omitted
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.applyWalletCredit = try values.decode(Bool.self, forKey: .applyWalletCredit)
        self.bizLocationid = try values.decode(Int.self, forKey: .bizLocationid)
        self.channel = try values.decode(String.self, forKey: .channel)
        self.charges = try values.decode([Charge].self, forKey: .charges)
        self.deliveryCharge = try values.decode(Double.self, forKey: .deliveryCharge)
        self.discount = try values.decodeIfPresent(Discount.self, forKey: .discount)
        self.itemLevelTotalCharges = try values.decode(Double.self, forKey: .itemLevelTotalCharges)
        self.itemLevelTotalTaxes = try values.decode(Double.self, forKey: .itemLevelTotalTaxes)
        self.itemTaxes = try values.decode(Double.self, forKey: .itemTaxes)
        self.items = try values.decode([OrderItem].self, forKey: .items)
        self.orderLevelTotalCharges = try values.decode(Double.self, forKey: .orderLevelTotalCharges)
        self.orderLevelTotalTaxes = try values.decode(Double.self, forKey: .orderLevelTotalTaxes)
        self.orderSubtotal = try values.decode(Double.self, forKey: .orderSubtotal)
        self.orderTotal = try values.decode(Double.self, forKey: .orderTotal)
        self.orderType = try values.decode(String.self, forKey: .orderType)
        self.packagingCharge = try values.decode(Double.self, forKey: .packagingCharge)
        self.payableAmount = try values.decode(Double.self, forKey: .payableAmount)
        self.paymentModes = try values.decodeIfPresent([String].self, forKey: .paymentModes)
        self.taxes = try values.decode([JSONAny].self, forKey: .taxes)
        self.totalCharges = try values.decode(Double.self, forKey: .totalCharges)
        self.totalTaxes = try values.decode(Double.self, forKey: .totalTaxes)
        self.totalWeight = try values.decode(Double.self, forKey: .totalWeight)
        self.walletCreditApplicable = try values.decode(Bool.self, forKey: .walletCreditApplicable)
        self.walletCreditApplied = try values.decode(Double.self, forKey: .walletCreditApplied)
        self.taxRate = try values.decodeIfPresent(Float.self, forKey: .taxRate) ?? 0
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
