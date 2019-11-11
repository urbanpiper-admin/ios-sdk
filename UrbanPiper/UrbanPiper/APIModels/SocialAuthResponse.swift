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
    public let user: User?

    init(authKey: String, biz: JSONNull?, email: String, message: String, name: String, phone: String, success: Bool, timestamp: String, token: String?, username: String, user: User?) {
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
        self.user = user
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.authKey = try container.decode(String.self, forKey: CodingKeys.authKey)
        self.biz = try container.decodeIfPresent(JSONNull.self, forKey: CodingKeys.biz)
        self.email = try container.decode(String.self, forKey: CodingKeys.email)
        self.message = try container.decode(String.self, forKey: CodingKeys.message)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.phone = try container.decode(String.self, forKey: CodingKeys.phone)
        self.success = try container.decode(Bool.self, forKey: CodingKeys.success)
        self.timestamp = try container.decode(String.self, forKey: CodingKeys.timestamp)
        self.username = try container.decode(String.self, forKey: CodingKeys.username)
        self.token = try container.decode(String.self, forKey: CodingKeys.token)
        
        if let token = token {
            self.user = User(jwtToken: token)
        } else {
            self.user = nil
        }
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SocialLoginResponse.self, from: data)
        self.init(authKey: me.authKey, biz: me.biz, email: me.email, message: me.message, name: me.name, phone: me.phone, success: me.success, timestamp: me.timestamp, token: me.token, username: me.username, user: me.user)
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
        username: String? = nil,
        user: User?
    ) -> SocialLoginResponse {
        SocialLoginResponse(
            authKey: authKey ?? self.authKey,
            biz: biz ?? self.biz,
            email: email ?? self.email,
            message: message ?? self.message,
            name: name ?? self.name,
            phone: phone ?? self.phone,
            success: success ?? self.success,
            timestamp: timestamp ?? self.timestamp,
            token: token ?? self.token,
            username: username ?? self.username,
            user: user ?? self.user
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
