//
//	MyOrderExtra.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

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
            return UIColor(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1.0)
        case .expired:
            return UIColor(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1.0)
        case .completed:
            return UIColor(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1.0)
        case .placed:
            return UIColor(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1.0)
        case .acknowledged:
            return UIColor(red: 0.1607843137, green: 0.5019607843, blue: 0.7254901961, alpha: 1.0)
        case .dispatched:
            return UIColor(red: 0.0862745098, green: 0.6274509804, blue: 0.5215686275, alpha: 1.0)
        case .awaitingPayment:
            return UIColor(red: 0.0862745098, green: 0.6274509804, blue: 0.5215686275, alpha: 1.0)
        }
    }
    
}

public class MyOrderExtra : NSObject{

	public var address : String!
	public var amount : Decimal!
	public var charges : [MyOrderCharge]!
	public var coupon : AnyObject!
	public var currency : String!
	public var deliveryTime : Int!
	public var deliveryType : String!
	public var discount : Decimal!
	public var id : Int!
	public var itemLevelTotalCharges : Float!
	public var itemLevelTotalTaxes : Float!
	public var itemTax : Decimal!
	public var items : [MyOrderItem]!
	public var merchantRefId : Int!
	public var orderLevelTotalCharges : Float!
	public var orderLevelTotalTaxes : Float!
	public var paymentMode : String!
	public var phone : String!
	public var status : String!
	public var store : MyOrderStore!
	public var subtotal : Decimal!
	public var tax : Decimal!
	public var taxes : [AnyObject]!
	public var timeSlotEnd : AnyObject!
	public var timeSlotStart : AnyObject!
	public var totalCharges : Float!
	public var totalTaxes : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		address = dictionary["address"] as? String
        
        if let val: Decimal = dictionary["amount"] as? Decimal {
            amount = val
        } else if let val: Double = dictionary["amount"] as? Double {
            amount = Decimal(val).rounded
        } else {
            amount = Decimal.zero
        }
        
		charges = [MyOrderCharge]()
		if let chargesArray: [[String:Any]] = dictionary["charges"] as? [[String:Any]]{
			for dic in chargesArray{
				let value: MyOrderCharge = MyOrderCharge(fromDictionary: dic)
				charges.append(value)
			}
		}
        
		coupon = dictionary["coupon"] as AnyObject
		currency = dictionary["currency"] as? String
		deliveryTime = dictionary["delivery_time"] as? Int
		deliveryType = dictionary["delivery_type"] as? String
        
        if let val: Decimal = dictionary["discount"] as? Decimal {
            discount = val
        } else if let val: Double = dictionary["discount"] as? Double {
            discount = Decimal(val).rounded
        } else {
            discount = Decimal.zero
        }
        
		id = dictionary["id"] as? Int
		itemLevelTotalCharges = dictionary["item_level_total_charges"] as? Float
		itemLevelTotalTaxes = dictionary["item_level_total_taxes"] as? Float
     
        if let val: Decimal = dictionary["item_tax"] as? Decimal {
            itemTax = val
        } else if let val: Double = dictionary["item_tax"] as? Double {
            itemTax = Decimal(val).rounded
        } else {
            itemTax = Decimal.zero
        }
        
		items = [MyOrderItem]()
		if let itemsArray: [[String:Any]] = dictionary["items"] as? [[String:Any]]{
			for dic in itemsArray{
				let value: MyOrderItem = MyOrderItem(fromDictionary: dic)
				items.append(value)
			}
		}
		merchantRefId = dictionary["merchant_ref_id"] as? Int
		orderLevelTotalCharges = dictionary["order_level_total_charges"] as? Float
		orderLevelTotalTaxes = dictionary["order_level_total_taxes"] as? Float
		paymentMode = dictionary["payment_mode"] as? String
		phone = dictionary["phone"] as? String
		status = dictionary["status"] as? String
		if let storeData: [String:Any] = dictionary["store"] as? [String:Any]{
			store = MyOrderStore(fromDictionary: storeData)
		}
   
        if let val: Decimal = dictionary["subtotal"] as? Decimal {
            subtotal = val
        } else if let val: Double = dictionary["subtotal"] as? Double {
            subtotal = Decimal(val).rounded
        } else {
            subtotal = Decimal.zero
        }
        
        if let val: Decimal = dictionary["tax"] as? Decimal {
            tax = val
        } else if let val: Double = dictionary["tax"] as? Double {
            tax = Decimal(val).rounded
        } else {
            tax = Decimal.zero
        }
        
		taxes = dictionary["taxes"] as? [AnyObject]
		timeSlotEnd = dictionary["time_slot_end"] as AnyObject
		timeSlotStart = dictionary["time_slot_start"] as AnyObject
		totalCharges = dictionary["total_charges"] as? Float
		totalTaxes = dictionary["total_taxes"] as? Float
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if address != nil{
//            dictionary["address"] = address
//        }
//        if amount != nil{
//            dictionary["amount"] = amount
//        }
//        if charges != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for chargesElement in charges {
//                dictionaryElements.append(chargesElement.toDictionary())
//            }
//            dictionary["charges"] = dictionaryElements
//        }
//        if coupon != nil{
//            dictionary["coupon"] = coupon
//        }
//        if currency != nil{
//            dictionary["currency"] = currency
//        }
//        if deliveryTime != nil{
//            dictionary["delivery_time"] = deliveryTime
//        }
//        if deliveryType != nil{
//            dictionary["delivery_type"] = deliveryType
//        }
//        if discount != nil{
//            dictionary["discount"] = discount
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if itemLevelTotalCharges != nil{
//            dictionary["item_level_total_charges"] = itemLevelTotalCharges
//        }
//        if itemLevelTotalTaxes != nil{
//            dictionary["item_level_total_taxes"] = itemLevelTotalTaxes
//        }
//        if itemTax != nil{
//            dictionary["item_tax"] = itemTax
//        }
//        if items != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for itemsElement in items {
//                dictionaryElements.append(itemsElement.toDictionary())
//            }
//            dictionary["items"] = dictionaryElements
//        }
//        if merchantRefId != nil{
//            dictionary["merchant_ref_id"] = merchantRefId
//        }
//        if orderLevelTotalCharges != nil{
//            dictionary["order_level_total_charges"] = orderLevelTotalCharges
//        }
//        if orderLevelTotalTaxes != nil{
//            dictionary["order_level_total_taxes"] = orderLevelTotalTaxes
//        }
//        if paymentMode != nil{
//            dictionary["payment_mode"] = paymentMode
//        }
//        if phone != nil{
//            dictionary["phone"] = phone
//        }
//        if status != nil{
//            dictionary["status"] = status
//        }
//        if store != nil{
//            dictionary["store"] = store.toDictionary()
//        }
//        if subtotal != nil{
//            dictionary["subtotal"] = subtotal
//        }
//        if tax != nil{
//            dictionary["tax"] = tax
//        }
//        if taxes != nil{
//            dictionary["taxes"] = taxes
//        }
//        if timeSlotEnd != nil{
//            dictionary["time_slot_end"] = timeSlotEnd
//        }
//        if timeSlotStart != nil{
//            dictionary["time_slot_start"] = timeSlotStart
//        }
//        if totalCharges != nil{
//            dictionary["total_charges"] = totalCharges
//        }
//        if totalTaxes != nil{
//            dictionary["total_taxes"] = totalTaxes
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
//         address = aDecoder.decodeObject(forKey: "address") as? String
//         amount = aDecoder.decodeObject(forKey: "amount") as? Decimal
//         charges = aDecoder.decodeObject(forKey :"charges") as? [MyOrderCharge]
//         coupon = aDecoder.decodeObject(forKey: "coupon") as AnyObject
//         currency = aDecoder.decodeObject(forKey: "currency") as? String
//         deliveryTime = aDecoder.decodeObject(forKey: "delivery_time") as? Int
//         deliveryType = aDecoder.decodeObject(forKey: "delivery_type") as? String
//         discount = aDecoder.decodeObject(forKey: "discount") as? Decimal
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         itemLevelTotalCharges = aDecoder.decodeObject(forKey: "item_level_total_charges") as? Float
//         itemLevelTotalTaxes = aDecoder.decodeObject(forKey: "item_level_total_taxes") as? Float
//         itemTax = aDecoder.decodeObject(forKey: "item_tax") as? Decimal
//         items = aDecoder.decodeObject(forKey :"items") as? [MyOrderItem]
//         merchantRefId = aDecoder.decodeObject(forKey: "merchant_ref_id") as? Int
//         orderLevelTotalCharges = aDecoder.decodeObject(forKey: "order_level_total_charges") as? Float
//         orderLevelTotalTaxes = aDecoder.decodeObject(forKey: "order_level_total_taxes") as? Float
//         paymentMode = aDecoder.decodeObject(forKey: "payment_mode") as? String
//         phone = aDecoder.decodeObject(forKey: "phone") as? String
//         status = aDecoder.decodeObject(forKey: "status") as? String
//         store = aDecoder.decodeObject(forKey: "store") as? MyOrderStore
//         subtotal = aDecoder.decodeObject(forKey: "subtotal") as? Decimal
//         tax = aDecoder.decodeObject(forKey: "tax") as? Decimal
//         taxes = aDecoder.decodeObject(forKey: "taxes") as? [AnyObject]
//         timeSlotEnd = aDecoder.decodeObject(forKey: "time_slot_end") as AnyObject
//         timeSlotStart = aDecoder.decodeObject(forKey: "time_slot_start") as AnyObject
//         totalCharges = aDecoder.decodeObject(forKey: "total_charges") as? Float
//         totalTaxes = aDecoder.decodeObject(forKey: "total_taxes") as? Float
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if address != nil{
//            aCoder.encode(address, forKey: "address")
//        }
//        if amount != nil{
//            aCoder.encode(amount, forKey: "amount")
//        }
//        if charges != nil{
//            aCoder.encode(charges, forKey: "charges")
//        }
//        if coupon != nil{
//            aCoder.encode(coupon, forKey: "coupon")
//        }
//        if currency != nil{
//            aCoder.encode(currency, forKey: "currency")
//        }
//        if deliveryTime != nil{
//            aCoder.encode(deliveryTime, forKey: "delivery_time")
//        }
//        if deliveryType != nil{
//            aCoder.encode(deliveryType, forKey: "delivery_type")
//        }
//        if discount != nil{
//            aCoder.encode(discount, forKey: "discount")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if itemLevelTotalCharges != nil{
//            aCoder.encode(itemLevelTotalCharges, forKey: "item_level_total_charges")
//        }
//        if itemLevelTotalTaxes != nil{
//            aCoder.encode(itemLevelTotalTaxes, forKey: "item_level_total_taxes")
//        }
//        if itemTax != nil{
//            aCoder.encode(itemTax, forKey: "item_tax")
//        }
//        if items != nil{
//            aCoder.encode(items, forKey: "items")
//        }
//        if merchantRefId != nil{
//            aCoder.encode(merchantRefId, forKey: "merchant_ref_id")
//        }
//        if orderLevelTotalCharges != nil{
//            aCoder.encode(orderLevelTotalCharges, forKey: "order_level_total_charges")
//        }
//        if orderLevelTotalTaxes != nil{
//            aCoder.encode(orderLevelTotalTaxes, forKey: "order_level_total_taxes")
//        }
//        if paymentMode != nil{
//            aCoder.encode(paymentMode, forKey: "payment_mode")
//        }
//        if phone != nil{
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if status != nil{
//            aCoder.encode(status, forKey: "status")
//        }
//        if store != nil{
//            aCoder.encode(store, forKey: "store")
//        }
//        if subtotal != nil{
//            aCoder.encode(subtotal, forKey: "subtotal")
//        }
//        if tax != nil{
//            aCoder.encode(tax, forKey: "tax")
//        }
//        if taxes != nil{
//            aCoder.encode(taxes, forKey: "taxes")
//        }
//        if timeSlotEnd != nil{
//            aCoder.encode(timeSlotEnd, forKey: "time_slot_end")
//        }
//        if timeSlotStart != nil{
//            aCoder.encode(timeSlotStart, forKey: "time_slot_start")
//        }
//        if totalCharges != nil{
//            aCoder.encode(totalCharges, forKey: "total_charges")
//        }
//        if totalTaxes != nil{
//            aCoder.encode(totalTaxes, forKey: "total_taxes")
//        }
//
//    }

}
