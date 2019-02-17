//
//	Order.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Order : NSObject{

    public var orderType : String!
    public var cartItems : [AnyObject]!
    public var items : [OrderItem]!
    public var orderSubtotal : Decimal!
    public var packagingCharge : Decimal!
    public var itemTaxes : Decimal!
    public var discount : Discount!
    public var discountApplied : Int!
    public var deliveryCharge : Decimal!
    public var payableAmount : Decimal!
    public var walletCreditApplicable: Bool?
    public var walletCreditApplied : Decimal!
	public var addressId : Int!
	public var addressLat : Float!
	public var addressLng : Float!
    
	public var bizLocationId : Int!
	public var channel : String!
	public var charges : [OrderCharges]!
	public var combos : [AnyObject]!
	public var deliveryDatetime : Int!
	public var itemLevelTotalCharges : Decimal!
//    public var itemLevelTotalTaxes : Float!
	public var orderLevelTotalCharges : Decimal!
//    public var orderLevelTotalTaxes : Float!
	//public var orderTotal : Decimal!
	public var paymentModes : [String]!
	public var paymentOption : String!
	public var taxes : [AnyObject]!
    public var taxRate : Float!
	public var totalWeight : Int!

/* store, order response, instructions, payment option, phone, delivery date, delivery time, coupon code, selected timeslot, payment transaction id */
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		addressId = dictionary["address_id"] as? Int
		addressLat = dictionary["address_lat"] as? Float
		addressLng = dictionary["address_lng"] as? Float
		bizLocationId = dictionary["biz_location_id"] as? Int
		cartItems = dictionary["cartItems"] as? [AnyObject]
		channel = dictionary["channel"] as? String
		charges = [OrderCharges]()
		if let chargesArray: [[String:Any]] = dictionary["charges"] as? [[String:Any]]{
			for dic in chargesArray{
				let value: OrderCharges = OrderCharges(fromDictionary: dic)
				charges.append(value)
			}
		}
		combos = dictionary["combos"] as? [AnyObject]
        
        if let discountData: [String:Any] = dictionary["discount"] as? [String:Any]{
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
		if let itemsArray: [[String:Any]] = dictionary["items"] as? [[String:Any]]{
			for dic in itemsArray{
				let value: OrderItem = OrderItem(fromDictionary: dic)
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
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if addressId != nil{
//            dictionary["address_id"] = addressId
//        }
//        if addressLat != nil{
//            dictionary["address_lat"] = addressLat
//        }
//        if addressLng != nil{
//            dictionary["address_lng"] = addressLng
//        }
//        if bizLocationId != nil{
//            dictionary["biz_location_id"] = bizLocationId
//        }
//        if cartItems != nil{
//            dictionary["cartItems"] = cartItems
//        }
//        if channel != nil{
//            dictionary["channel"] = channel
//        }
//        if charges != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for chargesElement in charges {
//                dictionaryElements.append(chargesElement.toDictionary())
//            }
//            dictionary["charges"] = dictionaryElements
//        }
//        if combos != nil{
//            dictionary["combos"] = combos
//        }
//        if discount != nil{
//            dictionary["discount"] = discount.toDictionary()
//        }
//        if deliveryCharge != nil{
//            dictionary["delivery_charge"] = deliveryCharge
//        }
//        if packagingCharge != nil{
//            dictionary["packaging_charge"] = packagingCharge
//        }
//        if deliveryDatetime != nil{
//            dictionary["delivery_datetime"] = deliveryDatetime
//        }
//        if discountApplied != nil{
//            dictionary["discount_applied"] = discountApplied
//        }
//        if itemLevelTotalCharges != nil{
//            dictionary["item_level_total_charges"] = itemLevelTotalCharges
//        }
//        if itemLevelTotalTaxes != nil{
//            dictionary["item_level_total_taxes"] = itemLevelTotalTaxes
//        }
//        if itemTaxes != nil{
//            dictionary["item_taxes"] = itemTaxes
//        }
//        if items != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for itemsElement in items {
//                dictionaryElements.append(itemsElement.toDictionary())
//            }
//            dictionary["items"] = dictionaryElements
//        }
//        if orderLevelTotalCharges != nil{
//            dictionary["order_level_total_charges"] = orderLevelTotalCharges
//        }
//        if orderLevelTotalTaxes != nil{
//            dictionary["order_level_total_taxes"] = orderLevelTotalTaxes
//        }
//        if orderSubtotal != nil{
//            dictionary["order_subtotal"] = orderSubtotal
//        }
////        if orderTotal != nil{
////            dictionary["order_total"] = orderTotal
////        }
//        if orderType != nil{
//            dictionary["order_type"] = orderType
//        }
//        if payableAmount != nil{
//            dictionary["payable_amount"] = payableAmount
//        }
//        if walletCreditApplied != nil{
//            dictionary["wallet_credit_applied"] = walletCreditApplied
//        }
//        if paymentModes != nil{
//            dictionary["payment_modes"] = paymentModes
//        }
//        if paymentOption != nil{
//            dictionary["payment_option"] = paymentOption
//        }
//        if taxes != nil{
//            dictionary["taxes"] = taxes
//        }
//        if taxRate != nil{
//            dictionary["tax_rate"] = taxRate
//        }
//        if totalWeight != nil{
//            dictionary["total_weight"] = totalWeight
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
//        if addressId != nil{
//            aCoder.encode(addressId, forKey: "address_id")
//        }
//        if addressLat != nil{
//            aCoder.encode(addressLat, forKey: "address_lat")
//        }
//        if addressLng != nil{
//            aCoder.encode(addressLng, forKey: "address_lng")
//        }
//        if bizLocationId != nil{
//            aCoder.encode(bizLocationId, forKey: "biz_location_id")
//        }
//        if cartItems != nil{
//            aCoder.encode(cartItems, forKey: "cartItems")
//        }
//        if channel != nil{
//            aCoder.encode(channel, forKey: "channel")
//        }
//        if charges != nil{
//            aCoder.encode(charges, forKey: "charges")
//        }
//        if combos != nil{
//            aCoder.encode(combos, forKey: "combos")
//        }
//        if discount != nil{
//            aCoder.encode(discount, forKey: "discount")
//        }
//        if deliveryCharge != nil{
//            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
//        }
//        if packagingCharge != nil{
//            aCoder.encode(packagingCharge, forKey: "packaging_charge")
//        }
//        if deliveryDatetime != nil{
//            aCoder.encode(deliveryDatetime, forKey: "delivery_datetime")
//        }
//        if discountApplied != nil{
//            aCoder.encode(discountApplied, forKey: "discount_applied")
//        }
//        if itemLevelTotalCharges != nil{
//            aCoder.encode(itemLevelTotalCharges, forKey: "item_level_total_charges")
//        }
//        if itemLevelTotalTaxes != nil{
//            aCoder.encode(itemLevelTotalTaxes, forKey: "item_level_total_taxes")
//        }
//        if itemTaxes != nil{
//            aCoder.encode(itemTaxes, forKey: "item_taxes")
//        }
//        if items != nil{
//            aCoder.encode(items, forKey: "items")
//        }
//        if orderLevelTotalCharges != nil{
//            aCoder.encode(orderLevelTotalCharges, forKey: "order_level_total_charges")
//        }
//        if orderLevelTotalTaxes != nil{
//            aCoder.encode(orderLevelTotalTaxes, forKey: "order_level_total_taxes")
//        }
//        if orderSubtotal != nil{
//            aCoder.encode(orderSubtotal, forKey: "order_subtotal")
//        }
////        if orderTotal != nil{
////            aCoder.encode(orderTotal, forKey: "order_total")
////        }
//        if orderType != nil{
//            aCoder.encode(orderType, forKey: "order_type")
//        }
//        if payableAmount != nil{
//            aCoder.encode(payableAmount, forKey: "payable_amount")
//        }
//        if walletCreditApplied != nil{
//            aCoder.encode(walletCreditApplied, forKey: "wallet_credit_applied")
//        }
//        if paymentModes != nil{
//            aCoder.encode(paymentModes, forKey: "payment_modes")
//        }
//        if paymentOption != nil{
//            aCoder.encode(paymentOption, forKey: "payment_option")
//        }
//        if taxes != nil{
//            aCoder.encode(taxes, forKey: "taxes")
//        }
//        if taxRate != nil{
//            aCoder.encode(taxRate, forKey: "tax_rate")
//        }
//        if totalWeight != nil{
//            aCoder.encode(totalWeight, forKey: "total_weight")
//        }
//
//    }

}
