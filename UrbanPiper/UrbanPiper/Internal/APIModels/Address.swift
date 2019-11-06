// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let address = try Address(json)

import Foundation

public enum AddressTag: String {
    case home
    case office = "work"
    case other
}

// MARK: - Address
@objc public class Address: NSObject, Codable, NSCoding {
    @objc public let address1: String?
    @objc public let address2: String?
    @objc public let city: String?
    @objc public let deliverable: Bool
    @objc public let id: Int
    @objc public let landmark: String?
    @objc public let lat, lng: Double
    @objc public let name, phone, pin: String?
    public let podid: Int?
    @objc public let subLocality: String?
    @objc public let tag: String?

    enum CodingKeys: String, CodingKey {
        case address1 = "address_1"
        case address2 = "address_2"
        case city, deliverable, id, landmark, lat, lng, name, phone, pin
        case podid = "pod_id"
        case subLocality = "sub_locality"
        case tag
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.address1 = try values.decodeIfPresent(String.self, forKey: .address1)
        self.address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        self.city = try values.decodeIfPresent(String.self, forKey: .city)
        self.deliverable = try values.decodeIfPresent(Bool.self, forKey: .deliverable) ?? false
        self.id = try values.decode(Int.self, forKey: .id)
        self.landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
        self.lat = try values.decodeIfPresent(Double.self, forKey: .lat) ?? 0
        self.lng = try values.decodeIfPresent(Double.self, forKey: .lng) ?? 0
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.phone = try values.decodeIfPresent(String.self, forKey: .phone)
        self.pin = try values.decodeIfPresent(String.self, forKey: .pin)
        self.podid = try values.decodeIfPresent(Int.self, forKey: .podid)
        self.subLocality = try values.decodeIfPresent(String.self, forKey: .subLocality)
        self.tag = try values.decodeIfPresent(String.self, forKey: .tag)
    }

    public init(address1: String?, address2: String?, city: String?, deliverable: Bool, id: Int, landmark: String?, lat: Double, lng: Double, name: String?, phone: String?, pin: String?, podid: Int?, subLocality: String?, tag: String?) {
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
    
    @objc public required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        city = dictionary["city"] as? String

        deliverable = dictionary["deliverable"] as? Bool ?? false

        if let latitude: Double = dictionary["latitude"] as? Double {
            lat = latitude
        } else {
            lat = dictionary["lat"] as? Double ?? Double.zero
        }

        if let longitude: Double = dictionary["longitude"] as? Double {
            lng = longitude
        } else {
            lng = dictionary["lng"] as? Double ?? Double.zero
        }

        if let line1: String = dictionary["line_1"] as? String {
            address1 = line1
        } else {
            address1 = dictionary["address_1"] as? String
        }
        
        if let line2: String = dictionary["line_2"] as? String {
            address2 = line2
        } else {
            address2 = dictionary["address_2"] as? String
        }
        
        name = dictionary["name"] as? String
        phone = dictionary["phone"] as? String

        landmark = dictionary["landmark"] as? String

        id = dictionary["id"] as! Int
        pin = dictionary["pin"] as? String
        podid = dictionary["pod_id"] as? Int
        subLocality = dictionary["sub_locality"] as? String
        tag = dictionary["tag"] as? String ?? AddressTag.other.rawValue
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        address1 = aDecoder.decodeObject(forKey: "address_1") as? String
        landmark = aDecoder.decodeObject(forKey: "landmark") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        address2 = aDecoder.decodeObject(forKey: "address_2") as? String
        deliverable = aDecoder.decodeObject(forKey: "deliverable") as! Bool
        city = aDecoder.decodeObject(forKey: "city") as? String
        id = aDecoder.decodeObject(forKey: "id") as! Int
        lat = aDecoder.decodeObject(forKey: "lat") as? Double ?? Double(0)
        lng = aDecoder.decodeObject(forKey: "lng") as? Double ?? Double(0)
        pin = aDecoder.decodeObject(forKey: "pin") as? String
        podid = aDecoder.decodeObject(forKey: "pod_id") as? Int
        subLocality = aDecoder.decodeObject(forKey: "sub_locality") as? String
        tag = aDecoder.decodeObject(forKey: "tag") as? String
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
        podid: Int? = nil,
        subLocality: String? = nil,
        tag: String? = nil
    ) -> Address {
        return Address(
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
            podid: podid ?? self.podid,
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
    
    public var addressTag: AddressTag {
        guard let tagString: String = tag, let addressTagVal: AddressTag = AddressTag(rawValue: tagString.lowercased()) else { return .other }
        return addressTagVal
    }

    @objc public var addressString: String? {
        return fullAddress?.replacingOccurrences(of: "\n", with: ", ")
    }

    @objc public var fullAddress: String? {
        var fullAddress: String = ""
        if let string = address1 {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = landmark {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = subLocality {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = city {
            fullAddress = "\(fullAddress + string)"
        }
        if let string = pin {
            fullAddress = "\(fullAddress) - \(string)"
        }
        guard fullAddress.count > 0 else { return nil }
        return fullAddress
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        aCoder.encode(address1, forKey: "address_1")
        aCoder.encode(landmark, forKey: "landmark")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(deliverable, forKey: "deliverable")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
        aCoder.encode(pin, forKey: "pin")
        aCoder.encode(podid, forKey: "pod_id")
        aCoder.encode(subLocality, forKey: "sub_locality")
        aCoder.encode(tag, forKey: "tag")
    }
    
    @objc public func toObjcDictionary() -> [String : AnyObject] {
        return toDictionary()
    }
}
