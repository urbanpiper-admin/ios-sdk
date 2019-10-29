//
//	Order.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class Order: NSObject, JSONDecodable {
    public var orderType: String!
    public var cartItems: [AnyObject]!
    public var items: [OrderItem]!
    public var orderSubtotal: Decimal!
    public var packagingCharge: Decimal!
    public var itemTaxes: Decimal!
    public var discount: Discount?
    public var discountApplied: Int?
    public var deliveryCharge: Decimal!
    public var payableAmount: Decimal!
    public var walletCreditApplicable: Bool?
    public var walletCreditApplied: Decimal!
    public var addressId: Int?
    public var addressLat: Float!
    public var addressLng: Float!

    public var bizLocationId: Int?
    public var channel: String!
    public var charges: [OrderCharges]!
    public var combos: [AnyObject]!
    public var deliveryDatetime: Int?
    public var itemLevelTotalCharges: Decimal!
//    public var itemLevelTotalTaxes : Float!
    public var orderLevelTotalCharges: Decimal!
//    public var orderLevelTotalTaxes : Float!
    // public var orderTotal : Decimal!
    public var paymentModes: [String]?
    public var paymentOption: String!
    public var taxes: [AnyObject]!
    public var taxRate: Float!
    public var totalWeight: Int?

    /* store, order response, instructions, payment option, phone, delivery date, delivery time, coupon code, selected timeslot, payment transaction id */
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        addressId = dictionary["address_id"] as? Int
        addressLat = dictionary["address_lat"] as? Float
        addressLng = dictionary["address_lng"] as? Float
        bizLocationId = dictionary["biz_location_id"] as? Int
        cartItems = dictionary["cartItems"] as? [AnyObject]
        channel = dictionary["channel"] as? String
        charges = [OrderCharges]()
        if let chargesArray: [[String: AnyObject]] = dictionary["charges"] as? [[String: AnyObject]] {
            for dic in chargesArray {
                guard let value: OrderCharges = OrderCharges(fromDictionary: dic) else { continue }
                charges.append(value)
            }
        }
        combos = dictionary["combos"] as? [AnyObject]

        if let discountData: [String: AnyObject] = dictionary["discount"] as? [String: AnyObject] {
            discount = Discount(fromDictionary: discountData)
        }

        var priceVal: Any? = dictionary["delivery_charge"]
        if let val: Decimal = priceVal as? Decimal {
            deliveryCharge = val
        } else if let val: Double = priceVal as? Double {
            deliveryCharge = Decimal(val).rounded
        } else {
            deliveryCharge = Decimal.zero
        }

        priceVal = dictionary["packaging_charge"]
        if let val: Decimal = priceVal as? Decimal {
            packagingCharge = val
        } else if let val: Double = priceVal as? Double {
            packagingCharge = Decimal(val).rounded
        } else {
            packagingCharge = Decimal.zero
        }

        deliveryDatetime = dictionary["delivery_datetime"] as? Int
        discountApplied = dictionary["discount_applied"] as? Int

        priceVal = dictionary["item_level_total_charges"]
        if let val: Decimal = priceVal as? Decimal {
            itemLevelTotalCharges = val
        } else if let val: Double = priceVal as? Double {
            itemLevelTotalCharges = Decimal(val).rounded
        } else {
            itemLevelTotalCharges = Decimal.zero
        }

//        itemLevelTotalTaxes = dictionary["item_level_total_taxes"] as? Float

        priceVal = dictionary["item_taxes"]
        if let val: Decimal = priceVal as? Decimal {
            itemTaxes = val
        } else if let val: Double = priceVal as? Double {
            itemTaxes = Decimal(val).rounded
        } else {
            itemTaxes = Decimal.zero
        }

        items = [OrderItem]()
        if let itemsArray: [[String: AnyObject]] = dictionary["items"] as? [[String: AnyObject]] {
            for dic in itemsArray {
                guard let value: OrderItem = OrderItem(fromDictionary: dic) else { continue }
                items.append(value)
            }
        }

        priceVal = dictionary["order_level_total_charges"]
        if let val: Decimal = priceVal as? Decimal {
            orderLevelTotalCharges = val
        } else if let val: Double = priceVal as? Double {
            orderLevelTotalCharges = Decimal(val).rounded
        } else {
            orderLevelTotalCharges = Decimal.zero
        }

//        orderLevelTotalTaxes = dictionary["order_level_total_taxes"] as? Float

        priceVal = dictionary["order_subtotal"]
        if let val: Decimal = priceVal as? Decimal {
            orderSubtotal = val
        } else if let val: Double = priceVal as? Double {
            orderSubtotal = Decimal(val).rounded
        } else {
            orderSubtotal = Decimal.zero
        }

//        priceVal = dictionary["order_total"]
//        if let val: Decimal = priceVal as? Decimal {
//            orderTotal = val
//        } else if let val: Double = priceVal as? Double {
//            orderTotal = Decimal(val).rounded
//        } else {
//            orderTotal = Decimal.zero
//        }

        orderType = dictionary["order_type"] as? String

        priceVal = dictionary["payable_amount"]
        if let val: Decimal = priceVal as? Decimal {
            payableAmount = val
        } else if let val: Double = priceVal as? Double {
            payableAmount = Decimal(val).rounded
        } else {
            payableAmount = Decimal.zero
        }

        walletCreditApplicable = dictionary["wallet_credit_applicable"] as? Bool

        priceVal = dictionary["wallet_credit_applied"]
        if let val: Decimal = priceVal as? Decimal {
            walletCreditApplied = val
        } else if let val: Double = priceVal as? Double {
            walletCreditApplied = Decimal(val).rounded
        } else {
            walletCreditApplied = Decimal.zero
        }

        paymentModes = dictionary["payment_modes"] as? [String]
        paymentOption = dictionary["payment_option"] as? String
        taxes = dictionary["taxes"] as? [AnyObject]
        taxRate = dictionary["tax_rate"] as? Float
        totalWeight = dictionary["total_weight"] as? Int
    }

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let addressId = addressId {
//            dictionary["address_id"] = addressId as AnyObject
//        }
//        if let addressLat = addressLat {
//            dictionary["address_lat"] = addressLat as AnyObject
//        }
//        if let addressLng = addressLng {
//            dictionary["address_lng"] = addressLng as AnyObject
//        }
//        if let bizLocationId = bizLocationId {
//            dictionary["biz_location_id"] = bizLocationId as AnyObject
//        }
//        if let cartItems = cartItems {
//            dictionary["cartItems"] = cartItems as AnyObject
//        }
//        if let channel = channel {
//            dictionary["channel"] = channel as AnyObject
//        }
//        if let charges = charges {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for chargesElement in charges {
//                dictionaryElements.append(chargesElement.toDictionary())
//            }
//            dictionary["charges"] = dictionaryElements as AnyObject
//        }
//        if let combos = combos {
//            dictionary["combos"] = combos as AnyObject
//        }
//        if let discount = discount {
//            dictionary["discount"] = discount.toDictionary() as AnyObject
//        }
//        if let deliveryCharge = deliveryCharge {
//            dictionary["delivery_charge"] = deliveryCharge as AnyObject
//        }
//        if let packagingCharge = packagingCharge {
//            dictionary["packaging_charge"] = packagingCharge as AnyObject
//        }
//        if let deliveryDatetime = deliveryDatetime {
//            dictionary["delivery_datetime"] = deliveryDatetime as AnyObject
//        }
//        if let discountApplied = discountApplied {
//            dictionary["discount_applied"] = discountApplied as AnyObject
//        }
//        if let itemLevelTotalCharges = itemLevelTotalCharges {
//            dictionary["item_level_total_charges"] = itemLevelTotalCharges as AnyObject
//        }
//        if let itemLevelTotalTaxes = itemLevelTotalTaxes {
//            dictionary["item_level_total_taxes"] = itemLevelTotalTaxes as AnyObject
//        }
//        if let itemTaxes = itemTaxes {
//            dictionary["item_taxes"] = itemTaxes as AnyObject
//        }
//        if let items = items {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for itemsElement in items {
//                dictionaryElements.append(itemsElement.toDictionary())
//            }
//            dictionary["items"] = dictionaryElements as AnyObject
//        }
//        if let orderLevelTotalCharges = orderLevelTotalCharges {
//            dictionary["order_level_total_charges"] = orderLevelTotalCharges as AnyObject
//        }
//        if let orderLevelTotalTaxes = orderLevelTotalTaxes {
//            dictionary["order_level_total_taxes"] = orderLevelTotalTaxes as AnyObject
//        }
//        if let orderSubtotal = orderSubtotal {
//            dictionary["order_subtotal"] = orderSubtotal as AnyObject
//        }
    ////        if let orderTotal = orderTotal {
    ////            dictionary["order_total"] = orderTotal as AnyObject
    ////        }
//        if let orderType = orderType {
//            dictionary["order_type"] = orderType as AnyObject
//        }
//        if let payableAmount = payableAmount {
//            dictionary["payable_amount"] = payableAmount as AnyObject
//        }
//        if let walletCreditApplied = walletCreditApplied {
//            dictionary["wallet_credit_applied"] = walletCreditApplied as AnyObject
//        }
//        if let paymentModes = paymentModes {
//            dictionary["payment_modes"] = paymentModes as AnyObject
//        }
//        if let paymentOption = paymentOption {
//            dictionary["payment_option"] = paymentOption as AnyObject
//        }
//        if let taxes = taxes {
//            dictionary["taxes"] = taxes as AnyObject
//        }
//        if let taxRate = taxRate {
//            dictionary["tax_rate"] = taxRate as AnyObject
//        }
//        if let totalWeight = totalWeight {
//            dictionary["total_weight"] = totalWeight as AnyObject
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         addressId = aDecoder.decodeObject(forKey: "address_id") as? Int
//         addressLat = aDecoder.decodeObject(forKey: "address_lat") as? Float
//         addressLng = aDecoder.decodeObject(forKey: "address_lng") as? Float
//         bizLocationId = aDecoder.decodeObject(forKey: "biz_location_id") as? Int
//         cartItems = aDecoder.decodeObject(forKey: "cartItems") as? [AnyObject]
//         channel = aDecoder.decodeObject(forKey: "channel") as? String
//         charges = aDecoder.decodeObject(forKey :"charges") as? [OrderCharges]
//         combos = aDecoder.decodeObject(forKey: "combos") as? [AnyObject]
//        discount = aDecoder.decodeObject(forKey: "discount") as? Discount
//         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? Decimal
//        packagingCharge = aDecoder.decodeObject(forKey: "packaging_charge") as? Decimal
//         deliveryDatetime = aDecoder.decodeObject(forKey: "delivery_datetime") as? Int
//         discountApplied = aDecoder.decodeObject(forKey: "discount_applied") as? Int
//         itemLevelTotalCharges = aDecoder.decodeObject(forKey: "item_level_total_charges") as? Decimal
//         itemLevelTotalTaxes = aDecoder.decodeObject(forKey: "item_level_total_taxes") as? Float
//         itemTaxes = aDecoder.decodeObject(forKey: "item_taxes") as? Decimal
//         items = aDecoder.decodeObject(forKey :"items") as? [OrderItem]
//         orderLevelTotalCharges = aDecoder.decodeObject(forKey: "order_level_total_charges") as? Decimal
//         orderLevelTotalTaxes = aDecoder.decodeObject(forKey: "order_level_total_taxes") as? Float
//         orderSubtotal = aDecoder.decodeObject(forKey: "order_subtotal") as? Decimal
    ////         orderTotal = aDecoder.decodeObject(forKey: "order_total") as? Decimal
//         orderType = aDecoder.decodeObject(forKey: "order_type") as? String
//         payableAmount = aDecoder.decodeObject(forKey: "payable_amount") as? Decimal
//        walletCreditApplied = aDecoder.decodeObject(forKey: "wallet_credit_applied") as? Decimal
//         paymentModes = aDecoder.decodeObject(forKey: "payment_modes") as? [String]
//         paymentOption = aDecoder.decodeObject(forKey: "payment_option") as? String
//         taxes = aDecoder.decodeObject(forKey: "taxes") as? [AnyObject]
//        taxRate = aDecoder.decodeObject(forKey: "tax_rate") as? Float
//         totalWeight = aDecoder.decodeObject(forKey: "total_weight") as? Int
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let addressId = addressId {
//            aCoder.encode(addressId, forKey: "address_id")
//        }
//        if let addressLat = addressLat {
//            aCoder.encode(addressLat, forKey: "address_lat")
//        }
//        if let addressLng = addressLng {
//            aCoder.encode(addressLng, forKey: "address_lng")
//        }
//        if let bizLocationId = bizLocationId {
//            aCoder.encode(bizLocationId, forKey: "biz_location_id")
//        }
//        if let cartItems = cartItems {
//            aCoder.encode(cartItems, forKey: "cartItems")
//        }
//        if let channel = channel {
//            aCoder.encode(channel, forKey: "channel")
//        }
//        if let charges = charges {
//            aCoder.encode(charges, forKey: "charges")
//        }
//        if let combos = combos {
//            aCoder.encode(combos, forKey: "combos")
//        }
//        if let discount = discount {
//            aCoder.encode(discount, forKey: "discount")
//        }
//        if let deliveryCharge = deliveryCharge {
//            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
//        }
//        if let packagingCharge = packagingCharge {
//            aCoder.encode(packagingCharge, forKey: "packaging_charge")
//        }
//        if let deliveryDatetime = deliveryDatetime {
//            aCoder.encode(deliveryDatetime, forKey: "delivery_datetime")
//        }
//        if let discountApplied = discountApplied {
//            aCoder.encode(discountApplied, forKey: "discount_applied")
//        }
//        if let itemLevelTotalCharges = itemLevelTotalCharges {
//            aCoder.encode(itemLevelTotalCharges, forKey: "item_level_total_charges")
//        }
//        if let itemLevelTotalTaxes = itemLevelTotalTaxes {
//            aCoder.encode(itemLevelTotalTaxes, forKey: "item_level_total_taxes")
//        }
//        if let itemTaxes = itemTaxes {
//            aCoder.encode(itemTaxes, forKey: "item_taxes")
//        }
//        if let items = items {
//            aCoder.encode(items, forKey: "items")
//        }
//        if let orderLevelTotalCharges = orderLevelTotalCharges {
//            aCoder.encode(orderLevelTotalCharges, forKey: "order_level_total_charges")
//        }
//        if let orderLevelTotalTaxes = orderLevelTotalTaxes {
//            aCoder.encode(orderLevelTotalTaxes, forKey: "order_level_total_taxes")
//        }
//        if let orderSubtotal = orderSubtotal {
//            aCoder.encode(orderSubtotal, forKey: "order_subtotal")
//        }
    ////        if let orderTotal = orderTotal {
    ////            aCoder.encode(orderTotal, forKey: "order_total")
    ////        }
//        if let orderType = orderType {
//            aCoder.encode(orderType, forKey: "order_type")
//        }
//        if let payableAmount = payableAmount {
//            aCoder.encode(payableAmount, forKey: "payable_amount")
//        }
//        if let walletCreditApplied = walletCreditApplied {
//            aCoder.encode(walletCreditApplied, forKey: "wallet_credit_applied")
//        }
//        if let paymentModes = paymentModes {
//            aCoder.encode(paymentModes, forKey: "payment_modes")
//        }
//        if let paymentOption = paymentOption {
//            aCoder.encode(paymentOption, forKey: "payment_option")
//        }
//        if let taxes = taxes {
//            aCoder.encode(taxes, forKey: "taxes")
//        }
//        if let taxRate = taxRate {
//            aCoder.encode(taxRate, forKey: "tax_rate")
//        }
//        if let totalWeight = totalWeight {
//            aCoder.encode(totalWeight, forKey: "total_weight")
//        }
//
//    }
}
