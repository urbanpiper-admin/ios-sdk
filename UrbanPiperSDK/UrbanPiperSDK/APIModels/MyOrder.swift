//
//	MyOrder.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import UIKit

public enum OrderStatus: String {
    case cancelled = "cancelled"
    case expired = "expired"
    case completed = "completed"
    case placed = "placed"
    case acknowledged = "acknowledged"
    case dispatched = "dispatched"
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

@objc public class PastOrder : NSObject{

	public var address : String!
	public var bizLocationId : Int!
	public var channel : String!
	public var charges : [Charge]!
	@objc public var coupon : String!
	@objc public var created : Int = 0
	public var customerName : String!
	public var deliveryAddressRef : Int!
	@objc public var deliveryDatetime : Int = 0
	public var discount : Decimal!
	@objc public var id : Int = 0
	public var instructions : String!
	public var itemLevelTotalCharges : Float!
	public var itemLevelTotalTaxes : Float!
	@objc public var merchantRefId : Int = 0
	public var orderLevelTotalCharges : Float!
	public var orderLevelTotalTaxes : Float!
	@objc public var orderState : String!
	public var orderSubtotal : Decimal!
	public var orderTotal : Decimal!
	public var orderType : String!
	public var paymentOption : String!
	@objc public var phone : String!
	public var taxAmt : Decimal!
	public var taxRate : Float!
	public var taxes : [AnyObject]!
	public var totalCharges : Float!
	public var totalTaxes : Decimal!
    public var myOrderDetailsResponse: PastOrderDetailsResponse?


    @objc public var orderSubTotalString: String {
        return "\(orderSubtotal.stringVal)"
    }
    
    @objc public var orderTotalString: String {
        return "\(orderTotal.stringVal)"
    }
    
    public var packagingCharge: Decimal? {
        return charges.filter({ $0.title == "Packaging charge" }).last?.value
    }
    
    public var deliveryCharge: Decimal? {
        return charges.filter({ $0.title == "Delivery charge" }).last?.value
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
	init(fromDictionary dictionary: [String:Any]){
		address = dictionary["address"] as? String
		bizLocationId = dictionary["biz_location_id"] as? Int
		channel = dictionary["channel"] as? String
		charges = [Charge]()
		if let chargesArray = dictionary["charges"] as? [[String:Any]]{
			for dic in chargesArray{
				let value = Charge(fromDictionary: dic)
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
		itemLevelTotalCharges = dictionary["item_level_total_charges"] as? Float
		itemLevelTotalTaxes = dictionary["item_level_total_taxes"] as? Float
        
        if let refId: String = dictionary["merchant_ref_id"] as? String {
            merchantRefId = Int(refId) ?? 0
        } else {
            merchantRefId = dictionary["merchant_ref_id"] as? Int ?? 0
        }
        
		orderLevelTotalCharges = dictionary["order_level_total_charges"] as? Float
		orderLevelTotalTaxes = dictionary["order_level_total_taxes"] as? Float
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
        
		taxRate = dictionary["tax_rate"] as? Float
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
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()
		if address != nil{
			dictionary["address"] = address
		}
		if bizLocationId != nil{
			dictionary["biz_location_id"] = bizLocationId
		}
		if channel != nil{
			dictionary["channel"] = channel
		}
		if charges != nil{
            var dictionaryElements = [[String:Any]]()
			for chargesElement in charges {
				dictionaryElements.append(chargesElement.toDictionary())
			}
			dictionary["charges"] = dictionaryElements
		}
		if coupon != nil{
			dictionary["coupon"] = coupon
		}
        dictionary["created"] = created
		if customerName != nil{
			dictionary["customer_name"] = customerName
		}
		if deliveryAddressRef != nil{
			dictionary["delivery_address_ref"] = deliveryAddressRef
		}
        dictionary["delivery_datetime"] = deliveryDatetime
		if discount != nil{
			dictionary["discount"] = discount
		}
        dictionary["id"] = id
		if instructions != nil{
			dictionary["instructions"] = instructions
		}
		if itemLevelTotalCharges != nil{
			dictionary["item_level_total_charges"] = itemLevelTotalCharges
		}
		if itemLevelTotalTaxes != nil{
			dictionary["item_level_total_taxes"] = itemLevelTotalTaxes
		}
        dictionary["merchant_ref_id"] = merchantRefId
		if orderLevelTotalCharges != nil{
			dictionary["order_level_total_charges"] = orderLevelTotalCharges
		}
		if orderLevelTotalTaxes != nil{
			dictionary["order_level_total_taxes"] = orderLevelTotalTaxes
		}
		if orderState != nil{
			dictionary["order_state"] = orderState
		}
		if orderSubtotal != nil{
			dictionary["order_subtotal"] = orderSubtotal
		}
		if orderTotal != nil{
			dictionary["order_total"] = orderTotal
		}
		if orderType != nil{
			dictionary["order_type"] = orderType
		}
		if paymentOption != nil{
			dictionary["payment_option"] = paymentOption
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if taxAmt != nil{
			dictionary["tax_amt"] = taxAmt
		}
		if taxRate != nil{
			dictionary["tax_rate"] = taxRate
		}
		if taxes != nil{
			dictionary["taxes"] = taxes
		}
		if totalCharges != nil{
			dictionary["total_charges"] = totalCharges
		}
		if totalTaxes != nil{
			dictionary["total_taxes"] = totalTaxes
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
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
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if bizLocationId != nil{
			aCoder.encode(bizLocationId, forKey: "biz_location_id")
		}
		if channel != nil{
			aCoder.encode(channel, forKey: "channel")
		}
		if charges != nil{
			aCoder.encode(charges, forKey: "charges")
		}
		if coupon != nil{
			aCoder.encode(coupon, forKey: "coupon")
		}
		if created != nil{
			aCoder.encode(created, forKey: "created")
		}
		if customerName != nil{
			aCoder.encode(customerName, forKey: "customer_name")
		}
		if deliveryAddressRef != nil{
			aCoder.encode(deliveryAddressRef, forKey: "delivery_address_ref")
		}
		if deliveryDatetime != nil{
			aCoder.encode(deliveryDatetime, forKey: "delivery_datetime")
		}
		if discount != nil{
			aCoder.encode(discount, forKey: "discount")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if instructions != nil{
			aCoder.encode(instructions, forKey: "instructions")
		}
		if itemLevelTotalCharges != nil{
			aCoder.encode(itemLevelTotalCharges, forKey: "item_level_total_charges")
		}
		if itemLevelTotalTaxes != nil{
			aCoder.encode(itemLevelTotalTaxes, forKey: "item_level_total_taxes")
		}
		if merchantRefId != nil{
			aCoder.encode(merchantRefId, forKey: "merchant_ref_id")
		}
		if orderLevelTotalCharges != nil{
			aCoder.encode(orderLevelTotalCharges, forKey: "order_level_total_charges")
		}
		if orderLevelTotalTaxes != nil{
			aCoder.encode(orderLevelTotalTaxes, forKey: "order_level_total_taxes")
		}
		if orderState != nil{
			aCoder.encode(orderState, forKey: "order_state")
		}
		if orderSubtotal != nil{
			aCoder.encode(orderSubtotal, forKey: "order_subtotal")
		}
		if orderTotal != nil{
			aCoder.encode(orderTotal, forKey: "order_total")
		}
		if orderType != nil{
			aCoder.encode(orderType, forKey: "order_type")
		}
		if paymentOption != nil{
			aCoder.encode(paymentOption, forKey: "payment_option")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if taxAmt != nil{
			aCoder.encode(taxAmt, forKey: "tax_amt")
		}
		if taxRate != nil{
			aCoder.encode(taxRate, forKey: "tax_rate")
		}
		if taxes != nil{
			aCoder.encode(taxes, forKey: "taxes")
		}
		if totalCharges != nil{
			aCoder.encode(totalCharges, forKey: "total_charges")
		}
		if totalTaxes != nil{
			aCoder.encode(totalTaxes, forKey: "total_taxes")
		}

	}*/

}
