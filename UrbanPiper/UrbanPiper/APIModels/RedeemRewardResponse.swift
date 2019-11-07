// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let redeemRewardResponse = try RedeemRewardResponse(json)

import Foundation

// MARK: - RedeemRewardResponse
@objcMembers public class RedeemRewardResponse: NSObject, JSONDecodable {
    public let expiresIn: Int?
    public let ptsRemaining: Int?
    public let redemptionCode: String
    public let status: String
    public let message: String

    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case ptsRemaining = "ptsRemaining"
        case redemptionCode = "redemption_code"
        case status, message
    }
    
    init(expiresIn: Int?, ptsRemaining: Int?, redemptionCode: String, status: String, message: String) {
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
