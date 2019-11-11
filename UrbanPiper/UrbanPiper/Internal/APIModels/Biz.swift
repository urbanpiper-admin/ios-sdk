// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let biz = try Biz(json)

import Foundation

// MARK: - Biz

@objcMembers public class Biz: NSObject, Codable {
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
    public let referralShareLbl, referraluiLbl: String?
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

    init(contactPhone: String?, currency: String, deliveryMinOffsetTime: Int, feedbackConfig: [FeedbackConfig], gst: String?, isPickupEnabled: Bool, isdCode: String, minOrderTotal: Double, minimumWalletCreditThreshold: Double, msgNearestStoreClosed: String?, msgNoStoresNearby: String?, msgStoreClosedTemporary: String?, orderDeliveryRadius: Int, paymentOptions: [String], paypalClientToken: String?, pgProvider: String?, pickupMinOffsetTime: Int, preProcess: Bool, referralShareLbl: String?, referraluiLbl: String?, simplClientid: String?, supportedLanguages: [String], timeSlots: [TimeSlot], timezone: String, tin: String?, usePointOfDelivery: Bool) {
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
        Biz(
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
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

    public func toObjcDictionary() -> [String: AnyObject] {
        toDictionary()
    }
}
