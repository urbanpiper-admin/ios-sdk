// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let socialAuthResponse = try SocialLoginResponse(json)

import Foundation

// MARK: - SocialLoginResponse
@objcMembers public class SocialLoginResponse: NSObject, JSONDecodable {
    public let authKey: String
    public let biz: JSONNull?
    public let email, message, name, phone: String
    public let success: Bool
    public let timestamp, username: String
    public let token: String?

    init(authKey: String, biz: JSONNull?, email: String, message: String, name: String, phone: String, success: Bool, timestamp: String, token: String?, username: String) {
        self.authKey = authKey
        self.biz = biz
        self.email = email
        self.message = message
        self.name = name
        self.phone = phone
        self.success = success
        self.timestamp = timestamp
        self.token = token
        self.username = username
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SocialLoginResponse.self, from: data)
        self.init(authKey: me.authKey, biz: me.biz, email: me.email, message: me.message, name: me.name, phone: me.phone, success: me.success, timestamp: me.timestamp, token: me.token, username: me.username)
    }
}

// MARK: SocialLoginResponse convenience initializers and mutators

extension SocialLoginResponse {

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
        authKey: String? = nil,
        biz: JSONNull?? = nil,
        email: String? = nil,
        message: String? = nil,
        name: String? = nil,
        phone: String? = nil,
        success: Bool? = nil,
        timestamp: String? = nil,
        token: String? = nil,
        username: String? = nil
    ) -> SocialLoginResponse {
        return SocialLoginResponse(
            authKey: authKey ?? self.authKey,
            biz: biz ?? self.biz,
            email: email ?? self.email,
            message: message ?? self.message,
            name: name ?? self.name,
            phone: phone ?? self.phone,
            success: success ?? self.success,
            timestamp: timestamp ?? self.timestamp,
            token: token ?? self.token,
            username: username ?? self.username
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
