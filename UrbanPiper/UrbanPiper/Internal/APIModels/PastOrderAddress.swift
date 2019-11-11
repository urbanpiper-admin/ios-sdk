// PastOrderAddress.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pastOrderAddress = try PastOrderAddress(json)

import Foundation

// MARK: - PastOrderAddress
@objcMembers public class PastOrderAddress: NSObject, Codable {
    public let city: String
    public let isGuestMode: Bool
    public let landmark: String
    public let latitude: Double
    public let line1, line2: String
    public let longitude: Double
    public let pin, subLocality, tag: String

    enum CodingKeys: String, CodingKey {
        case city
        case isGuestMode = "is_guest_mode"
        case landmark, latitude
        case line1 = "line_1"
        case line2 = "line_2"
        case longitude, pin
        case subLocality = "sub_locality"
        case tag
    }

    init(city: String, isGuestMode: Bool, landmark: String, latitude: Double, line1: String, line2: String, longitude: Double, pin: String, subLocality: String, tag: String) {
        self.city = city
        self.isGuestMode = isGuestMode
        self.landmark = landmark
        self.latitude = latitude
        self.line1 = line1
        self.line2 = line2
        self.longitude = longitude
        self.pin = pin
        self.subLocality = subLocality
        self.tag = tag
    }
}

// MARK: PastOrderAddress convenience initializers and mutators

extension PastOrderAddress {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PastOrderAddress.self, from: data)
        self.init(city: me.city, isGuestMode: me.isGuestMode, landmark: me.landmark, latitude: me.latitude, line1: me.line1, line2: me.line2, longitude: me.longitude, pin: me.pin, subLocality: me.subLocality, tag: me.tag)
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
        city: String? = nil,
        isGuestMode: Bool? = nil,
        landmark: String? = nil,
        latitude: Double? = nil,
        line1: String? = nil,
        line2: String? = nil,
        longitude: Double? = nil,
        pin: String? = nil,
        subLocality: String? = nil,
        tag: String? = nil
    ) -> PastOrderAddress {
        return PastOrderAddress(
            city: city ?? self.city,
            isGuestMode: isGuestMode ?? self.isGuestMode,
            landmark: landmark ?? self.landmark,
            latitude: latitude ?? self.latitude,
            line1: line1 ?? self.line1,
            line2: line2 ?? self.line2,
            longitude: longitude ?? self.longitude,
            pin: pin ?? self.pin,
            subLocality: subLocality ?? self.subLocality,
            tag: tag ?? self.tag
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    public var fullAddress: String? {
        var fullAddress: String = ""
//        if let string = address1 {
            fullAddress = "\(fullAddress + line1)\n"
//        }
//        if let string = landmark {
            fullAddress = "\(fullAddress + landmark)\n"
//        }
//        if let string = subLocality {
            fullAddress = "\(fullAddress + subLocality)\n"
//        }
//        if let string = city {
            fullAddress = "\(fullAddress + city)"
//        }
//        if let string = pin {
            fullAddress = "\(fullAddress) - \(pin)"
//        }
        guard fullAddress.count > 0 else { return nil }
        return fullAddress
    }

}
