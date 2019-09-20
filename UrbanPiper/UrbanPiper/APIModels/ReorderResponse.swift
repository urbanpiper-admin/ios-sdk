//
//	ReorderResponse.swift
//
//	Create by Vidhyadharan Mohanram on 19/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class ReorderResponse: NSObject, JSONDecodable {
    public var bizLocation: BizLocation!
//    public var deliveryCharge : Float!
    @objc public var itemsAvailable: [ReorderItem]!
    @objc public var itemsNotAvailable: [ReorderItem]!
//    public var orderItemTaxes : Float!
//    public var orderSubtotal : Float!
//    public var orderTotal : Float!
//    public var packagingCharge : Float!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let bizLocationData: [String: AnyObject] = dictionary["biz_location"] as? [String: AnyObject] {
            bizLocation = BizLocation(fromDictionary: bizLocationData)
        }
//        deliveryCharge = dictionary["delivery_charge"] as? Float
        itemsAvailable = [ReorderItem]()
        if let itemsAvailableArray: [[String: AnyObject]] = dictionary["items_available"] as? [[String: AnyObject]] {
            for dic in itemsAvailableArray {
                guard let value: ReorderItem = ReorderItem(fromDictionary: dic) else { continue }
                itemsAvailable.append(value)
            }
        }
        itemsNotAvailable = [ReorderItem]()
        if let itemsNotAvailableArray: [[String: AnyObject]] = dictionary["items_not_available"] as? [[String: AnyObject]] {
            for dic in itemsNotAvailableArray {
                guard let value: ReorderItem = ReorderItem(fromDictionary: dic) else { continue }
                itemsNotAvailable.append(value)
            }
        }
//        orderItemTaxes = dictionary["order_item_taxes"] as? Float
//        orderSubtotal = dictionary["order_subtotal"] as? Float
//        orderTotal = dictionary["order_total"] as? Float
//        packagingCharge = dictionary["packaging_charge"] as? Float
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let bizLocation = bizLocation {
            dictionary["biz_location"] = bizLocation.toDictionary() as AnyObject
        }
//        if let deliveryCharge = deliveryCharge {
//            dictionary["delivery_charge"] = deliveryCharge as AnyObject
//        }
        if let itemsAvailable = itemsAvailable {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for itemsAvailableElement in itemsAvailable {
                dictionaryElements.append(itemsAvailableElement.toDictionary())
            }
            dictionary["items_available"] = dictionaryElements as AnyObject
        }
        if let itemsNotAvailable = itemsNotAvailable {
            dictionary["items_not_available"] = itemsNotAvailable as AnyObject
        }
//        if let orderItemTaxes = orderItemTaxes {
//            dictionary["order_item_taxes"] = orderItemTaxes as AnyObject
//        }
//        if let orderSubtotal = orderSubtotal {
//            dictionary["order_subtotal"] = orderSubtotal as AnyObject
//        }
//        if let orderTotal = orderTotal {
//            dictionary["order_total"] = orderTotal as AnyObject
//        }
//        if let packagingCharge = packagingCharge {
//            dictionary["packaging_charge"] = packagingCharge as AnyObject
//        }
        return dictionary
    }

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
//        if let bizLocation = bizLocation {
//            aCoder.encode(bizLocation, forKey: "biz_location")
//        }
//        if let deliveryCharge = deliveryCharge {
//            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
//        }
//        if let itemsAvailable = itemsAvailable {
//            aCoder.encode(itemsAvailable, forKey: "items_available")
//        }
//        if let itemsNotAvailable = itemsNotAvailable {
//            aCoder.encode(itemsNotAvailable, forKey: "items_not_available")
//        }
//        if let orderItemTaxes = orderItemTaxes {
//            aCoder.encode(orderItemTaxes, forKey: "order_item_taxes")
//        }
//        if let orderSubtotal = orderSubtotal {
//            aCoder.encode(orderSubtotal, forKey: "order_subtotal")
//        }
//        if let orderTotal = orderTotal {
//            aCoder.encode(orderTotal, forKey: "order_total")
//        }
//        if let packagingCharge = packagingCharge {
//            aCoder.encode(packagingCharge, forKey: "packaging_charge")
//        }
//
//    }
}
