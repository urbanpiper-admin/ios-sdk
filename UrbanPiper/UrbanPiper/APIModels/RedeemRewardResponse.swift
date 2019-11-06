// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let redeemRewardResponse = try RedeemRewardResponse(json)

import Foundation

// MARK: - RedeemRewardResponse
@objc public class RedeemRewardResponse: NSObject, JSONDecodable {
    @objc public let expiresIn: Int
    @objc public let ptsRemaining: Int
    @objc public let redemptionCode: String
    @objc public let status: String
    @objc public let message: String

    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case ptsRemaining = "ptsRemaining"
        case redemptionCode = "redemption_code"
        case status, message
    }
    
    // This entire method could have been omitted if children is not omitted
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        redemptionCode = try values.decode(String.self, forKey: .redemptionCode)
        status = try values.decode(String.self, forKey: .status)
        message = try values.decode(String.self, forKey: .message)

        if let val = try values.decodeIfPresent(Int.self, forKey: .expiresIn) {
            expiresIn = val
        } else {
            expiresIn = 0
        }
        
        if let val = try values.decodeIfPresent(Int.self, forKey: .ptsRemaining) {
            ptsRemaining = val
        } else {
            ptsRemaining = 0
        }
    }
    
    init(expiresIn: Int, ptsRemaining: Int, redemptionCode: String, status: String, message: String) {
        self.expiresIn = expiresIn
        self.ptsRemaining = ptsRemaining
        self.redemptionCode = redemptionCode
        self.status = status
        self.message = message
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RedeemRewardResponse.self, from: data)
        self.init(expiresIn: me.expiresIn, ptsRemaining: me.ptsRemaining, redemptionCode: me.redemptionCode, status: me.status, message: me.message)
    }
}

// MARK: RedeemRewardResponse convenience initializers and mutators

extension RedeemRewardResponse {

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
        expiresIn: Int? = nil,
        ptsRemaining: Int? = nil,
        redemptionCode: String? = nil,
        status: String? = nil,
        message: String? = nil
    ) -> RedeemRewardResponse {
        return RedeemRewardResponse(
            expiresIn: expiresIn ?? self.expiresIn,
            ptsRemaining: ptsRemaining ?? self.ptsRemaining,
            redemptionCode: redemptionCode ?? self.redemptionCode,
            status: status ?? self.status,
            message: message ?? self.message
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
