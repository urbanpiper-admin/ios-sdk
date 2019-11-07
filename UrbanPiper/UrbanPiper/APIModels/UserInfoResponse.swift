// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let userInfoResponse = try UserInfoResponse(json)

import Foundation

// MARK: - UserInfoResponse
@objcMembers public class UserInfoResponse: NSObject, JSONDecodable {
    public let active: Bool
    public let address: String
    public let anniversary, birthday: Date?
    public let anniversaryDate, birthdate: String?
    public let currentCity: String?
    public let email, firstName: String
    public let gender, lastName: String?
    public let phone: String

    enum CodingKeys: String, CodingKey {
        case active, address, anniversary
        case anniversaryDate = "anniversary_date"
        case birthdate, birthday
        case currentCity = "current_city"
        case email
        case firstName = "first_name"
        case gender
        case lastName = "last_name"
        case phone
    }

    init(active: Bool, address: String, anniversary: Date?, anniversaryDate: String?, birthdate: String?, birthday: Date?, currentCity: String?, email: String, firstName: String, gender: String?, lastName: String?, phone: String) {
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
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UserInfoResponse.self, from: data)
        self.init(active: me.active, address: me.address, anniversary: me.anniversary, anniversaryDate: me.anniversaryDate, birthdate: me.birthdate, birthday: me.birthday, currentCity: me.currentCity, email: me.email, firstName: me.firstName, gender: me.gender, lastName: me.lastName, phone: me.phone)
    }
}

// MARK: UserInfoResponse convenience initializers and mutators

extension UserInfoResponse {

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
        phone: String? = nil
    ) -> UserInfoResponse {
        return UserInfoResponse(
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
            phone: phone ?? self.phone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
//    /**
//         * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//    */
//    // public func toDictionary() -> [String: AnyObject] {
//        var dictionary: [String: AnyObject] = [String: AnyObject]()
//        dictionary["phone"] = phone as AnyObject
//        dictionary["first_name"] = firstName as AnyObject
//        dictionary["email"] = email as AnyObject
//        if let lastName = lastName {
//            dictionary["last_name"] = lastName as AnyObject
//        }
//        if let gender = gender {
//            dictionary["gender"] = gender as AnyObject
//        }
//        if let currentCity = currentCity {
//            dictionary["current_city"] = currentCity as AnyObject
//        }
//        if let birthday = birthday {
//            dictionary["birthday"] = birthday as AnyObject
//        }
//        if let anniversary = anniversary {
//            dictionary["anniversary"] = anniversary as AnyObject
//        }
//        if let birthdayDate = birthdate {
//            dictionary["birthday_date"] = birthdayDate as AnyObject
//        }
//        if let anniversaryDate = anniversaryDate {
//            dictionary["anniversary_date"] = anniversaryDate as AnyObject
//        }
//        dictionary["address"] = address as AnyObject
//        return dictionary
//    }

}
