// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let extra = try Extra(json)

import Foundation

// MARK: - Extra

@objcMembers public class Extra: NSObject, Codable {
    public let id: Int
    public let keyValues: [KeyValue]
    public let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case keyValues = "key_values"
        case name
    }

    init(id: Int, keyValues: [KeyValue], name: String) {
        self.id = id
        self.keyValues = keyValues
        self.name = name
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Extra.self, from: data)
        self.init(id: me.id, keyValues: me.keyValues, name: me.name)
    }
}

// MARK: Extra convenience initializers and mutators

extension Extra {
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
        keyValues: [KeyValue]? = nil,
        name: String? = nil
    ) -> Extra {
        Extra(
            id: id ?? self.id,
            keyValues: keyValues ?? self.keyValues,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
