// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let charge = try Charge(json)

import Foundation

// MARK: - Charge
@objcMembers public class Charge: NSObject, Codable {
    public let title: String
    public let value: Double

    init(title: String, value: Double) {
        self.title = title
        self.value = value
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Charge.self, from: data)
        self.init(title: me.title, value: me.value)
    }
}

// MARK: Charge convenience initializers and mutators

extension Charge {

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
        title: String? = nil,
        value: Double? = nil
    ) -> Charge {
        return Charge(
            title: title ?? self.title,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
