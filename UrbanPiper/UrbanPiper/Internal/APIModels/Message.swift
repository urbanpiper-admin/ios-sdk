// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let message = try Message(json)

import Foundation

public enum MessageType: String {
    case info
    case alert
    case promo
    case coupon
    case reward
    case cashback
}

// MARK: - Message
@objcMembers public class Message: NSObject, Codable {
    public let bannerImg: String?
    public let body: String
    public let campaignid: String?
    public let channel: String
    public let created: Date
    public let id: Int
    public let target: String?
    public let title, type: String

    enum CodingKeys: String, CodingKey {
        case bannerImg = "banner_img"
        case body
        case campaignid = "campaign_id"
        case channel, created, id, target, title, type
    }

    init(bannerImg: String?, body: String, campaignid: String?, channel: String, created: Date, id: Int, target: String?, title: String, type: String) {
        self.bannerImg = bannerImg
        self.body = body
        self.campaignid = campaignid
        self.channel = channel
        self.created = created
        self.id = id
        self.target = target
        self.title = title
        self.type = type
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Message.self, from: data)
        self.init(bannerImg: me.bannerImg, body: me.body, campaignid: me.campaignid, channel: me.channel, created: me.created, id: me.id, target: me.target, title: me.title, type: me.type)
    }
}

// MARK: Message convenience initializers and mutators

extension Message {

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
        bannerImg: String? = nil,
        body: String? = nil,
        campaignid: String? = nil,
        channel: String? = nil,
        created: Date? = nil,
        id: Int? = nil,
        target: String? = nil,
        title: String? = nil,
        type: String? = nil
    ) -> Message {
        return Message(
            bannerImg: bannerImg ?? self.bannerImg,
            body: body ?? self.body,
            campaignid: campaignid ?? self.campaignid,
            channel: channel ?? self.channel,
            created: created ?? self.created,
            id: id ?? self.id,
            target: target ?? self.target,
            title: title ?? self.title,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
