// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let biz = try Biz(json)

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

// MARK: - Biz
@objcMembers public class Biz: NSObject, Codable, NSCoding {
    public static var shared: Biz!

    public let contactPhone: String?
    public let currency: String
    public let deliveryMinOffsetTime: Int
    public let feedbackConfig: [FeedbackConfig]
    public let gst: String?
    public let isPickupEnabled: Bool
    public let isdCode: String
    public let minOrderTotal, minimumWalletCreditThreshold: Double
    public let msgNearestStoreClosed, msgNoStoresNearby, msgStoreClosedTemporary: String?
    public let orderDeliveryRadius: Int
    public let paymentOptions: [String]
    public let paypalClientToken: String?
    public let pgProvider: String?
    public let pickupMinOffsetTime: Int
    public let preProcess: Bool
    public let referralShareLbl, referraluiLbl: String
    public let simplClientid: String?
    public let supportedLanguages: [String]
    public let timeSlots: [TimeSlot]
    public let timezone: String
    public let tin: String?
    public let usePointOfDelivery: Bool

    enum CodingKeys: String, CodingKey {
        case contactPhone = "contact_phone"
        case currency
        case deliveryMinOffsetTime = "delivery_min_offset_time"
        case feedbackConfig = "feedback_config"
        case gst
        case isPickupEnabled = "is_pickup_enabled"
        case isdCode = "isd_code"
        case minOrderTotal = "min_order_total"
        case minimumWalletCreditThreshold = "minimum_wallet_credit_threshold"
        case msgNearestStoreClosed = "msg_nearest_store_closed"
        case msgNoStoresNearby = "msg_no_stores_nearby"
        case msgStoreClosedTemporary = "msg_store_closed_temporary"
        case orderDeliveryRadius = "order_delivery_radius"
        case paymentOptions = "payment_options"
        case paypalClientToken = "paypal_client_token"
        case pgProvider = "pg_provider"
        case pickupMinOffsetTime = "pickup_min_offset_time"
        case preProcess = "pre_process"
        case referralShareLbl = "referral_share_lbl"
        case referraluiLbl = "referral_ui_lbl"
        case simplClientid = "simpl_client_id"
        case supportedLanguages = "supported_languages"
        case timeSlots = "time_slots"
        case timezone, tin
        case usePointOfDelivery = "use_point_of_delivery"
    }

    init(contactPhone: String?, currency: String, deliveryMinOffsetTime: Int, feedbackConfig: [FeedbackConfig], gst: String?, isPickupEnabled: Bool, isdCode: String, minOrderTotal: Double, minimumWalletCreditThreshold: Double, msgNearestStoreClosed: String?, msgNoStoresNearby: String?, msgStoreClosedTemporary: String?, orderDeliveryRadius: Int, paymentOptions: [String], paypalClientToken: String?, pgProvider: String?, pickupMinOffsetTime: Int, preProcess: Bool, referralShareLbl: String, referraluiLbl: String, simplClientid: String?, supportedLanguages: [String], timeSlots: [TimeSlot], timezone: String, tin: String?, usePointOfDelivery: Bool) {
        self.contactPhone = contactPhone
        self.currency = currency
        self.deliveryMinOffsetTime = deliveryMinOffsetTime
        self.feedbackConfig = feedbackConfig
        self.gst = gst
        self.isPickupEnabled = isPickupEnabled
        self.isdCode = isdCode
        self.minOrderTotal = minOrderTotal
        self.minimumWalletCreditThreshold = minimumWalletCreditThreshold
        self.msgNearestStoreClosed = msgNearestStoreClosed
        self.msgNoStoresNearby = msgNoStoresNearby
        self.msgStoreClosedTemporary = msgStoreClosedTemporary
        self.orderDeliveryRadius = orderDeliveryRadius
        self.paymentOptions = paymentOptions
        self.paypalClientToken = paypalClientToken
        self.pgProvider = pgProvider
        self.pickupMinOffsetTime = pickupMinOffsetTime
        self.preProcess = preProcess
        self.referralShareLbl = referralShareLbl
        self.referraluiLbl = referraluiLbl
        self.simplClientid = simplClientid
        self.supportedLanguages = supportedLanguages
        self.timeSlots = timeSlots
        self.timezone = timezone
        self.tin = tin
        self.usePointOfDelivery = usePointOfDelivery
    }
    
    /**
         * NSCoding required initializer.
         * Fills the data from the passed decoder
         */
        public required init(coder aDecoder: NSCoder) {
            isdCode = (aDecoder.decodeObject(forKey: "isd_code") as? String)!
            contactPhone = (aDecoder.decodeObject(forKey: "contact_phone") as? String)!
            currency = (aDecoder.decodeObject(forKey: "currency") as? String)!
            deliveryMinOffsetTime = aDecoder.decodeInteger(forKey: "delivery_min_offset_time")
            feedbackConfig = (aDecoder.decodeObject(forKey: "feedback_config") as? [FeedbackConfig])!
            gst = aDecoder.decodeObject(forKey: "gst") as? String 
            isPickupEnabled = aDecoder.decodeBool(forKey: "is_pickup_enabled")
            minOrderTotal = aDecoder.decodeDouble(forKey: "min_order_total")
            minimumWalletCreditThreshold = aDecoder.decodeDouble(forKey: "minimum_wallet_credit_threshold")
            msgNearestStoreClosed = aDecoder.decodeObject(forKey: "msg_nearest_store_closed") as? String
            msgNoStoresNearby = aDecoder.decodeObject(forKey: "msg_no_stores_nearby") as? String
            msgStoreClosedTemporary = aDecoder.decodeObject(forKey: "msg_store_closed_temporary") as? String
            orderDeliveryRadius = aDecoder.decodeInteger(forKey: "order_delivery_radius")
            paymentOptions = (aDecoder.decodeObject(forKey: "payment_options") as? [String])!
            supportedLanguages = (aDecoder.decodeObject(forKey: "supported_languages") as? [String])!
            paypalClientToken = aDecoder.decodeObject(forKey: "paypal_client_token") as? String
            pgProvider = aDecoder.decodeObject(forKey: "pg_provider") as? String
            pickupMinOffsetTime = aDecoder.decodeInteger(forKey: "pickup_min_offset_time")
            preProcess = aDecoder.decodeBool(forKey: "pre_process")
            referralShareLbl = (aDecoder.decodeObject(forKey: "referral_share_lbl") as? String)!
            referraluiLbl = (aDecoder.decodeObject(forKey: "referral_ui_lbl") as? String)!
            simplClientid = aDecoder.decodeObject(forKey: "simpl_client_id") as? String
            timeSlots = (aDecoder.decodeObject(forKey: "time_slots") as? [TimeSlot])!
            timezone = (aDecoder.decodeObject(forKey: "timezone") as? String)!
            tin = aDecoder.decodeObject(forKey: "tin") as? String
            usePointOfDelivery = aDecoder.decodeBool(forKey: "use_point_of_delivery")
        }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Biz.self, from: data)
        self.init(contactPhone: me.contactPhone, currency: me.currency, deliveryMinOffsetTime: me.deliveryMinOffsetTime, feedbackConfig: me.feedbackConfig, gst: me.gst, isPickupEnabled: me.isPickupEnabled, isdCode: me.isdCode, minOrderTotal: me.minOrderTotal, minimumWalletCreditThreshold: me.minimumWalletCreditThreshold, msgNearestStoreClosed: me.msgNearestStoreClosed, msgNoStoresNearby: me.msgNoStoresNearby, msgStoreClosedTemporary: me.msgStoreClosedTemporary, orderDeliveryRadius: me.orderDeliveryRadius, paymentOptions: me.paymentOptions, paypalClientToken: me.paypalClientToken, pgProvider: me.pgProvider, pickupMinOffsetTime: me.pickupMinOffsetTime, preProcess: me.preProcess, referralShareLbl: me.referralShareLbl, referraluiLbl: me.referraluiLbl, simplClientid: me.simplClientid, supportedLanguages: me.supportedLanguages, timeSlots: me.timeSlots, timezone: me.timezone, tin: me.tin, usePointOfDelivery: me.usePointOfDelivery)
    }
}

// MARK: Biz convenience initializers and mutators

extension Biz {

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    public func with(
        contactPhone: String? = nil,
        currency: String? = nil,
        deliveryMinOffsetTime: Int? = nil,
        feedbackConfig: [FeedbackConfig]? = nil,
        gst: String? = nil,
        isPickupEnabled: Bool? = nil,
        isdCode: String? = nil,
        minOrderTotal: Double? = nil,
        minimumWalletCreditThreshold: Double? = nil,
        msgNearestStoreClosed: String? = nil,
        msgNoStoresNearby: String? = nil,
        msgStoreClosedTemporary: String? = nil,
        orderDeliveryRadius: Int? = nil,
        paymentOptions: [String]? = nil,
        paypalClientToken: String? = nil,
        pgProvider: String? = nil,
        pickupMinOffsetTime: Int? = nil,
        preProcess: Bool? = nil,
        referralShareLbl: String? = nil,
        referraluiLbl: String? = nil,
        simplClientid: String? = nil,
        supportedLanguages: [String]? = nil,
        timeSlots: [TimeSlot]? = nil,
        timezone: String? = nil,
        tin: String? = nil,
        usePointOfDelivery: Bool? = nil
    ) -> Biz {
        return Biz(
            contactPhone: contactPhone ?? self.contactPhone,
            currency: currency ?? self.currency,
            deliveryMinOffsetTime: deliveryMinOffsetTime ?? self.deliveryMinOffsetTime,
            feedbackConfig: feedbackConfig ?? self.feedbackConfig,
            gst: gst ?? self.gst,
            isPickupEnabled: isPickupEnabled ?? self.isPickupEnabled,
            isdCode: isdCode ?? self.isdCode,
            minOrderTotal: minOrderTotal ?? self.minOrderTotal,
            minimumWalletCreditThreshold: minimumWalletCreditThreshold ?? self.minimumWalletCreditThreshold,
            msgNearestStoreClosed: msgNearestStoreClosed ?? self.msgNearestStoreClosed,
            msgNoStoresNearby: msgNoStoresNearby ?? self.msgNoStoresNearby,
            msgStoreClosedTemporary: msgStoreClosedTemporary ?? self.msgStoreClosedTemporary,
            orderDeliveryRadius: orderDeliveryRadius ?? self.orderDeliveryRadius,
            paymentOptions: paymentOptions ?? self.paymentOptions,
            paypalClientToken: paypalClientToken ?? self.paypalClientToken,
            pgProvider: pgProvider ?? self.pgProvider,
            pickupMinOffsetTime: pickupMinOffsetTime ?? self.pickupMinOffsetTime,
            preProcess: preProcess ?? self.preProcess,
            referralShareLbl: referralShareLbl ?? self.referralShareLbl,
            referraluiLbl: referraluiLbl ?? self.referraluiLbl,
            simplClientid: simplClientid ?? self.simplClientid,
            supportedLanguages: supportedLanguages ?? self.supportedLanguages,
            timeSlots: timeSlots ?? self.timeSlots,
            timezone: timezone ?? self.timezone,
            tin: tin ?? self.tin,
            usePointOfDelivery: usePointOfDelivery ?? self.usePointOfDelivery
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    

        /**
         * NSCoding required method.
         * Encodes mode properties into the decoder
         */
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(contactPhone, forKey: "contact_phone")
            aCoder.encode(currency, forKey: "currency")
            aCoder.encode(deliveryMinOffsetTime, forKey: "delivery_min_offset_time")
            aCoder.encode(feedbackConfig, forKey: "feedback_config")
            aCoder.encode(gst, forKey: "gst")
            aCoder.encode(isPickupEnabled, forKey: "is_pickup_enabled")
            aCoder.encode(minOrderTotal, forKey: "min_order_total")
            aCoder.encode(minimumWalletCreditThreshold, forKey: "minimum_wallet_credit_threshold")
            aCoder.encode(msgNearestStoreClosed, forKey: "msg_nearest_store_closed")
            aCoder.encode(msgNoStoresNearby, forKey: "msg_no_stores_nearby")
            aCoder.encode(msgStoreClosedTemporary, forKey: "msg_store_closed_temporary")
            aCoder.encode(orderDeliveryRadius, forKey: "order_delivery_radius")
            aCoder.encode(paymentOptions, forKey: "payment_options")
            aCoder.encode(supportedLanguages, forKey: "supported_languages")
            aCoder.encode(paypalClientToken, forKey: "paypal_client_token")
            aCoder.encode(pgProvider, forKey: "pg_provider")
            aCoder.encode(pickupMinOffsetTime, forKey: "pickup_min_offset_time")
            aCoder.encode(preProcess, forKey: "pre_process")
            aCoder.encode(referralShareLbl, forKey: "referral_share_lbl")
            aCoder.encode(referraluiLbl, forKey: "referral_ui_lbl")
            aCoder.encode(simplClientid, forKey: "simpl_client_id")
            aCoder.encode(timeSlots, forKey: "time_slots")
            aCoder.encode(timezone, forKey: "timezone")
            aCoder.encode(tin, forKey: "tin")
            aCoder.encode(usePointOfDelivery, forKey: "use_point_of_delivery")
            aCoder.encode(isdCode, forKey: "isd_code")
    }
    
    public func toObjcDictionary() -> [String : AnyObject] {
        return toDictionary()
    }
}
