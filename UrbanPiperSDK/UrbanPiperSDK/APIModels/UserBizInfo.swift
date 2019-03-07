//
//	UserBizInfo.swift
//
//	Create by Vidhyadharan Mohanram on 17/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class UserBizInfo : NSObject, NSCoding{

	public private(set)  var addresses : [AnyObject]!
	@objc public private(set)  var balance : NSDecimalNumber = NSDecimalNumber.zero
	public private(set)  var bizId : Int!
	@objc public private(set)  var cardNumbers : [String]!
	public private(set)  var daysSinceLastOrder : Int!
	public private(set)  var id : Int!
	public private(set)  var lastOrderDt : Int!
	public private(set)  var name : String!
	public private(set)  var numOfOrders : Int!
	public private(set)  var phone : String!
	@objc public private(set)  var points : NSNumber = NSNumber(integerLiteral: 0)
	public private(set)  var signupDt : Int!
	public private(set)  var totalOrderValue : Decimal!
    @objc public private(set)  var lastUpdatedDateString: String?
    public var lastOrderDateString: String? {
        if let val = lastOrderDt {
            let date: Date = Date(timeIntervalSince1970: TimeInterval(val / 1000))
            return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
        }
        return nil
    }


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
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
		id = dictionary["id"] as? Int
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
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if addresses != nil{
            dictionary["addresses"] = addresses
        }
        dictionary["balance"] = balance
        if bizId != nil{
            dictionary["biz_id"] = bizId
        }
        if cardNumbers != nil{
            dictionary["card_numbers"] = cardNumbers
        }
        if daysSinceLastOrder != nil{
            dictionary["days_since_last_order"] = daysSinceLastOrder
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastOrderDt != nil{
            dictionary["last_order_dt"] = lastOrderDt
        }
        if name != nil{
            dictionary["name"] = name
        }
        if lastUpdatedDateString != nil{
            dictionary["lastUpdatedDateString"] = lastUpdatedDateString
        }
        if numOfOrders != nil{
            dictionary["num_of_orders"] = numOfOrders
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        dictionary["points"] = points
        if signupDt != nil{
            dictionary["signup_dt"] = signupDt
        }
        if totalOrderValue != nil{
            dictionary["total_order_value"] = totalOrderValue
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         addresses = aDecoder.decodeObject(forKey: "addresses") as? [AnyObject]
        balance = aDecoder.decodeObject(forKey: "balance") as? NSDecimalNumber ?? NSDecimalNumber.zero
         bizId = aDecoder.decodeObject(forKey: "biz_id") as? Int
         cardNumbers = aDecoder.decodeObject(forKey: "card_numbers") as? [String]
         daysSinceLastOrder = aDecoder.decodeObject(forKey: "days_since_last_order") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
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
    @objc public func encode(with aCoder: NSCoder)
	{
		if addresses != nil{
			aCoder.encode(addresses, forKey: "addresses")
		}
        aCoder.encode(balance, forKey: "balance")

		if bizId != nil{
			aCoder.encode(bizId, forKey: "biz_id")
		}
		if cardNumbers != nil{
			aCoder.encode(cardNumbers, forKey: "card_numbers")
		}
		if daysSinceLastOrder != nil{
			aCoder.encode(daysSinceLastOrder, forKey: "days_since_last_order")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lastOrderDt != nil{
			aCoder.encode(lastOrderDt, forKey: "last_order_dt")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
        if lastUpdatedDateString != nil{
            aCoder.encode(lastUpdatedDateString, forKey: "lastUpdatedDateString")
        }
		if numOfOrders != nil{
			aCoder.encode(numOfOrders, forKey: "num_of_orders")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
        aCoder.encode(points, forKey: "points")
		if signupDt != nil{
			aCoder.encode(signupDt, forKey: "signup_dt")
		}
		if totalOrderValue != nil{
			aCoder.encode(totalOrderValue, forKey: "total_order_value")
		}

	}

}
