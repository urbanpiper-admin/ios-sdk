// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let addAddressBody = try NewAddressBody(json)

import Foundation

// MARK: - NewAddressBody

@objcMembers public class NewAddressBody: NSObject, Codable {
    public let address1: String
    public let address2: String?
    public let city: String?
    public let landmark: String
    public let lat, lng: Double
    public let name, phone: String?
    public let pin: String
    public let subLocality: String
    public let tag: String

    enum CodingKeys: String, CodingKey {
        case address1 = "address_1"
        case address2 = "address_2"
        case city, landmark, lat, lng, name, phone, pin
        case subLocality = "sub_locality"
        case tag
    }

    public init(address1: String, address2: String?, city: String?, landmark: String, lat: Double, lng: Double, name: String?, phone: String?, pin: String, subLocality: String, tag: String) {
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.landmark = landmark
        self.lat = lat
        self.lng = lng
        self.name = name
        self.phone = phone
        self.pin = pin
        self.subLocality = subLocality
        self.tag = tag
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Address.self, from: data)
        self.init(address1: me.address1, address2: me.address2, city: me.city, landmark: me.landmark, lat: me.lat, lng: me.lng, name: me.name, phone: me.phone, pin: me.pin, subLocality: me.subLocality, tag: me.tag)
    }
}

// MARK: Address convenience initializers and mutators

extension NewAddressBody {
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
        address1: String? = nil,
        address2: String? = nil,
        city: String? = nil,
        landmark: String? = nil,
        lat: Double? = nil,
        lng: Double? = nil,
        name: String? = nil,
        phone: String? = nil,
        pin: String? = nil,
        subLocality: String? = nil,
        tag: String? = nil
    ) -> NewAddressBody {
        NewAddressBody(
            address1: address1 ?? self.address1,
            address2: address2 ?? self.address2,
            city: city ?? self.city,
            landmark: landmark ?? self.landmark,
            lat: lat ?? self.lat,
            lng: lng ?? self.lng,
            name: name ?? self.name,
            phone: phone ?? self.phone,
            pin: pin ?? self.pin,
            subLocality: subLocality ?? self.subLocality,
            tag: tag ?? self.tag
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
