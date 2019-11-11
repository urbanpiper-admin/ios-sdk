// User.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try User(json)

import Foundation

// MARK: - User

@objcMembers public class User: NSObject, Codable, NSCoding {
    public let active: Bool
    public let address: String?
    public let anniversary: Date?
    public let birthday: Date?
    public let currentCity: String?
    public let email, firstName: String
    public let gender: String?
    public let lastName: String?
    public let phone: String
    public let provider: String?
    public let userBizInfoResponse: UserBizInfoResponse?
    internal let jwt: JWT?
    internal let accessToken: String?

    public var username: String {
        jwt!.username
    }

    public var authKey: String {
        jwt!.tKey
    }

    public var phoneVerified: Bool {
        jwt!.phoneVerified
    }

    public var emailVerified: Bool {
        jwt!.emailVerified
    }

    enum CodingKeys: String, CodingKey {
        case active, address, anniversary
        case birthday
        case currentCity = "current_city"
        case email
        case firstName = "first_name"
        case gender
        case lastName = "last_name"
        case phone, provider
        case userBizInfoResponse = "user_biz_info_response"
        case jwt
        case accessToken = "access_token"
    }

    init(active: Bool, address: String?, anniversary: Date?, birthday: Date?, currentCity: String?, email: String, firstName: String, gender: String?, lastName: String?, phone: String, provider: String?, accessToken: String?, userBizInfoResponse: UserBizInfoResponse?, jwt: JWT?) {
        self.active = active
        self.address = address
        self.anniversary = anniversary
        self.birthday = birthday
        self.currentCity = currentCity
        self.email = email
        self.firstName = firstName
        self.gender = gender
        self.lastName = lastName
        self.phone = phone
        self.accessToken = accessToken
        self.provider = provider
        self.userBizInfoResponse = userBizInfoResponse
        self.jwt = jwt
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(User.self, from: data)
        self.init(active: me.active, address: me.address, anniversary: me.anniversary, birthday: me.birthday, currentCity: me.currentCity, email: me.email, firstName: me.firstName, gender: me.gender, lastName: me.lastName, phone: me.phone, provider: me.provider, accessToken: me.accessToken, userBizInfoResponse: me.userBizInfoResponse, jwt: me.jwt)
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public required init(coder aDecoder: NSCoder) {
        active = true
        firstName = aDecoder.decodeObject(forKey: "first_name") as! String
        userBizInfoResponse = aDecoder.decodeObject(forKey: "biz") as? UserBizInfoResponse
        email = aDecoder.decodeObject(forKey: "email") as! String
        phone = aDecoder.decodeObject(forKey: "phone") as! String
        gender = aDecoder.decodeObject(forKey: "gender") as? String
        provider = aDecoder.decodeObject(forKey: "provider") as? String
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        address = aDecoder.decodeObject(forKey: "address") as? String
        anniversary = aDecoder.decodeObject(forKey: "anniversary") as? Date
        birthday = aDecoder.decodeObject(forKey: "birthday") as? Date
        currentCity = aDecoder.decodeObject(forKey: "current_city") as? String
        lastName = aDecoder.decodeObject(forKey: "last_name") as? String
        jwt = aDecoder.decodeObject(forKey: "jwt") as? JWT
    }
}

// MARK: User convenience initializers and mutators

extension User {
    convenience init(jwtToken: String) {
        let jwt = JWT(jwtToken: jwtToken)

        self.init(active: true, address: nil, anniversary: nil, birthday: nil, currentCity: nil, email: jwt.email, firstName: jwt.firstName, gender: nil, lastName: nil, phone: jwt.phone, provider: nil, accessToken: nil, userBizInfoResponse: nil, jwt: jwt)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        active: Bool? = nil,
        address: String? = nil,
        anniversary: Date? = nil,
        birthday: Date? = nil,
        currentCity: String? = nil,
        email: String? = nil,
        firstName: String? = nil,
        gender: String? = nil,
        lastName: String? = nil,
        phone: String? = nil,
        userBizInfoResponse: UserBizInfoResponse? = nil
    ) -> User {
        User(
            active: active ?? self.active,
            address: address ?? self.address,
            anniversary: anniversary ?? self.anniversary,
            birthday: birthday ?? self.birthday,
            currentCity: currentCity ?? self.currentCity,
            email: email ?? self.email,
            firstName: firstName ?? self.firstName,
            gender: gender ?? self.gender,
            lastName: lastName ?? self.lastName,
            phone: phone ?? self.phone,
            provider: provider,
            accessToken: accessToken,
            userBizInfoResponse: userBizInfoResponse ?? self.userBizInfoResponse,
            jwt: jwt
        )
    }

    func with(jwtToken: String) -> User {
        let jwt = JWT(jwtToken: jwtToken)

        return User(
            active: active,
            address: address,
            anniversary: anniversary,
            birthday: birthday,
            currentCity: currentCity,
            email: email,
            firstName: firstName,
            gender: gender,
            lastName: lastName,
            phone: phone,
            provider: provider,
            accessToken: accessToken,
            userBizInfoResponse: userBizInfoResponse,
            jwt: jwt
        )
    }

    func with(userInfoResponse: UserInfoResponse) -> User {
        User(
            active: userInfoResponse.active,
            address: userInfoResponse.address,
            anniversary: userInfoResponse.anniversary ?? anniversary,
            birthday: userInfoResponse.birthday ?? birthday,
            currentCity: userInfoResponse.currentCity ?? currentCity,
            email: userInfoResponse.email,
            firstName: userInfoResponse.firstName,
            gender: userInfoResponse.gender ?? gender,
            lastName: userInfoResponse.lastName ?? lastName,
            phone: userInfoResponse.phone,
            provider: provider,
            accessToken: accessToken,
            userBizInfoResponse: userBizInfoResponse ?? userBizInfoResponse,
            jwt: jwt
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        aCoder.encode(userBizInfoResponse, forKey: "biz")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(provider, forKey: "provider")
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(anniversary, forKey: "anniversary")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(currentCity, forKey: "current_city")
        aCoder.encode(firstName, forKey: "first_name")
        aCoder.encode(lastName, forKey: "last_name")
        aCoder.encode(jwt, forKey: "jwt")
    }
}
