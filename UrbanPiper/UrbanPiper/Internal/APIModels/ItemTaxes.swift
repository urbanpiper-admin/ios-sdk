// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let tax = try Tax(json)

import Foundation

// MARK: - Tax

@objcMembers public class Tax: NSObject, Codable {
    public let rate: Int
    public let title: String
    public let value: Double

    init(rate: Int, title: String, value: Double) {
        self.rate = rate
        self.title = title
        self.value = value
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Tax.self, from: data)
        self.init(rate: me.rate, title: me.title, value: me.value)
    }
}

// MARK: Tax convenience initializers and mutators

extension Tax {
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
        rate: Int? = nil,
        title: String? = nil,
        value: Double? = nil
    ) -> Tax {
        Tax(
            rate: rate ?? self.rate,
            title: title ?? self.title,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
