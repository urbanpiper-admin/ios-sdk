// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let availability = try Availability(json)

import Foundation

// MARK: - Availability
@objcMembers public class Availability: NSObject, Codable {
    public let isAvailable: Bool
    public let name: String

    enum CodingKeys: String, CodingKey {
        case isAvailable = "is_available"
        case name
    }

    init(isAvailable: Bool, name: String) {
        self.isAvailable = isAvailable
        self.name = name
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Availability.self, from: data)
        self.init(isAvailable: me.isAvailable, name: me.name)
    }
}

// MARK: Availability convenience initializers and mutators

extension Availability {
    
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
        isAvailable: Bool? = nil,
        name: String? = nil
    ) -> Availability {
        return Availability(
            isAvailable: isAvailable ?? self.isAvailable,
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
