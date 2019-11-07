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
    public var lastUpdatedDateString: String? = nil
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
    
    required public init(from decoder: Decoder) throws {
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
        
        self.lastUpdatedDateString = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
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
        
        self.lastUpdatedDateString = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
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
        balance = (aDecoder.decodeObject(forKey: "balance") as? Double)!
        bizid = aDecoder.decodeInteger(forKey: "biz_id")
        cardNumbers = (aDecoder.decodeObject(forKey: "card_numbers") as? [String])!
        daysSinceLastOrder = (aDecoder.decodeObject(forKey: "days_since_last_order") as? Int)!
        id = (aDecoder.decodeObject(forKey: "id") as? Int)!
        lastOrderDt = aDecoder.decodeObject(forKey: "last_order_dt") as? Date
        name = (aDecoder.decodeObject(forKey: "name") as? String)!
        username = (aDecoder.decodeObject(forKey: "username") as? String)!
        email = (aDecoder.decodeObject(forKey: "email") as? String)!
        lastUpdatedDateString = aDecoder.decodeObject(forKey: "lastUpdatedDateString") as? String
        numOfOrders = (aDecoder.decodeObject(forKey: "num_of_orders") as? Int)!
        phone = (aDecoder.decodeObject(forKey: "phone") as? String)!
        points = (aDecoder.decodeObject(forKey: "points") as? Int)!
        signupDt = (aDecoder.decodeObject(forKey: "signup_dt") as? Date)!
        totalOrderValue = (aDecoder.decodeObject(forKey: "total_order_value") as? Double)!
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
        return UserBizInfo(
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
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    // public func toDictionary() -> [String: AnyObject] {
//        var dictionary: [String: AnyObject] = [String: AnyObject]()
//        dictionary["addresses"] = addresses as AnyObject
//        dictionary["balance"] = balance as AnyObject
//        dictionary["biz_id"] = bizid as AnyObject
//        dictionary["card_numbers"] = cardNumbers as AnyObject
//        if let daysSinceLastOrder = daysSinceLastOrder {
//            dictionary["days_since_last_order"] = daysSinceLastOrder as AnyObject
//        }
//        dictionary["id"] = id as AnyObject
//        if let lastOrderDt = lastOrderDt {
//            dictionary["last_order_dt"] = lastOrderDt as AnyObject
//        }
//        dictionary["name"] = name as AnyObject
////        if let lastUpdatedDateString = lastUpdatedDateString {
////            dictionary["lastUpdatedDateString"] = lastUpdatedDateString as AnyObject
////        }
//        dictionary["num_of_orders"] = numOfOrders as AnyObject
//
//        dictionary["phone"] = phone as AnyObject
//        dictionary["points"] = points as AnyObject
//        dictionary["signup_dt"] = signupDt as AnyObject
//        dictionary["total_order_value"] = totalOrderValue as AnyObject
//        return dictionary
//    }
    
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
