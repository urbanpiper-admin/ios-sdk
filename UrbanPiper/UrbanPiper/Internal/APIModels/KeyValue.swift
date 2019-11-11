// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let keyValue = try KeyValue(json)

import Foundation

// MARK: - KeyValue

@objcMembers public class KeyValue: NSObject, Codable {
    public let id: Int
    public let key, value: String

    init(id: Int, key: String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(KeyValue.self, from: data)
        self.init(id: me.id, key: me.key, value: me.value)
    }
}

// MARK: KeyValue convenience initializers and mutators

extension KeyValue {
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
        id: Int? = nil,
        key: String? = nil,
        value: String? = nil
    ) -> KeyValue {
        KeyValue(
            id: id ?? self.id,
            key: key ?? self.key,
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
