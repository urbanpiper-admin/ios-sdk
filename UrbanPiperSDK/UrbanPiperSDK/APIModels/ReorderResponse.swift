//
//	ReorderResponse.swift
//
//	Create by Vidhyadharan Mohanram on 19/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ReorderResponse : NSObject{

	public var bizLocation : BizLocation!
//    public var deliveryCharge : Float!
	public var itemsAvailable : [Item]!
	public var itemsNotAvailable : [Item]!
//    public var orderItemTaxes : Float!
//    public var orderSubtotal : Float!
//    public var orderTotal : Float!
//    public var packagingCharge : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let bizLocationData: [String:Any] = dictionary["biz_location"] as? [String:Any]{
			bizLocation = BizLocation(fromDictionary: bizLocationData)
		}
//        deliveryCharge = dictionary["delivery_charge"] as? Float
		itemsAvailable = [Item]()
		if let itemsAvailableArray: [[String:Any]] = dictionary["items_available"] as? [[String:Any]]{
			for dic in itemsAvailableArray{
				let value: Item = Item(historicalOrderItemDictionary: dic)
				itemsAvailable.append(value)
			}
		}
        itemsNotAvailable = [Item]()
        if let itemsNotAvailableArray: [[String:Any]] = dictionary["items_not_available"] as? [[String:Any]]{
            for dic in itemsNotAvailableArray{
                let value: Item = Item(fromDictionary: dic)
                itemsNotAvailable.append(value)
            }
        }
//        orderItemTaxes = dictionary["order_item_taxes"] as? Float
//        orderSubtotal = dictionary["order_subtotal"] as? Float
//        orderTotal = dictionary["order_total"] as? Float
//        packagingCharge = dictionary["packaging_charge"] as? Float
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if bizLocation != nil{
//            dictionary["biz_location"] = bizLocation.toDictionary()
//        }
//        if deliveryCharge != nil{
//            dictionary["delivery_charge"] = deliveryCharge
//        }
//        if itemsAvailable != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for itemsAvailableElement in itemsAvailable {
//                dictionaryElements.append(itemsAvailableElement.toDictionary())
//            }
//            dictionary["items_available"] = dictionaryElements
//        }
//        if itemsNotAvailable != nil{
//            dictionary["items_not_available"] = itemsNotAvailable
//        }
//        if orderItemTaxes != nil{
//            dictionary["order_item_taxes"] = orderItemTaxes
//        }
//        if orderSubtotal != nil{
//            dictionary["order_subtotal"] = orderSubtotal
//        }
//        if orderTotal != nil{
//            dictionary["order_total"] = orderTotal
//        }
//        if packagingCharge != nil{
//            dictionary["packaging_charge"] = packagingCharge
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
//         bizLocation = aDecoder.decodeObject(forKey: "biz_location") as? BizLocation
//         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? Float
//         itemsAvailable = aDecoder.decodeObject(forKey :"items_available") as? [Item]
//         itemsNotAvailable = aDecoder.decodeObject(forKey: "items_not_available") as? [Item]
//         orderItemTaxes = aDecoder.decodeObject(forKey: "order_item_taxes") as? Float
//         orderSubtotal = aDecoder.decodeObject(forKey: "order_subtotal") as? Float
//         orderTotal = aDecoder.decodeObject(forKey: "order_total") as? Float
//         packagingCharge = aDecoder.decodeObject(forKey: "packaging_charge") as? Float
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if bizLocation != nil{
//            aCoder.encode(bizLocation, forKey: "biz_location")
//        }
//        if deliveryCharge != nil{
//            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
//        }
//        if itemsAvailable != nil{
//            aCoder.encode(itemsAvailable, forKey: "items_available")
//        }
//        if itemsNotAvailable != nil{
//            aCoder.encode(itemsNotAvailable, forKey: "items_not_available")
//        }
//        if orderItemTaxes != nil{
//            aCoder.encode(orderItemTaxes, forKey: "order_item_taxes")
//        }
//        if orderSubtotal != nil{
//            aCoder.encode(orderSubtotal, forKey: "order_subtotal")
//        }
//        if orderTotal != nil{
//            aCoder.encode(orderTotal, forKey: "order_total")
//        }
//        if packagingCharge != nil{
//            aCoder.encode(packagingCharge, forKey: "packaging_charge")
//        }
//
//    }

}
