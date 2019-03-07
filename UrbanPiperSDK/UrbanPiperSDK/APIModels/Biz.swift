//
//	Biz.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public enum Language: String {
    case english = "en"
    case hindi = "hi"
    case japanese = "ja"
    case arabic = "ar"
    
    public var displayName: String {
        switch self {
        case .english:
            return "English"
        case .hindi:
            return "Hindi"
        case .japanese:
            return "Japanese"
        case .arabic:
            return "Arabic"
        }
    }
}

@objc public class Biz : NSObject, NSCoding{
    
    static public internal(set)  var shared: Biz?

	public private(set)  var contactPhone : String!
	public private(set)  var currency : String!
	public private(set)  var deliveryMinOffsetTime : Int!
	public private(set)  var feedbackConfig : [FeedbackConfig]!
	public private(set)  var gst : String!
	public private(set)  var isPickupEnabled : Bool = false
	public private(set)  var minOrderTotal : Decimal!
//    public private(set)  var minimumWalletCreditThreshold : Float!
	public private(set)  var msgNearestStoreClosed : String!
	public private(set)  var msgNoStoresNearby : String!
	public private(set)  var msgStoreClosedTemporary : String!
	public private(set)  var orderDeliveryRadius : Int!
	public private(set)  var paymentOptions : [String]!
    public internal(set)  var supportedLanguages : [String]!
    public private(set)  var paypalClientToken : String!
	public private(set)  var pgProvider : String!
	public private(set)  var pickupMinOffsetTime : Int!
	public private(set)  var preProcess : Bool!
	public private(set)  var referralShareLbl : String!
	public private(set)  var referralUiLbl : String!
	public private(set)  var simplClientId : String!
	public private(set)  var timeSlots : [TimeSlot]!
	public private(set)  var timezone : String!
	public private(set)  var tin : String!
	public private(set)  var usePointOfDelivery : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		contactPhone = dictionary["contact_phone"] as? String
		currency = dictionary["currency"] as? String
		deliveryMinOffsetTime = dictionary["delivery_min_offset_time"] as? Int
		feedbackConfig = [FeedbackConfig]()
		if let feedbackConfigArray: [[String:Any]] = dictionary["feedback_config"] as? [[String:Any]]{
			for dic in feedbackConfigArray{
				let value: FeedbackConfig = FeedbackConfig(fromDictionary: dic)
				feedbackConfig.append(value)
			}
		}
		gst = dictionary["gst"] as? String
		isPickupEnabled = dictionary["is_pickup_enabled"] as? Bool ?? false
        
        if let val: Decimal = dictionary["min_order_total"] as? Decimal {
            minOrderTotal = val
        } else if let val: Double = dictionary["min_order_total"] as? Double {
            minOrderTotal = Decimal(val).rounded
        } else {
            minOrderTotal = Decimal.zero
        }
        
//        minimumWalletCreditThreshold = dictionary["minimum_wallet_credit_threshold"] as? Float
		msgNearestStoreClosed = dictionary["msg_nearest_store_closed"] as? String
		msgNoStoresNearby = dictionary["msg_no_stores_nearby"] as? String
		msgStoreClosedTemporary = dictionary["msg_store_closed_temporary"] as? String
		orderDeliveryRadius = dictionary["order_delivery_radius"] as? Int
		paymentOptions = dictionary["payment_options"] as? [String]
        supportedLanguages = dictionary["supported_languages"] as? [String]
		paypalClientToken = dictionary["paypal_client_token"] as? String
		pgProvider = dictionary["pg_provider"] as? String
		pickupMinOffsetTime = dictionary["pickup_min_offset_time"] as? Int
		preProcess = dictionary["pre_process"] as? Bool
		referralShareLbl = dictionary["referral_share_lbl"] as? String
		referralUiLbl = dictionary["referral_ui_lbl"] as? String
		simplClientId = dictionary["simpl_client_id"] as? String
		timeSlots = [TimeSlot]()
		if let timeSlotsArray: [[String:Any]] = dictionary["time_slots"] as? [[String:Any]]{
			for dic in timeSlotsArray{
				let value: TimeSlot = TimeSlot(fromDictionary: dic)
				timeSlots.append(value)
			}
		}
		timezone = dictionary["timezone"] as? String
		tin = dictionary["tin"] as? String
		usePointOfDelivery = dictionary["use_point_of_delivery"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary: [String: Any] = [String:Any]()
		if contactPhone != nil{
			dictionary["contact_phone"] = contactPhone
		}
		if currency != nil{
			dictionary["currency"] = currency
		}
		if deliveryMinOffsetTime != nil{
			dictionary["delivery_min_offset_time"] = deliveryMinOffsetTime
		}
		if feedbackConfig != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
			for feedbackConfigElement in feedbackConfig {
				dictionaryElements.append(feedbackConfigElement.toDictionary())
			}
			dictionary["feedback_config"] = dictionaryElements
		}
		if gst != nil{
			dictionary["gst"] = gst
		}
        dictionary["is_pickup_enabled"] = isPickupEnabled
		if minOrderTotal != nil{
			dictionary["min_order_total"] = minOrderTotal
		}
//        if minimumWalletCreditThreshold != nil{
//            dictionary["minimum_wallet_credit_threshold"] = minimumWalletCreditThreshold
//        }
		if msgNearestStoreClosed != nil{
			dictionary["msg_nearest_store_closed"] = msgNearestStoreClosed
		}
		if msgNoStoresNearby != nil{
			dictionary["msg_no_stores_nearby"] = msgNoStoresNearby
		}
		if msgStoreClosedTemporary != nil{
			dictionary["msg_store_closed_temporary"] = msgStoreClosedTemporary
		}
		if orderDeliveryRadius != nil{
			dictionary["order_delivery_radius"] = orderDeliveryRadius
		}
		if paymentOptions != nil{
			dictionary["payment_options"] = paymentOptions
		}
        if supportedLanguages != nil{
            dictionary["supported_languages"] = supportedLanguages
        }
		if paypalClientToken != nil{
			dictionary["paypal_client_token"] = paypalClientToken
		}
		if pgProvider != nil{
			dictionary["pg_provider"] = pgProvider
		}
		if pickupMinOffsetTime != nil{
			dictionary["pickup_min_offset_time"] = pickupMinOffsetTime
		}
		if preProcess != nil{
			dictionary["pre_process"] = preProcess
		}
		if referralShareLbl != nil{
			dictionary["referral_share_lbl"] = referralShareLbl
		}
		if referralUiLbl != nil{
			dictionary["referral_ui_lbl"] = referralUiLbl
		}
		if simplClientId != nil{
			dictionary["simpl_client_id"] = simplClientId
		}
		if timeSlots != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
			for timeSlotsElement in timeSlots {
				dictionaryElements.append(timeSlotsElement.toDictionary())
			}
			dictionary["time_slots"] = dictionaryElements
		}
		if timezone != nil{
			dictionary["timezone"] = timezone
		}
		if tin != nil{
			dictionary["tin"] = tin
		}
		if usePointOfDelivery != nil{
			dictionary["use_point_of_delivery"] = usePointOfDelivery
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         contactPhone = aDecoder.decodeObject(forKey: "contact_phone") as? String
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         deliveryMinOffsetTime = aDecoder.decodeObject(forKey: "delivery_min_offset_time") as? Int
        feedbackConfig = aDecoder.decodeObject(forKey :"feedback_config") as? [FeedbackConfig]
         gst = aDecoder.decodeObject(forKey: "gst") as? String
         isPickupEnabled = aDecoder.decodeObject(forKey: "is_pickup_enabled") as? Bool ?? false
         minOrderTotal = aDecoder.decodeObject(forKey: "min_order_total") as? Decimal
//         minimumWalletCreditThreshold = aDecoder.decodeObject(forKey: "minimum_wallet_credit_threshold") as? Float
         msgNearestStoreClosed = aDecoder.decodeObject(forKey: "msg_nearest_store_closed") as? String
         msgNoStoresNearby = aDecoder.decodeObject(forKey: "msg_no_stores_nearby") as? String
         msgStoreClosedTemporary = aDecoder.decodeObject(forKey: "msg_store_closed_temporary") as? String
         orderDeliveryRadius = aDecoder.decodeObject(forKey: "order_delivery_radius") as? Int
         paymentOptions = aDecoder.decodeObject(forKey: "payment_options") as? [String]
         supportedLanguages = aDecoder.decodeObject(forKey: "supported_languages") as? [String]
         paypalClientToken = aDecoder.decodeObject(forKey: "paypal_client_token") as? String
         pgProvider = aDecoder.decodeObject(forKey: "pg_provider") as? String
         pickupMinOffsetTime = aDecoder.decodeObject(forKey: "pickup_min_offset_time") as? Int
         preProcess = aDecoder.decodeObject(forKey: "pre_process") as? Bool
         referralShareLbl = aDecoder.decodeObject(forKey: "referral_share_lbl") as? String
         referralUiLbl = aDecoder.decodeObject(forKey: "referral_ui_lbl") as? String
         simplClientId = aDecoder.decodeObject(forKey: "simpl_client_id") as? String
        timeSlots = aDecoder.decodeObject(forKey :"time_slots") as? [TimeSlot]
         timezone = aDecoder.decodeObject(forKey: "timezone") as? String
         tin = aDecoder.decodeObject(forKey: "tin") as? String
         usePointOfDelivery = aDecoder.decodeObject(forKey: "use_point_of_delivery") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if contactPhone != nil{
			aCoder.encode(contactPhone, forKey: "contact_phone")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if deliveryMinOffsetTime != nil{
			aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
		}
		if feedbackConfig != nil{
			aCoder.encode(feedbackConfig, forKey: "feedback_config")
		}
		if gst != nil{
			aCoder.encode(gst, forKey: "gst")
		}
        aCoder.encode(isPickupEnabled, forKey: "is_pickup_enabled")
		if minOrderTotal != nil{
			aCoder.encode(minOrderTotal, forKey: "min_order_total")
		}
//        if minimumWalletCreditThreshold != nil{
//            aCoder.encode(minimumWalletCreditThreshold, forKey: "minimum_wallet_credit_threshold")
//        }
		if msgNearestStoreClosed != nil{
			aCoder.encode(msgNearestStoreClosed, forKey: "msg_nearest_store_closed")
		}
		if msgNoStoresNearby != nil{
			aCoder.encode(msgNoStoresNearby, forKey: "msg_no_stores_nearby")
		}
		if msgStoreClosedTemporary != nil{
			aCoder.encode(msgStoreClosedTemporary, forKey: "msg_store_closed_temporary")
		}
		if orderDeliveryRadius != nil{
			aCoder.encode(orderDeliveryRadius, forKey: "order_delivery_radius")
		}
		if paymentOptions != nil{
			aCoder.encode(paymentOptions, forKey: "payment_options")
		}
        if supportedLanguages != nil{
            aCoder.encode(supportedLanguages, forKey: "supported_languages")
        }
		if paypalClientToken != nil{
			aCoder.encode(paypalClientToken, forKey: "paypal_client_token")
		}
		if pgProvider != nil{
			aCoder.encode(pgProvider, forKey: "pg_provider")
		}
		if pickupMinOffsetTime != nil{
			aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
		}
		if preProcess != nil{
			aCoder.encode(preProcess, forKey: "pre_process")
		}
		if referralShareLbl != nil{
			aCoder.encode(referralShareLbl, forKey: "referral_share_lbl")
		}
		if referralUiLbl != nil{
			aCoder.encode(referralUiLbl, forKey: "referral_ui_lbl")
		}
		if simplClientId != nil{
			aCoder.encode(simplClientId, forKey: "simpl_client_id")
		}
		if timeSlots != nil{
			aCoder.encode(timeSlots, forKey: "time_slots")
		}
		if timezone != nil{
			aCoder.encode(timezone, forKey: "timezone")
		}
		if tin != nil{
			aCoder.encode(tin, forKey: "tin")
		}
		if usePointOfDelivery != nil{
			aCoder.encode(usePointOfDelivery, forKey: "use_point_of_delivery")
		}

	}

}
