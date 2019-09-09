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

@objc public class Biz : NSObject, JSONDecodable, NSCoding{
    
    @objc static public var shared: Biz?

	public var contactPhone : String!
	public var currency : String!
	public var deliveryMinOffsetTime : Int!
	public var feedbackConfig : [FeedbackConfig]!
	public var gst : String!
	public var isPickupEnabled : Bool = false
	public var minOrderTotal : Decimal!
//    public var minimumWalletCreditThreshold : Float!
	public var msgNearestStoreClosed : String!
	public var msgNoStoresNearby : String!
	public var msgStoreClosedTemporary : String!
	public var orderDeliveryRadius : Int!
	@objc public var paymentOptions : [String]!
    public var supportedLanguages : [String]!
    public var paypalClientToken : String!
	public var pgProvider : String!
	public var pickupMinOffsetTime : Int!
    public var preProcess : Bool
	public var referralShareLbl : String!
	public var referralUiLbl : String!
	public var simplClientId : String!
	public var timeSlots : [TimeSlot]!
	public var timezone : String!
	public var tin : String!
    @objc public var usePointOfDelivery : Bool


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		contactPhone = dictionary["contact_phone"] as? String
		currency = dictionary["currency"] as? String
		deliveryMinOffsetTime = dictionary["delivery_min_offset_time"] as? Int
		feedbackConfig = [FeedbackConfig]()
		if let feedbackConfigArray: [[String : AnyObject]] = dictionary["feedback_config"] as? [[String : AnyObject]]{
			for dic in feedbackConfigArray{
				guard let value: FeedbackConfig = FeedbackConfig(fromDictionary: dic) else { continue }
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
		preProcess = dictionary["pre_process"] as? Bool ?? false
		referralShareLbl = dictionary["referral_share_lbl"] as? String
		referralUiLbl = dictionary["referral_ui_lbl"] as? String
		simplClientId = dictionary["simpl_client_id"] as? String
		timeSlots = [TimeSlot]()
		if let timeSlotsArray: [[String : AnyObject]] = dictionary["time_slots"] as? [[String : AnyObject]]{
			for dic in timeSlotsArray{
				guard let value: TimeSlot = TimeSlot(fromDictionary: dic) else { continue }
				timeSlots.append(value)
			}
		}
		timezone = dictionary["timezone"] as? String
		tin = dictionary["tin"] as? String
		usePointOfDelivery = dictionary["use_point_of_delivery"] as? Bool ?? false
	}

	/**
	 * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	@objc public func toDictionary() -> [String : AnyObject]
	{
		var dictionary: [String : AnyObject] = [String : AnyObject]()
		if let contactPhone = contactPhone {
			dictionary["contact_phone"] = contactPhone as AnyObject
		}
		if let currency = currency {
			dictionary["currency"] = currency as AnyObject
		}
		if let deliveryMinOffsetTime = deliveryMinOffsetTime {
			dictionary["delivery_min_offset_time"] = deliveryMinOffsetTime as AnyObject
		}
		if let feedbackConfig = feedbackConfig {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
			for feedbackConfigElement in feedbackConfig {
				dictionaryElements.append(feedbackConfigElement.toDictionary())
			}
			dictionary["feedback_config"] = dictionaryElements as AnyObject
		}
		if let gst = gst {
			dictionary["gst"] = gst as AnyObject
		}
        dictionary["is_pickup_enabled"] = isPickupEnabled as AnyObject
		if let minOrderTotal = minOrderTotal {
			dictionary["min_order_total"] = minOrderTotal as AnyObject
		}
//        if let minimumWalletCreditThreshold = minimumWalletCreditThreshold {
//            dictionary["minimum_wallet_credit_threshold"] = minimumWalletCreditThreshold as AnyObject
//        }
		if let msgNearestStoreClosed = msgNearestStoreClosed {
			dictionary["msg_nearest_store_closed"] = msgNearestStoreClosed as AnyObject
		}
		if let msgNoStoresNearby = msgNoStoresNearby {
			dictionary["msg_no_stores_nearby"] = msgNoStoresNearby as AnyObject
		}
		if let msgStoreClosedTemporary = msgStoreClosedTemporary {
			dictionary["msg_store_closed_temporary"] = msgStoreClosedTemporary as AnyObject
		}
		if let orderDeliveryRadius = orderDeliveryRadius {
			dictionary["order_delivery_radius"] = orderDeliveryRadius as AnyObject
		}
		if let paymentOptions = paymentOptions {
			dictionary["payment_options"] = paymentOptions as AnyObject
		}
        if let supportedLanguages = supportedLanguages {
            dictionary["supported_languages"] = supportedLanguages as AnyObject
        }
		if let paypalClientToken = paypalClientToken {
			dictionary["paypal_client_token"] = paypalClientToken as AnyObject
		}
		if let pgProvider = pgProvider {
			dictionary["pg_provider"] = pgProvider as AnyObject
		}
		if let pickupMinOffsetTime = pickupMinOffsetTime {
			dictionary["pickup_min_offset_time"] = pickupMinOffsetTime as AnyObject
		}

        dictionary["pre_process"] = preProcess as AnyObject
		
		if let referralShareLbl = referralShareLbl {
			dictionary["referral_share_lbl"] = referralShareLbl as AnyObject
		}
		if let referralUiLbl = referralUiLbl {
			dictionary["referral_ui_lbl"] = referralUiLbl as AnyObject
		}
		if let simplClientId = simplClientId {
			dictionary["simpl_client_id"] = simplClientId as AnyObject
		}
		if let timeSlots = timeSlots {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
			for timeSlotsElement in timeSlots {
				dictionaryElements.append(timeSlotsElement.toDictionary())
			}
			dictionary["time_slots"] = dictionaryElements as AnyObject
		}
		if let timezone = timezone {
			dictionary["timezone"] = timezone as AnyObject
		}
		if let tin = tin {
			dictionary["tin"] = tin as AnyObject
		}

        dictionary["use_point_of_delivery"] = usePointOfDelivery as AnyObject
		
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
         deliveryMinOffsetTime = aDecoder.decodeInteger(forKey: "delivery_min_offset_time")
        feedbackConfig = aDecoder.decodeObject(forKey :"feedback_config") as? [FeedbackConfig]
         gst = aDecoder.decodeObject(forKey: "gst") as? String
       
        if let numberVal = aDecoder.decodeObject(forKey: "is_pickup_enabled") as? NSNumber {
            isPickupEnabled = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "is_pickup_enabled") {
            isPickupEnabled = aDecoder.decodeBool(forKey: "is_pickup_enabled")
        } else {
            isPickupEnabled = false
        }

         minOrderTotal = aDecoder.decodeObject(forKey: "min_order_total") as? Decimal
//         minimumWalletCreditThreshold = aDecoder.decodeObject(forKey: "minimum_wallet_credit_threshold") as? Float
         msgNearestStoreClosed = aDecoder.decodeObject(forKey: "msg_nearest_store_closed") as? String
         msgNoStoresNearby = aDecoder.decodeObject(forKey: "msg_no_stores_nearby") as? String
         msgStoreClosedTemporary = aDecoder.decodeObject(forKey: "msg_store_closed_temporary") as? String
         orderDeliveryRadius = aDecoder.decodeInteger(forKey: "order_delivery_radius")
         paymentOptions = aDecoder.decodeObject(forKey: "payment_options") as? [String]
         supportedLanguages = aDecoder.decodeObject(forKey: "supported_languages") as? [String]
         paypalClientToken = aDecoder.decodeObject(forKey: "paypal_client_token") as? String
         pgProvider = aDecoder.decodeObject(forKey: "pg_provider") as? String
         pickupMinOffsetTime = aDecoder.decodeInteger(forKey: "pickup_min_offset_time")
        
        if let numberVal = aDecoder.decodeObject(forKey: "pre_process") as? NSNumber {
            preProcess = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "pre_process") {
            preProcess = aDecoder.decodeBool(forKey: "pre_process")
        } else {
            preProcess = false
        }

         referralShareLbl = aDecoder.decodeObject(forKey: "referral_share_lbl") as? String
         referralUiLbl = aDecoder.decodeObject(forKey: "referral_ui_lbl") as? String
         simplClientId = aDecoder.decodeObject(forKey: "simpl_client_id") as? String
        timeSlots = aDecoder.decodeObject(forKey :"time_slots") as? [TimeSlot]
         timezone = aDecoder.decodeObject(forKey: "timezone") as? String
         tin = aDecoder.decodeObject(forKey: "tin") as? String

        if let numberVal = aDecoder.decodeObject(forKey: "use_point_of_delivery") as? NSNumber {
            usePointOfDelivery = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "use_point_of_delivery") {
            usePointOfDelivery = aDecoder.decodeBool(forKey: "use_point_of_delivery")
        } else {
            usePointOfDelivery = false
        }
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if let contactPhone = contactPhone {
			aCoder.encode(contactPhone, forKey: "contact_phone")
		}
		if let currency = currency {
			aCoder.encode(currency, forKey: "currency")
		}
		if let deliveryMinOffsetTime = deliveryMinOffsetTime {
			aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
		}
		if let feedbackConfig = feedbackConfig {
			aCoder.encode(feedbackConfig, forKey: "feedback_config")
		}
		if let gst = gst {
			aCoder.encode(gst, forKey: "gst")
		}
        aCoder.encode(isPickupEnabled, forKey: "is_pickup_enabled")
		if let minOrderTotal = minOrderTotal {
			aCoder.encode(minOrderTotal, forKey: "min_order_total")
		}
//        if let minimumWalletCreditThreshold = minimumWalletCreditThreshold {
//            aCoder.encode(minimumWalletCreditThreshold, forKey: "minimum_wallet_credit_threshold")
//        }
		if let msgNearestStoreClosed = msgNearestStoreClosed {
			aCoder.encode(msgNearestStoreClosed, forKey: "msg_nearest_store_closed")
		}
		if let msgNoStoresNearby = msgNoStoresNearby {
			aCoder.encode(msgNoStoresNearby, forKey: "msg_no_stores_nearby")
		}
		if let msgStoreClosedTemporary = msgStoreClosedTemporary {
			aCoder.encode(msgStoreClosedTemporary, forKey: "msg_store_closed_temporary")
		}
		if let orderDeliveryRadius = orderDeliveryRadius {
			aCoder.encode(orderDeliveryRadius, forKey: "order_delivery_radius")
		}
		if let paymentOptions = paymentOptions {
			aCoder.encode(paymentOptions, forKey: "payment_options")
		}
        if let supportedLanguages = supportedLanguages {
            aCoder.encode(supportedLanguages, forKey: "supported_languages")
        }
		if let paypalClientToken = paypalClientToken {
			aCoder.encode(paypalClientToken, forKey: "paypal_client_token")
		}
		if let pgProvider = pgProvider {
			aCoder.encode(pgProvider, forKey: "pg_provider")
		}
		if let pickupMinOffsetTime = pickupMinOffsetTime {
			aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
		}

        aCoder.encode(preProcess, forKey: "pre_process")
		
		if let referralShareLbl = referralShareLbl {
			aCoder.encode(referralShareLbl, forKey: "referral_share_lbl")
		}
		if let referralUiLbl = referralUiLbl {
			aCoder.encode(referralUiLbl, forKey: "referral_ui_lbl")
		}
		if let simplClientId = simplClientId {
			aCoder.encode(simplClientId, forKey: "simpl_client_id")
		}
		if let timeSlots = timeSlots {
			aCoder.encode(timeSlots, forKey: "time_slots")
		}
		if let timezone = timezone {
			aCoder.encode(timezone, forKey: "timezone")
		}
		if let tin = tin {
			aCoder.encode(tin, forKey: "tin")
		}

        aCoder.encode(usePointOfDelivery, forKey: "use_point_of_delivery")
	}

}
