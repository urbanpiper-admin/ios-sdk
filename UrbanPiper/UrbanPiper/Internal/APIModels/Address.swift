// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let address = try Address(json)

import Foundation

// MARK: - Address

@objcMembers public class Address: NSObject, Codable {
    public let address1: String
    public let address2: String?
    public let city: String?
    public let deliverable: Bool
    public let id: Int
    public let landmark: String
    public let lat, lng: Double
    public let name, phone: String?
    public let pin: String
    public let podid: Int?
    public let subLocality: String
    public let tag: String

    enum CodingKeys: String, CodingKey {
        case address1 = "address_1"
        case address2 = "address_2"
        case city, deliverable, id, landmark, lat, lng, name, phone, pin
        case podid = "pod_id"
        case subLocality = "sub_locality"
        case tag
    }

    public init(address1: String, address2: String?, city: String?, deliverable: Bool, id: Int, landmark: String, lat: Double, lng: Double, name: String?, phone: String?, pin: String, podid: Int?, subLocality: String, tag: String) {
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.deliverable = deliverable
        self.id = id
        self.landmark = landmark
        self.lat = lat
        self.lng = lng
        self.name = name
        self.phone = phone
        self.pin = pin
        self.podid = podid
        self.subLocality = subLocality
        self.tag = tag
    }
    
    public required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

        address1 = try values.decode(String.self, forKey: .address1)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        deliverable = try values.decodeIfPresent(Bool.self, forKey: .deliverable) ?? false
        id = try values.decode(Int.self, forKey: .id)
        landmark = try values.decode(String.self, forKey: .landmark)
        lat = try values.decode(Double.self, forKey: .lat)
        lng = try values.decode(Double.self, forKey: .lng)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        pin = try values.decode(String.self, forKey: .pin)
        podid = try values.decodeIfPresent(Int.self, forKey: .podid)
        subLocality = try values.decode(String.self, forKey: .subLocality)
        tag = try values.decode(String.self, forKey: .tag)
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Address.self, from: data)
        self.init(address1: me.address1, address2: me.address2, city: me.city, deliverable: me.deliverable, id: me.id, landmark: me.landmark, lat: me.lat, lng: me.lng, name: me.name, phone: me.phone, pin: me.pin, podid: me.podid, subLocality: me.subLocality, tag: me.tag)
    }
}

// MARK: Address convenience initializers and mutators

extension Address {
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
        deliverable: Bool? = nil,
        id: Int? = nil,
        landmark: String? = nil,
        lat: Double? = nil,
        lng: Double? = nil,
        name: String? = nil,
        phone: String? = nil,
        pin: String? = nil,
        subLocality: String? = nil,
        tag: String? = nil
    ) -> Address {
        Address(
            address1: address1 ?? self.address1,
            address2: address2 ?? self.address2,
            city: city ?? self.city,
            deliverable: deliverable ?? self.deliverable,
            id: id ?? self.id,
            landmark: landmark ?? self.landmark,
            lat: lat ?? self.lat,
            lng: lng ?? self.lng,
            name: name ?? self.name,
            phone: phone ?? self.phone,
            pin: pin ?? self.pin,
            podid: self.podid,
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

    public var addressTag: AddressTag {
        guard let addressTagVal: AddressTag = AddressTag(rawValue: tag.lowercased()) else { return .other }
        return addressTagVal
    }

    public var addressString: String? {
        fullAddress?.replacingOccurrences(of: "\n", with: ", ")
    }

    public var fullAddress: String? {
        var fullAddress: String = ""
//        if let string = address1 {
            fullAddress = "\(fullAddress + address1)\n"
//        }
//        if let string = landmark {
            fullAddress = "\(fullAddress + landmark)\n"
//        }
//        if let string = subLocality {
            fullAddress = "\(fullAddress + subLocality)\n"
//        }
        if let string = city {
            fullAddress = "\(fullAddress + string)"
        }
//        if let string = pin {
            fullAddress = "\(fullAddress) - \(pin)"
//        }
        guard fullAddress.count > 0 else { return nil }
        return fullAddress
    }

    public func toObjcDictionary() -> [String: AnyObject] {
        toDictionary()
    }
}
