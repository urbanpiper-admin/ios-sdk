// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let redemptionCode = try RedemptionCode(json)

import Foundation

// MARK: - RedemptionCode
@objcMembers public class RedemptionCode: NSObject, Codable {
    public let expiresIn: Int
    public let redemptionCode: String
    public let validFrom: Int

    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case redemptionCode = "redemption_code"
        case validFrom = "valid_from"
    }

    init(expiresIn: Int, redemptionCode: String, validFrom: Int) {
        self.expiresIn = expiresIn
        self.redemptionCode = redemptionCode
        self.validFrom = validFrom
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RedemptionCode.self, from: data)
        self.init(expiresIn: me.expiresIn, redemptionCode: me.redemptionCode, validFrom: me.validFrom)
    }
}

// MARK: RedemptionCode convenience initializers and mutators

extension RedemptionCode {
    
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
        redemptionCode: String? = nil,
        validFrom: Int? = nil
    ) -> RedemptionCode {
        return RedemptionCode(
            expiresIn: expiresIn ?? self.expiresIn,
            redemptionCode: redemptionCode ?? self.redemptionCode,
            validFrom: validFrom ?? self.validFrom
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
