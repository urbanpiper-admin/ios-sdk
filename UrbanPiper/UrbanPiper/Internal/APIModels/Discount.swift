// Discount.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let discount = try Discount(json)

import Foundation

// MARK: - Discount

@objcMembers public class Discount: NSObject, Codable {
    public let msg: String?
    public let success: Bool
    public let value: Double

    init(msg: String?, success: Bool, value: Double) {
        self.msg = msg
        self.success = success
        self.value = value
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Discount.self, from: data)
        self.init(msg: me.msg, success: me.success, value: me.value)
    }
}

// MARK: Discount convenience initializers and mutators

extension Discount {
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
        msg: String? = nil,
        success: Bool? = nil,
        value: Double? = nil
    ) -> Discount {
        Discount(
            msg: msg ?? self.msg,
            success: success ?? self.success,
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
