// Store.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pastOrderStore = try PastOrderStore(json)

import Foundation

// MARK: - PastOrderStore
@objcMembers public class PastOrderStore: NSObject, Codable {
    public let address: String
    public let id: Int
    public let latitude, longitude: Double
    public let merchantRefid, name: String

    enum CodingKeys: String, CodingKey {
        case address, id, latitude, longitude
        case merchantRefid = "merchant_ref_id"
        case name
    }

    init(address: String, id: Int, latitude: Double, longitude: Double, merchantRefid: String, name: String) {
        self.address = address
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.merchantRefid = merchantRefid
        self.name = name
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PastOrderStore.self, from: data)
        self.init(address: me.address, id: me.id, latitude: me.latitude, longitude: me.longitude, merchantRefid: me.merchantRefid, name: me.name)
    }
}

// MARK: PastOrderStore convenience initializers and mutators

extension PastOrderStore {
    
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
        address: String? = nil,
        id: Int? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        merchantRefid: String? = nil,
        name: String? = nil
    ) -> PastOrderStore {
        return PastOrderStore(
            address: address ?? self.address,
            id: id ?? self.id,
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude,
            merchantRefid: merchantRefid ?? self.merchantRefid,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
