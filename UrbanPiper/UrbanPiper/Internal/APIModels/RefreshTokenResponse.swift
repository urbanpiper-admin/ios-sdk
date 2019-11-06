// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let subCategory = try SubCategory(json)

import Foundation

// MARK: - SubCategory
@objc public class RefreshTokenResponse: NSObject, JSONDecodable {
    @objc public let status: String
    @objc public let message: String
    @objc public let token: String

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
        return RefreshTokenResponse(
            status: status ?? self.status,
            message: message ?? self.message,
            token: token ?? self.token
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

