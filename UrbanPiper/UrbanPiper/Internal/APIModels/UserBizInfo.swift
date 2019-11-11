// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let userBizInfo = try UserBizInfo(json)

import Foundation

// MARK: - UserBizInfo

@objcMembers public class UserBizInfo: NSObject, JSONDecodable, NSCoding {
    public let addresses: [Address]
    public let balance: Double
    public let bizid: Int
    public let cardNumbers: [String]
    public let daysSinceLastOrder: Int?
    public let email: String
    public let id: Int
    public let lastOrderDt: Date?
    public let name: String
    public let numOfOrders: Int
    public let phone: String
    public let points: Int
    public let signupDt: Date
    public let totalOrderValue: Double
    public let username: String
    public var lastUpdatedDateString: String?
    internal var lastOrderDateString: String? {
        if let val = lastOrderDt {
            return DateFormatter.localizedString(from: val, dateStyle: .medium, timeStyle: .short)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case addresses, balance
        case bizid = "biz_id"
        case cardNumbers = "card_numbers"
        case daysSinceLastOrder = "days_since_last_order"
        case email, id
        case lastOrderDt = "last_order_dt"
        case name
        case numOfOrders = "num_of_orders"
        case phone, points
        case signupDt = "signup_dt"
        case totalOrderValue = "total_order_value"
        case username
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        addresses = try values.decode([Address].self, forKey: .addresses)
        balance = try values.decode(Double.self, forKey: .balance)
        bizid = try values.decode(Int.self, forKey: .bizid)
        cardNumbers = try values.decode([String].self, forKey: .cardNumbers)
        daysSinceLastOrder = try values.decodeIfPresent(Int.self, forKey: .daysSinceLastOrder)
        email = try values.decode(String.self, forKey: .email)
        id = try values.decode(Int.self, forKey: .id)
        lastOrderDt = try values.decodeIfPresent(Date.self, forKey: .lastOrderDt)
        name = try values.decode(String.self, forKey: .name)
        numOfOrders = try values.decode(Int.self, forKey: .numOfOrders)
        phone = try values.decode(String.self, forKey: .phone)
        points = try values.decode(Int.self, forKey: .points)
        signupDt = try values.decode(Date.self, forKey: .signupDt)
        totalOrderValue = try values.decode(Double.self, forKey: .totalOrderValue)
        username = try values.decode(String.self, forKey: .username)

        lastUpdatedDateString = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    }

    init(addresses: [Address], balance: Double, bizid: Int, cardNumbers: [String], daysSinceLastOrder: Int?, email: String, id: Int, lastOrderDt: Date?, name: String, numOfOrders: Int, phone: String, points: Int, signupDt: Date, totalOrderValue: Double, username: String) {
        self.addresses = addresses
        self.balance = balance
        self.bizid = bizid
        self.cardNumbers = cardNumbers
        self.daysSinceLastOrder = daysSinceLastOrder
        self.email = email
        self.id = id
        self.lastOrderDt = lastOrderDt
        self.name = name
        self.numOfOrders = numOfOrders
        self.phone = phone
        self.points = points
        self.signupDt = signupDt
        self.totalOrderValue = totalOrderValue
        self.username = username

        lastUpdatedDateString = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UserBizInfo.self, from: data)
        self.init(addresses: me.addresses, balance: me.balance, bizid: me.bizid, cardNumbers: me.cardNumbers, daysSinceLastOrder: me.daysSinceLastOrder, email: me.email, id: me.id, lastOrderDt: me.lastOrderDt, name: me.name, numOfOrders: me.numOfOrders, phone: me.phone, points: me.points, signupDt: me.signupDt, totalOrderValue: me.totalOrderValue, username: me.username)
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public required init(coder aDecoder: NSCoder) {
        addresses = (aDecoder.decodeObject(forKey: "addresses") as? [Address])!
        if let decimalBalanceVal = aDecoder.decodeObject(forKey: "balance") as? NSDecimalNumber {
            balance = decimalBalanceVal.doubleValue
        } else {
            balance = aDecoder.decodeDouble(forKey: "balance")
        }

        if let bizIdObj = aDecoder.decodeObject(forKey: "biz_id") as? NSNumber {
            bizid = bizIdObj.intValue
        } else {
            bizid = aDecoder.decodeInteger(forKey: "biz_id")
        }

        cardNumbers = (aDecoder.decodeObject(forKey: "card_numbers") as? [String])!
        daysSinceLastOrder = aDecoder.decodeObject(forKey: "days_since_last_order") as? Int
        id = aDecoder.decodeInteger(forKey: "id")

        if let date = aDecoder.decodeObject(forKey: "last_order_dt") as? Date {
            lastOrderDt = date
        } else if let num = aDecoder.decodeObject(forKey: "last_order_dt") as? NSNumber {
            let val = TimeInterval(num.intValue / 1000)
            lastOrderDt = Date(timeIntervalSince1970: val)
        } else {
            lastOrderDt = nil
        }

        name = (aDecoder.decodeObject(forKey: "name") as? String)!
        username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        lastUpdatedDateString = aDecoder.decodeObject(forKey: "lastUpdatedDateString") as? String

        if let orderCountObj = aDecoder.decodeObject(forKey: "num_of_orders") as? NSNumber {
            numOfOrders = orderCountObj.intValue
        } else {
            numOfOrders = aDecoder.decodeInteger(forKey: "num_of_orders")
        }

        phone = (aDecoder.decodeObject(forKey: "phone") as? String)!

        if let pointsObj = aDecoder.decodeObject(forKey: "points") as? NSNumber {
            points = pointsObj.intValue
        } else {
            points = aDecoder.decodeInteger(forKey: "points")
        }

        if let date = aDecoder.decodeObject(forKey: "signup_dt") as? Date {
            signupDt = date
        } else {
            let val: TimeInterval
            if let num = aDecoder.decodeObject(forKey: "signup_dt") as? NSNumber {
                val = TimeInterval(num.intValue / 1000)
            } else {
                val = TimeInterval(aDecoder.decodeInteger(forKey: "signup_dt") / 1000)
            }
            signupDt = Date(timeIntervalSince1970: val)
        }

        if let decimalOrdersVal = aDecoder.decodeObject(forKey: "total_order_value") as? NSDecimalNumber {
            totalOrderValue = decimalOrdersVal.doubleValue
        } else {
            totalOrderValue = aDecoder.decodeDouble(forKey: "total_order_value")
        }
    }
}

// MARK: UserBizInfo convenience initializers and mutators

extension UserBizInfo {
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
        addresses: [Address]? = nil,
        balance: Double? = nil,
        bizid: Int? = nil,
        cardNumbers: [String]? = nil,
        daysSinceLastOrder: Int? = nil,
        email: String? = nil,
        id: Int? = nil,
        lastOrderDt: Date? = nil,
        name: String? = nil,
        numOfOrders: Int? = nil,
        phone: String? = nil,
        points: Int? = nil,
        signupDt: Date? = nil,
        totalOrderValue: Double? = nil,
        username: String? = nil
    ) -> UserBizInfo {
        UserBizInfo(
            addresses: addresses ?? self.addresses,
            balance: balance ?? self.balance,
            bizid: bizid ?? self.bizid,
            cardNumbers: cardNumbers ?? self.cardNumbers,
            daysSinceLastOrder: daysSinceLastOrder ?? self.daysSinceLastOrder,
            email: email ?? self.email,
            id: id ?? self.id,
            lastOrderDt: lastOrderDt ?? self.lastOrderDt,
            name: name ?? self.name,
            numOfOrders: numOfOrders ?? self.numOfOrders,
            phone: phone ?? self.phone,
            points: points ?? self.points,
            signupDt: signupDt ?? self.signupDt,
            totalOrderValue: totalOrderValue ?? self.totalOrderValue,
            username: username ?? self.username
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(addresses, forKey: "addresses")
        aCoder.encode(balance, forKey: "balance")
        aCoder.encode(bizid, forKey: "biz_id")
        aCoder.encode(cardNumbers, forKey: "card_numbers")
        aCoder.encode(daysSinceLastOrder, forKey: "days_since_last_order")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(lastOrderDt, forKey: "last_order_dt")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(lastUpdatedDateString, forKey: "lastUpdatedDateString")
        aCoder.encode(numOfOrders, forKey: "num_of_orders")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(points, forKey: "points")
        aCoder.encode(signupDt, forKey: "signup_dt")
        aCoder.encode(totalOrderValue, forKey: "total_order_value")
    }
}
