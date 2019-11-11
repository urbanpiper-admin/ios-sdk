// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let redeemed = try Redeemed(json)

import Foundation

// MARK: - Redeemed

@objcMembers public class Reward: NSObject, Codable {
    public let claimedCount: Int
    public let rewardDescription: String
    public let expiresOn: Date?
    public let id: Int
    public let imgLink: String?
    public let inStoreCouponRewards, locked: Bool
    public let points, redeemedCount: Int
    public let redemptionCodes: [RedemptionCode]
    public let title: String
    public let type: Int
    public let value: String

    enum CodingKeys: String, CodingKey {
        case claimedCount = "claimed_count"
        case rewardDescription = "description"
        case expiresOn = "expires_on"
        case id
        case imgLink = "img_link"
        case inStoreCouponRewards = "in_store_coupon_rewards"
        case locked, points
        case redeemedCount = "redeemed_count"
        case redemptionCodes = "redemption_codes"
        case title, type, value
    }

    init(claimedCount: Int, rewardDescription: String, expiresOn: Date?, id: Int, imgLink: String?, inStoreCouponRewards: Bool, locked: Bool, points: Int, redeemedCount: Int, redemptionCodes: [RedemptionCode], title: String, type: Int, value: String) {
        self.claimedCount = claimedCount
        self.rewardDescription = rewardDescription
        self.expiresOn = expiresOn
        self.id = id
        self.imgLink = imgLink
        self.inStoreCouponRewards = inStoreCouponRewards
        self.locked = locked
        self.points = points
        self.redeemedCount = redeemedCount
        self.redemptionCodes = redemptionCodes
        self.title = title
        self.type = type
        self.value = value
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Reward.self, from: data)
        self.init(claimedCount: me.claimedCount, rewardDescription: me.rewardDescription, expiresOn: me.expiresOn, id: me.id, imgLink: me.imgLink, inStoreCouponRewards: me.inStoreCouponRewards, locked: me.locked, points: me.points, redeemedCount: me.redeemedCount, redemptionCodes: me.redemptionCodes, title: me.title, type: me.type, value: me.value)
    }
}

// MARK: Redeemed convenience initializers and mutators

extension Reward {
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
        claimedCount: Int? = nil,
        rewardDescription: String? = nil,
        expiresOn: Date? = nil,
        id: Int? = nil,
        imgLink: String? = nil,
        inStoreCouponRewards: Bool? = nil,
        locked: Bool? = nil,
        points: Int? = nil,
        redeemedCount: Int? = nil,
        redemptionCodes: [RedemptionCode]? = nil,
        title: String? = nil,
        type: Int? = nil,
        value: String? = nil
    ) -> Reward {
        Reward(
            claimedCount: claimedCount ?? self.claimedCount,
            rewardDescription: rewardDescription ?? self.rewardDescription,
            expiresOn: expiresOn ?? self.expiresOn,
            id: id ?? self.id,
            imgLink: imgLink ?? self.imgLink,
            inStoreCouponRewards: inStoreCouponRewards ?? self.inStoreCouponRewards,
            locked: locked ?? self.locked,
            points: points ?? self.points,
            redeemedCount: redeemedCount ?? self.redeemedCount,
            redemptionCodes: redemptionCodes ?? self.redemptionCodes,
            title: title ?? self.title,
            type: type ?? self.type,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
