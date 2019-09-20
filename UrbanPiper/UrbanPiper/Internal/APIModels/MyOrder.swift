//
//	MyOrder.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import UIKit

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

@objc public class PastOrder: NSObject, JSONDecodable {
    @objc public var address: String!
    public var bizLocationId: Int?
    public var channel: String!
    public var charges: [OrderCharges]!
    @objc public var coupon: String!
    @objc public var created: Int = 0
    public var customerName: String!
    public var deliveryAddressRef: Int?
    @objc public var deliveryDatetime: Int = 0
    public var discount: Decimal!
    @objc public var id: Int = 0
    public var instructions: String!
//    public var itemLevelTotalCharges : Float!
//    public var itemLevelTotalTaxes : Float!
    @objc public var merchantRefId: Int = 0
//    public var orderLevelTotalCharges : Float!
//    public var orderLevelTotalTaxes : Float!
    @objc public var orderState: String!
    @objc public var orderSubtotal: Decimal = 0
    @objc public var orderTotal: Decimal = 0
    public var orderType: String!
    @objc public var paymentOption: String!
    @objc public var phone: String!
    public var taxAmt: Decimal!
//    public var taxRate : Float!
    public var taxes: [AnyObject]!
    public var totalCharges: Float!
    public var totalTaxes: Decimal!
    public var myOrderDetailsResponse: PastOrderDetailsResponse?

//    @objc public var orderSubTotalString: String {
//        return "\(orderSubtotal.stringVal)"
//    }
//
//    @objc public var orderTotalString: String {
//        return "\(orderTotal.stringVal)"
//    }

    public var packagingCharge: Decimal? {
        var charge = charges.filter { $0.title == "Packaging charge" }.last?.value

        if charge == nil {
            charge = charges.filter { $0.title == "Packaging charges" }.last?.value
        }

        return charge
    }

    public var deliveryCharge: Decimal? {
        var charge = charges.filter { $0.title == "Delivery charge" }.last?.value

        if charge == nil {
            charge = charges.filter { $0.title == "Delivery charges" }.last?.value
        }

        return charge
    }

    @objc public var discountDecimalNumber: NSDecimalNumber? {
        guard let val = discount else { return nil }
        return NSDecimalNumber(decimal: val)
    }

    @objc public var packingChargeDecimalNumber: NSDecimalNumber? {
        guard let charge = packagingCharge else { return nil }
        return NSDecimalNumber(decimal: charge)
    }

    @objc public var deliveryChargeDecimalNumber: NSDecimalNumber? {
        guard let charge = deliveryCharge else { return nil }
        return NSDecimalNumber(decimal: charge)
    }

    @objc public var itemTaxesDecimalNumber: NSDecimalNumber? {
        guard let val = totalTaxes else { return nil }
        return NSDecimalNumber(decimal: val)
    }

    @objc public var taxAmtDecimalNumber: NSDecimalNumber? {
        guard let val = taxAmt else { return nil }
        return NSDecimalNumber(decimal: val)
    }

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        address = dictionary["address"] as? String
        bizLocationId = dictionary["biz_location_id"] as? Int
        channel = dictionary["channel"] as? String
        charges = [OrderCharges]()
        if let chargesArray = dictionary["charges"] as? [[String: AnyObject]] {
            for dic in chargesArray {
                guard let value = OrderCharges(fromDictionary: dic) else { continue }
                charges.append(value)
            }
        }
        coupon = dictionary["coupon"] as? String
        created = dictionary["created"] as? Int ?? 0
        customerName = dictionary["customer_name"] as? String
        deliveryAddressRef = dictionary["delivery_address_ref"] as? Int
        deliveryDatetime = dictionary["delivery_datetime"] as? Int ?? 0

        if let val: Decimal = dictionary["discount"] as? Decimal {
            discount = val
        } else if let val: Double = dictionary["discount"] as? Double {
            discount = Decimal(val).rounded
        } else {
            discount = Decimal.zero
        }

        id = dictionary["id"] as? Int ?? 0
        instructions = dictionary["instructions"] as? String
//        itemLevelTotalCharges = dictionary["item_level_total_charges"] as? Float
//        itemLevelTotalTaxes = dictionary["item_level_total_taxes"] as? Float

        if let refId: String = dictionary["merchant_ref_id"] as? String {
            merchantRefId = Int(refId) ?? 0
        } else {
            merchantRefId = dictionary["merchant_ref_id"] as? Int ?? 0
        }

//        orderLevelTotalCharges = dictionary["order_level_total_charges"] as? Float
//        orderLevelTotalTaxes = dictionary["order_level_total_taxes"] as? Float
        orderState = dictionary["order_state"] as? String

        var priceVal: Any = dictionary["order_subtotal"] as Any
        if let val: Decimal = priceVal as? Decimal {
            orderSubtotal = val
        } else if let val: Double = priceVal as? Double {
            orderSubtotal = Decimal(val).rounded
        } else {
            orderSubtotal = Decimal.zero
        }

        priceVal = dictionary["order_total"] as Any
        if let val: Decimal = priceVal as? Decimal {
            orderTotal = val
        } else if let val: Double = priceVal as? Double {
            orderTotal = Decimal(val).rounded
        } else {
            orderTotal = Decimal.zero
        }

        orderType = dictionary["order_type"] as? String
        paymentOption = dictionary["payment_option"] as? String
        phone = dictionary["phone"] as? String

        priceVal = dictionary["tax_amt"] as Any
        if let val: Decimal = priceVal as? Decimal {
            taxAmt = val
        } else if let val: Double = priceVal as? Double {
            taxAmt = Decimal(val).rounded
        } else {
            taxAmt = Decimal.zero
        }

//        taxRate = dictionary["tax_rate"] as? Float
        taxes = dictionary["taxes"] as? [AnyObject]
        totalCharges = dictionary["total_charges"] as? Float

        priceVal = dictionary["total_taxes"] as Any
        if let val: Decimal = priceVal as? Decimal {
            totalTaxes = val
        } else if let val: Double = priceVal as? Double {
            totalTaxes = Decimal(val).rounded
        } else {
            totalTaxes = Decimal.zero
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        if let address = address {
            dictionary["address"] = address as AnyObject
        }
        if let bizLocationId = bizLocationId {
            dictionary["biz_location_id"] = bizLocationId as AnyObject
        }
        if let channel = channel {
            dictionary["channel"] = channel as AnyObject
        }
        if let charges = charges {
            var dictionaryElements = [[String: AnyObject]]()
            for chargesElement in charges {
                dictionaryElements.append(chargesElement.toDictionary())
            }
            dictionary["charges"] = dictionaryElements as AnyObject
        }
        if let coupon = coupon {
            dictionary["coupon"] = coupon as AnyObject
        }
        dictionary["created"] = created as AnyObject
        if let customerName = customerName {
            dictionary["customer_name"] = customerName as AnyObject
        }
        if let deliveryAddressRef = deliveryAddressRef {
            dictionary["delivery_address_ref"] = deliveryAddressRef as AnyObject
        }
        dictionary["delivery_datetime"] = deliveryDatetime as AnyObject
        if let discount = discount {
            dictionary["discount"] = discount as AnyObject
        }
        dictionary["id"] = id as AnyObject
        if let instructions = instructions {
            dictionary["instructions"] = instructions as AnyObject
        }
//        if let itemLevelTotalCharges = itemLevelTotalCharges {
//            dictionary["item_level_total_charges"] = itemLevelTotalCharges as AnyObject
//        }
//        if let itemLevelTotalTaxes = itemLevelTotalTaxes {
//            dictionary["item_level_total_taxes"] = itemLevelTotalTaxes as AnyObject
//        }
        dictionary["merchant_ref_id"] = merchantRefId as AnyObject
//        if let orderLevelTotalCharges = orderLevelTotalCharges {
//            dictionary["order_level_total_charges"] = orderLevelTotalCharges as AnyObject
//        }
//        if let orderLevelTotalTaxes = orderLevelTotalTaxes {
//            dictionary["order_level_total_taxes"] = orderLevelTotalTaxes as AnyObject
//        }
        if let orderState = orderState {
            dictionary["order_state"] = orderState as AnyObject
        }

        dictionary["order_subtotal"] = orderSubtotal as AnyObject

        dictionary["order_total"] = orderTotal as AnyObject

        if let orderType = orderType {
            dictionary["order_type"] = orderType as AnyObject
        }
        if let paymentOption = paymentOption {
            dictionary["payment_option"] = paymentOption as AnyObject
        }
        if let phone = phone {
            dictionary["phone"] = phone as AnyObject
        }
        if let taxAmt = taxAmt {
            dictionary["tax_amt"] = taxAmt as AnyObject
        }
//        if let taxRate = taxRate {
//            dictionary["tax_rate"] = taxRate as AnyObject
//        }
        if let taxes = taxes {
            dictionary["taxes"] = taxes as AnyObject
        }
        if let totalCharges = totalCharges {
            dictionary["total_charges"] = totalCharges as AnyObject
        }
        if let totalTaxes = totalTaxes {
            dictionary["total_taxes"] = totalTaxes as AnyObject
        }
        return dictionary
    }

    /*    /**
        * NSCoding required initializer.
        * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
    address = aDecoder.decodeObject(forKey: "address") as? String
    bizLocationId = aDecoder.decodeObject(forKey: "biz_location_id") as? Int
    channel = aDecoder.decodeObject(forKey: "channel") as? String
    charges = aDecoder.decodeObject(forKey :"charges") as? [Charge]
    coupon = aDecoder.decodeObject(forKey: "coupon") as? String
    created = aDecoder.decodeObject(forKey: "created") as? Int
    customerName = aDecoder.decodeObject(forKey: "customer_name") as? String
    deliveryAddressRef = aDecoder.decodeObject(forKey: "delivery_address_ref") as? Int
    deliveryDatetime = aDecoder.decodeObject(forKey: "delivery_datetime") as? Int
    discount = aDecoder.decodeObject(forKey: "discount") as? Float
    if let val = aDecoder.decodeObject(forKey: "id") as? Int {
    id = val
    } else {
    id = aDecoder.decodeInteger(forKey: "id")
    }
    instructions = aDecoder.decodeObject(forKey: "instructions") as? String
    itemLevelTotalCharges = aDecoder.decodeObject(forKey: "item_level_total_charges") as? Float
    itemLevelTotalTaxes = aDecoder.decodeObject(forKey: "item_level_total_taxes") as? Float
    merchantRefId = aDecoder.decodeObject(forKey: "merchant_ref_id") as? AnyObject
    orderLevelTotalCharges = aDecoder.decodeObject(forKey: "order_level_total_charges") as? Float
    orderLevelTotalTaxes = aDecoder.decodeObject(forKey: "order_level_total_taxes") as? Float
    orderState = aDecoder.decodeObject(forKey: "order_state") as? String
    orderSubtotal = aDecoder.decodeObject(forKey: "order_subtotal") as? Float
    orderTotal = aDecoder.decodeObject(forKey: "order_total") as? Float
    orderType = aDecoder.decodeObject(forKey: "order_type") as? String
    paymentOption = aDecoder.decodeObject(forKey: "payment_option") as? String
    phone = aDecoder.decodeObject(forKey: "phone") as? String
    taxAmt = aDecoder.decodeObject(forKey: "tax_amt") as? Float
    taxRate = aDecoder.decodeObject(forKey: "tax_rate") as? Float
    taxes = aDecoder.decodeObject(forKey: "taxes") as? [AnyObject]
    totalCharges = aDecoder.decodeObject(forKey: "total_charges") as? Float
    totalTaxes = aDecoder.decodeObject(forKey: "total_taxes") as? Float

    }

    /**
        * NSCoding required method.
        * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
    	if let address = address {
    		aCoder.encode(address, forKey: "address")
    	}
    	if let bizLocationId = bizLocationId {
    		aCoder.encode(bizLocationId, forKey: "biz_location_id")
    	}
    	if let channel = channel {
    		aCoder.encode(channel, forKey: "channel")
    	}
    	if let charges = charges {
    		aCoder.encode(charges, forKey: "charges")
    	}
    	if let coupon = coupon {
    		aCoder.encode(coupon, forKey: "coupon")
    	}
    	if let created = created {
    		aCoder.encode(created, forKey: "created")
    	}
    	if let customerName = customerName {
    		aCoder.encode(customerName, forKey: "customer_name")
    	}
    	if let deliveryAddressRef = deliveryAddressRef {
    		aCoder.encode(deliveryAddressRef, forKey: "delivery_address_ref")
    	}
    	if let deliveryDatetime = deliveryDatetime {
    		aCoder.encode(deliveryDatetime, forKey: "delivery_datetime")
    	}
    	if let discount = discount {
    		aCoder.encode(discount, forKey: "discount")
    	}
    	aCoder.encode(id, forKey: "id")
    	if let instructions = instructions {
    		aCoder.encode(instructions, forKey: "instructions")
    	}
    	if let itemLevelTotalCharges = itemLevelTotalCharges {
    		aCoder.encode(itemLevelTotalCharges, forKey: "item_level_total_charges")
    	}
    	if let itemLevelTotalTaxes = itemLevelTotalTaxes {
    		aCoder.encode(itemLevelTotalTaxes, forKey: "item_level_total_taxes")
    	}
    	if let merchantRefId = merchantRefId {
    		aCoder.encode(merchantRefId, forKey: "merchant_ref_id")
    	}
    	if let orderLevelTotalCharges = orderLevelTotalCharges {
    		aCoder.encode(orderLevelTotalCharges, forKey: "order_level_total_charges")
    	}
    	if let orderLevelTotalTaxes = orderLevelTotalTaxes {
    		aCoder.encode(orderLevelTotalTaxes, forKey: "order_level_total_taxes")
    	}
    	if let orderState = orderState {
    		aCoder.encode(orderState, forKey: "order_state")
    	}
    	if let orderSubtotal = orderSubtotal {
    		aCoder.encode(orderSubtotal, forKey: "order_subtotal")
    	}
    	if let orderTotal = orderTotal {
    		aCoder.encode(orderTotal, forKey: "order_total")
    	}
    	if let orderType = orderType {
    		aCoder.encode(orderType, forKey: "order_type")
    	}
    	if let paymentOption = paymentOption {
    		aCoder.encode(paymentOption, forKey: "payment_option")
    	}
    	if let phone = phone {
    		aCoder.encode(phone, forKey: "phone")
    	}
    	if let taxAmt = taxAmt {
    		aCoder.encode(taxAmt, forKey: "tax_amt")
    	}
    	if let taxRate = taxRate {
    		aCoder.encode(taxRate, forKey: "tax_rate")
    	}
    	if let taxes = taxes {
    		aCoder.encode(taxes, forKey: "taxes")
    	}
    	if let totalCharges = totalCharges {
    		aCoder.encode(totalCharges, forKey: "total_charges")
    	}
    	if let totalTaxes = totalTaxes {
    		aCoder.encode(totalTaxes, forKey: "total_taxes")
    	}

    }*/
}
