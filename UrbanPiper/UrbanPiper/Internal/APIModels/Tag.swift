// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let tag = try Tag(json)

import Foundation

// MARK: - Tag
@objc public class Tag: NSObject, Codable {
    @objc public let id: Int
    @objc public let title: String

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Tag.self, from: data)
        self.init(id: me.id, title: me.title)
    }
}

// MARK: TagTag convenience initializers and mutators

extension Tag {

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
        title: String? = nil
    ) -> Tag {
        return Tag(
            id: id ?? self.id,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
