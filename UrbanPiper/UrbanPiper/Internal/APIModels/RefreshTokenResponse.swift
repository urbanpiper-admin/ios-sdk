// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let subCategory = try SubCategory(json)

import Foundation

// MARK: - SubCategory

@objcMembers public class RefreshTokenResponse: NSObject, JSONDecodable {
    public let status: String
    public let message: String
    public let token: String

    init(status: String, message: String, token: String) {
        self.status = status
        self.message = message
        self.token = token
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RefreshTokenResponse.self, from: data)
        self.init(status: me.status, message: me.message, token: me.token)
    }
}

// MARK: SubCategory convenience initializers and mutators

extension RefreshTokenResponse {
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
        status: String? = nil,
        message: String? = nil,
        token: String? = nil
    ) -> RefreshTokenResponse {
        RefreshTokenResponse(
            status: status ?? self.status,
            message: message ?? self.message,
            token: token ?? self.token
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
