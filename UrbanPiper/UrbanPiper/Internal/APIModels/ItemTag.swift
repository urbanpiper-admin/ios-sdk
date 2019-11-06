// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let itemTag = try ItemTag(json)

import Foundation

// MARK: - ItemTag
@objc public class ItemTag: NSObject, Codable {
    @objc public let group: String
    @objc public let tags: [Tag]

    init(group: String, tags: [Tag]) {
        self.group = group
        self.tags = tags
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ItemTag.self, from: data)
        self.init(group: me.group, tags: me.tags)
    }
}

// MARK: ObjectTag convenience initializers and mutators

extension ItemTag {

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
        group: String? = nil,
        tags: [Tag]? = nil
    ) -> ItemTag {
        return ItemTag(
            group: group ?? self.group,
            tags: tags ?? self.tags
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
