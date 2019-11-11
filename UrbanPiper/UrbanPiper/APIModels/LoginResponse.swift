// LoginResponse.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let loginResponse = try LoginResponse(json)

import Foundation

// MARK: - LoginResponse

@objcMembers public class LoginResponse: NSObject, JSONDecodable {
    public let status, message, token: String
    public let user: User

    init(status: String, message: String, token: String, user: User) {
        self.status = status
        self.message = message
        self.token = token
        self.user = user
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decode(String.self, forKey: CodingKeys.status)
        self.message = try container.decode(String.self, forKey: CodingKeys.message)
        self.token = try container.decode(String.self, forKey: CodingKeys.token)
        self.user = User(jwtToken: token)
    }
    

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(LoginResponse.self, from: data)
        self.init(status: me.status, message: me.message, token: me.token, user: me.user)
    }
}

// MARK: LoginResponse convenience initializers and mutators

extension LoginResponse {
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
        token: String? = nil,
        user: User? = nil
    ) -> LoginResponse {
        LoginResponse(
            status: status ?? self.status,
            message: message ?? self.message,
            token: token ?? self.token,
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
