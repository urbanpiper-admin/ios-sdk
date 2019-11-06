// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let rewardsResponse = try RewardsResponse(json)

import Foundation

// MARK: - RewardsResponse
@objc public class RewardsResponse: NSObject, JSONDecodable {
    @objc public let claimed, locked: [Reward]
    @objc public let meta: Meta
    @objc public let redeemed: [Reward]
    @objc public let unlocked: [Reward]

    init(claimed: [Reward], locked: [Reward], meta: Meta, redeemed: [Reward], unlocked: [Reward]) {
        self.claimed = claimed
        self.locked = locked
        self.meta = meta
        self.redeemed = redeemed
        self.unlocked = unlocked
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RewardsResponse.self, from: data)
        self.init(claimed: me.claimed, locked: me.locked, meta: me.meta, redeemed: me.redeemed, unlocked: me.unlocked)
    }
}

// MARK: RewardsResponse convenience initializers and mutators

extension RewardsResponse {

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
        claimed: [Reward]? = nil,
        locked: [Reward]? = nil,
        meta: Meta? = nil,
        redeemed: [Reward]? = nil,
        unlocked: [Reward]? = nil
    ) -> RewardsResponse {
        return RewardsResponse(
            claimed: claimed ?? self.claimed,
            locked: locked ?? self.locked,
            meta: meta ?? self.meta,
            redeemed: redeemed ?? self.redeemed,
            unlocked: unlocked ?? self.unlocked
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
