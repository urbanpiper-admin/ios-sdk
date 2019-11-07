// JWT.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let jwt = try JWT(json)

import Foundation

// MARK: - JWT
@objcMembers public class JWT: NSObject, Codable {
    public let username, lastName: String
    public let userbizid: Int
    public let phone: String
    public let phoneVerified: Bool
    public let firstName: String
    public let emailVerified: Bool
    public let jit: String
    public let points: Int
    public let tKey: String
    public let exp, iat, balance: Int
    public let email: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case username
        case lastName = "last_name"
        case userbizid = "userbiz_id"
        case phone
        case phoneVerified = "phone_verified"
        case firstName = "first_name"
        case emailVerified = "email_verified"
        case jit, points
        case tKey = "t_key"
        case exp, iat, balance, email, token
    }

    init(username: String, lastName: String, userbizid: Int, phone: String, phoneVerified: Bool, firstName: String, emailVerified: Bool, jit: String, points: Int, tKey: String, exp: Int, iat: Int, balance: Int, email: String, token: String) {
        self.username = username
        self.lastName = lastName
        self.userbizid = userbizid
        self.phone = phone
        self.phoneVerified = phoneVerified
        self.firstName = firstName
        self.emailVerified = emailVerified
        self.jit = jit
        self.points = points
        self.tKey = tKey
        self.exp = exp
        self.iat = iat
        self.balance = balance
        self.email = email
        self.token = token
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JWT.self, from: data)
        self.init(username: me.username, lastName: me.lastName, userbizid: me.userbizid, phone: me.phone, phoneVerified: me.phoneVerified, firstName: me.firstName, emailVerified: me.emailVerified, jit: me.jit, points: me.points, tKey: me.tKey, exp: me.exp, iat: me.iat, balance: me.balance, email: me.email, token: me.token)
    }
}

// MARK: JWT convenience initializers and mutators

extension JWT {
    
    convenience init(jwtToken: String) {
        let dictionary = JWT.decode(jwtToken: jwtToken)
        
        self.init(username: dictionary["username"] as! String,
                  lastName: dictionary["last_name"] as! String,
                  userbizid: dictionary["userbiz_id"] as! Int,
                  phone: dictionary["phone"] as! String,
                  phoneVerified: dictionary["phone_verified"] as! Bool,
                  firstName: dictionary["first_name"] as! String,
                  emailVerified: dictionary["email_verified"] as! Bool,
                  jit: dictionary["jit"] as! String,
                  points: dictionary["points"] as! Int,
                  tKey: dictionary["t_key"] as! String,
                  exp: dictionary["exp"] as! Int,
                  iat: dictionary["iat"] as! Int,
                  balance: dictionary["balance"] as! Int,
                  email: dictionary["email"] as! String,
                  token: jwtToken)
    }

    static func decode(jwtToken jwt: String) -> [String: AnyObject] {
        let segments: [String?] = jwt.components(separatedBy: ".")
        guard let segment = segments[1] else { return [:] }
        return decodeJWTPart(segment) ?? [:]
    }

    static func decodeJWTPart(_ value: String) -> [String: AnyObject]? {
        guard let bodyData = base64UrlDecode(value),
            let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: AnyObject] else {
            return nil
        }

        return payload
    }
    
    static func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    var shouldRefreshToken: Bool {
        let utcTime: Int = Int(Date().timeIntervalSince1970)
        return Int(0.8 * Double(exp - iat)) < (utcTime - iat)
    }

    var tokenExpired: Bool {
        let utcTime: Int = Int(Date().timeIntervalSince1970)
        return exp < utcTime
    }

    func with(
        username: String? = nil,
        lastName: String? = nil,
        userbizid: Int? = nil,
        phone: String? = nil,
        phoneVerified: Bool? = nil,
        firstName: String? = nil,
        emailVerified: Bool? = nil,
        jit: String? = nil,
        points: Int? = nil,
        tKey: String? = nil,
        exp: Int? = nil,
        iat: Int? = nil,
        balance: Int? = nil,
        email: String? = nil,
        token: String? = nil
    ) -> JWT {
        return JWT(
            username: username ?? self.username,
            lastName: lastName ?? self.lastName,
            userbizid: userbizid ?? self.userbizid,
            phone: phone ?? self.phone,
            phoneVerified: phoneVerified ?? self.phoneVerified,
            firstName: firstName ?? self.firstName,
            emailVerified: emailVerified ?? self.emailVerified,
            jit: jit ?? self.jit,
            points: points ?? self.points,
            tKey: tKey ?? self.tKey,
            exp: exp ?? self.exp,
            iat: iat ?? self.iat,
            balance: balance ?? self.balance,
            email: email ?? self.email,
            token: token ?? self.token
        )
    }
}
