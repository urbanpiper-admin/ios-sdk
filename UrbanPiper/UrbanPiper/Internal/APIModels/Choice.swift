// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let choice = try Choice(json)

import Foundation

// MARK: - Choice

@objcMembers public class Choice: NSObject, Codable {
    public let id, sortOrder: Int
    public let text: String

    enum CodingKeys: String, CodingKey {
        case id
        case sortOrder = "sort_order"
        case text
    }

    init(id: Int, sortOrder: Int, text: String) {
        self.id = id
        self.sortOrder = sortOrder
        self.text = text
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Choice.self, from: data)
        self.init(id: me.id, sortOrder: me.sortOrder, text: me.text)
    }
}

// MARK: Choice convenience initializers and mutators

extension Choice {
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
        sortOrder: Int? = nil,
        text: String? = nil
    ) -> Choice {
        Choice(
            id: id ?? self.id,
            sortOrder: sortOrder ?? self.sortOrder,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

}
