// User.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try User(json)

import Foundation

@objc public enum UserStatus: Int, RawRepresentable {
    case registrationRequired
    case phoneNumberRequired
    case verifyPhoneNumber
    case registrationSuccessfullVerifyOTP
    case otpSent
    case valid

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        switch rawValue {
        case "new_registration_required": self = .registrationRequired
        case "phone_number_required": self = .phoneNumberRequired
        case "userbiz_phone_not_validated": self = .verifyPhoneNumber
        case "User has successfully been registered and validated": self = .valid
        case "User has successfully been registered.": self = .registrationSuccessfullVerifyOTP
        case "otp_sent": self = .otpSent
        default:
            return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .registrationRequired: return "new_registration_required"
        case .phoneNumberRequired: return "phone_number_required"
        case .verifyPhoneNumber: return "userbiz_phone_not_validated"
        case .registrationSuccessfullVerifyOTP: return "User has successfully been registered."
        case .otpSent: return "otp_sent"
        case .valid: return "User has successfully been registered and validated"
        }
    }
}

// MARK: - User
@objc public class User: NSObject, Codable {
    @objc public let active: Bool
    @objc public let address: String?
    @objc public let anniversary: Date?
    @objc public let anniversaryDate, birthdate: String?
    @objc public let birthday: Date?
    @objc public let currentCity: String?
    @objc public let email, firstName: String
    @objc public let gender: String?
    @objc public let lastName: String?
    @objc public let phone: String
    internal let provider: String?
    @objc public let userBizInfoResponse: UserBizInfoResponse?
    internal let jwt: JWT?
    internal let accessToken: String?
    
    public var username: String {
        return jwt!.username
    }
    
    @objc public var authKey: String {
        return jwt!.tKey
    }
    
    @objc public var phoneVerified: Bool {
        return jwt!.phoneVerified
    }

    enum CodingKeys: String, CodingKey {
        case active, address, anniversary
        case anniversaryDate = "anniversary_date"
        case birthdate, birthday
        case currentCity = "current_city"
        case email
        case firstName = "first_name"
        case gender
        case lastName = "last_name"
        case phone, provider
        case userBizInfoResponse = "user_biz_info_response"
        case jwt = "jwt"
        case accessToken = "access_token"
    }

    init(active: Bool, address: String?, anniversary: Date?, anniversaryDate: String?, birthdate: String?, birthday: Date?, currentCity: String?, email: String, firstName: String, gender: String?, lastName: String?, phone: String, provider: String?, accessToken: String?, userBizInfoResponse: UserBizInfoResponse?, jwt: JWT?) {
        self.active = active
        self.address = address
        self.anniversary = anniversary
        self.anniversaryDate = anniversaryDate
        self.birthdate = birthdate
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
        self.init(active: me.active, address: me.address, anniversary: me.anniversary, anniversaryDate: me.anniversaryDate, birthdate: me.birthdate, birthday: me.birthday, currentCity: me.currentCity, email: me.email, firstName: me.firstName, gender: me.gender, lastName: me.lastName, phone: me.phone, provider: me.provider, accessToken: me.accessToken, userBizInfoResponse: me.userBizInfoResponse, jwt: me.jwt)
    }
}

// MARK: User convenience initializers and mutators

extension User {
    
    convenience init(jwtToken: String) {
        let jwt = JWT(jwtToken: jwtToken)
        
        self.init(active: true, address: nil, anniversary: nil, anniversaryDate: nil, birthdate: nil, birthday: nil, currentCity: nil, email: jwt.email, firstName: jwt.firstName, gender: nil, lastName: nil, phone: jwt.phone, provider: nil, accessToken: nil, userBizInfoResponse: nil, jwt: jwt)
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
        anniversaryDate: String? = nil,
        birthdate: String? = nil,
        birthday: Date? = nil,
        currentCity: String? = nil,
        email: String? = nil,
        firstName: String? = nil,
        gender: String? = nil,
        lastName: String? = nil,
        phone: String? = nil,
        userBizInfoResponse: UserBizInfoResponse? = nil
    ) -> User {
        return User(
            active: active ?? self.active,
            address: address ?? self.address,
            anniversary: anniversary ?? self.anniversary,
            anniversaryDate: anniversaryDate ?? self.anniversaryDate,
            birthdate: birthdate ?? self.birthdate,
            birthday: birthday ?? self.birthday,
            currentCity: currentCity ?? self.currentCity,
            email: email ?? self.email,
            firstName: firstName ?? self.firstName,
            gender: gender ?? self.gender,
            lastName: lastName ?? self.lastName,
            phone: phone ?? self.phone,
            provider: self.provider,
            accessToken: self.accessToken,
            userBizInfoResponse: userBizInfoResponse ?? self.userBizInfoResponse,
            jwt: self.jwt
        )
    }
    
    func with(jwtToken: String) -> User {
        let jwt = JWT(jwtToken: jwtToken)
        
        return User(
            active: self.active,
            address: self.address,
            anniversary: self.anniversary,
            anniversaryDate: self.anniversaryDate,
            birthdate: self.birthdate,
            birthday: self.birthday,
            currentCity: self.currentCity,
            email: jwt.email ?? self.email,
            firstName: jwt.firstName ?? self.firstName,
            gender: self.gender,
            lastName: jwt.lastName ?? self.lastName,
            phone: jwt.phone ?? self.phone,
            provider: self.provider,
            accessToken: self.accessToken,
            userBizInfoResponse: userBizInfoResponse ?? self.userBizInfoResponse,
            jwt: jwt
        )
    }
    
    func with(userInfoResponse: UserInfoResponse) -> User {
        return User(
            active: userInfoResponse.active ?? self.active,
            address: userInfoResponse.address ?? self.address,
            anniversary: userInfoResponse.anniversary ?? self.anniversary,
            anniversaryDate: userInfoResponse.anniversaryDate ?? self.anniversaryDate,
            birthdate: userInfoResponse.birthdate ?? self.birthdate,
            birthday: userInfoResponse.birthday ?? self.birthday,
            currentCity: userInfoResponse.currentCity ?? self.currentCity,
            email: userInfoResponse.email ?? self.email,
            firstName: userInfoResponse.firstName ?? self.firstName,
            gender: userInfoResponse.gender ?? self.gender,
            lastName: userInfoResponse.lastName ?? self.lastName,
            phone: userInfoResponse.phone ?? self.phone,
            provider: self.provider,
            accessToken: self.accessToken,
            userBizInfoResponse: userBizInfoResponse ?? self.userBizInfoResponse,
            jwt: self.jwt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
