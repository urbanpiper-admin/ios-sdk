//
//	UserBizInfo.swift
//
//	Create by Vidhyadharan Mohanram on 17/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class UserBizInfo: NSObject, JSONDecodable, NSCoding {
    public var addresses: [AnyObject]!
    @objc public var balance: NSDecimalNumber = NSDecimalNumber.zero
    public var bizId: Int?
    @objc public var cardNumbers: [String]!
    public var daysSinceLastOrder: Int?
    public var id: Int = 0
    public var lastOrderDt: Int?
    public var name: String!
    public var numOfOrders: Int?
    public var phone: String!
    @objc public var points: NSNumber = NSNumber(integerLiteral: 0)
    public var signupDt: Int?
    public var totalOrderValue: Decimal!
    @objc public var lastUpdatedDateString: String?
    internal var lastOrderDateString: String? {
        if let val = lastOrderDt {
            let date: Date = Date(timeIntervalSince1970: TimeInterval(val / 1000))
            return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
        }
        return nil
    }

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        addresses = dictionary["addresses"] as? [AnyObject]

        if let val: Decimal = dictionary["balance"] as? Decimal {
            balance = val as NSDecimalNumber
        } else if let val: Double = dictionary["balance"] as? Double {
            balance = Decimal(val).rounded as NSDecimalNumber
        } else {
            balance = Decimal.zero as NSDecimalNumber
        }

        bizId = dictionary["biz_id"] as? Int
        cardNumbers = dictionary["card_numbers"] as? [String]
        daysSinceLastOrder = dictionary["days_since_last_order"] as? Int
        id = dictionary["id"] as? Int ?? 0
        lastOrderDt = dictionary["last_order_dt"] as? Int
        name = dictionary["name"] as? String
        numOfOrders = dictionary["num_of_orders"] as? Int
        phone = dictionary["phone"] as? String
        points = dictionary["points"] as? NSNumber ?? NSNumber(integerLiteral: 0)
        signupDt = dictionary["signup_dt"] as? Int

        if let val: Decimal = dictionary["total_order_value"] as? Decimal {
            totalOrderValue = val
        } else if let val: Double = dictionary["total_order_value"] as? Double {
            totalOrderValue = Decimal(val).rounded
        } else if let val: Float = dictionary["total_order_value"] as? Float {
            totalOrderValue = Decimal(Double(val)).rounded
        } else {
            totalOrderValue = Decimal.zero
        }

        lastUpdatedDateString = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let addresses = addresses {
            dictionary["addresses"] = addresses as AnyObject
        }
        dictionary["balance"] = balance as AnyObject
        if let bizId = bizId {
            dictionary["biz_id"] = bizId as AnyObject
        }
        if let cardNumbers = cardNumbers {
            dictionary["card_numbers"] = cardNumbers as AnyObject
        }
        if let daysSinceLastOrder = daysSinceLastOrder {
            dictionary["days_since_last_order"] = daysSinceLastOrder as AnyObject
        }
        dictionary["id"] = id as AnyObject
        if let lastOrderDt = lastOrderDt {
            dictionary["last_order_dt"] = lastOrderDt as AnyObject
        }
        if let name = name {
            dictionary["name"] = name as AnyObject
        }
        if let lastUpdatedDateString = lastUpdatedDateString {
            dictionary["lastUpdatedDateString"] = lastUpdatedDateString as AnyObject
        }
        if let numOfOrders = numOfOrders {
            dictionary["num_of_orders"] = numOfOrders as AnyObject
        }
        if let phone = phone {
            dictionary["phone"] = phone as AnyObject
        }
        dictionary["points"] = points as AnyObject
        if let signupDt = signupDt {
            dictionary["signup_dt"] = signupDt as AnyObject
        }
        if let totalOrderValue = totalOrderValue {
            dictionary["total_order_value"] = totalOrderValue as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        addresses = aDecoder.decodeObject(forKey: "addresses") as? [AnyObject]
        balance = aDecoder.decodeObject(forKey: "balance") as? NSDecimalNumber ?? NSDecimalNumber.zero
        bizId = aDecoder.decodeObject(forKey: "biz_id") as? Int
        cardNumbers = aDecoder.decodeObject(forKey: "card_numbers") as? [String]
        daysSinceLastOrder = aDecoder.decodeObject(forKey: "days_since_last_order") as? Int
        if let val = aDecoder.decodeObject(forKey: "id") as? Int {
            id = val
        } else {
            id = aDecoder.decodeInteger(forKey: "id")
        }
        lastOrderDt = aDecoder.decodeObject(forKey: "last_order_dt") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        lastUpdatedDateString = aDecoder.decodeObject(forKey: "lastUpdatedDateString") as? String
        numOfOrders = aDecoder.decodeObject(forKey: "num_of_orders") as? Int
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        points = aDecoder.decodeObject(forKey: "points") as? NSNumber ?? NSNumber(integerLiteral: 0)
        signupDt = aDecoder.decodeObject(forKey: "signup_dt") as? Int
        totalOrderValue = aDecoder.decodeObject(forKey: "total_order_value") as? Decimal
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if let addresses = addresses {
            aCoder.encode(addresses, forKey: "addresses")
        }
        aCoder.encode(balance, forKey: "balance")

        if let bizId = bizId {
            aCoder.encode(bizId, forKey: "biz_id")
        }
        if let cardNumbers = cardNumbers {
            aCoder.encode(cardNumbers, forKey: "card_numbers")
        }
        if let daysSinceLastOrder = daysSinceLastOrder {
            aCoder.encode(daysSinceLastOrder, forKey: "days_since_last_order")
        }
        aCoder.encode(id, forKey: "id")
        if let lastOrderDt = lastOrderDt {
            aCoder.encode(lastOrderDt, forKey: "last_order_dt")
        }
        if let name = name {
            aCoder.encode(name, forKey: "name")
        }
        if let lastUpdatedDateString = lastUpdatedDateString {
            aCoder.encode(lastUpdatedDateString, forKey: "lastUpdatedDateString")
        }
        if let numOfOrders = numOfOrders {
            aCoder.encode(numOfOrders, forKey: "num_of_orders")
        }
        if let phone = phone {
            aCoder.encode(phone, forKey: "phone")
        }
        aCoder.encode(points, forKey: "points")
        if let signupDt = signupDt {
            aCoder.encode(signupDt, forKey: "signup_dt")
        }
        if let totalOrderValue = totalOrderValue {
            aCoder.encode(totalOrderValue, forKey: "total_order_value")
        }
    }
}
