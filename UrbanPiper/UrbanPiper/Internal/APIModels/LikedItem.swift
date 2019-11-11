// LikedItem.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let likedItem = try LikedItem(json)

import Foundation

// MARK: - LikedItem

@objcMembers public class LikedItem: NSObject, Codable {
    public let id: Int
    public let itemTitle: String

    enum CodingKeys: String, CodingKey {
        case id
        case itemTitle = "item_title"
    }

    init(id: Int, itemTitle: String) {
        self.id = id
        self.itemTitle = itemTitle
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Item.self, from: data)
        self.init(id: me.id, itemTitle: me.itemTitle)
    }
}

// MARK: LikedItem convenience initializers and mutators

extension LikedItem {
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
        id: Int? = nil,
        itemTitle: String? = nil
    ) -> LikedItem {
        LikedItem(
            id: id ?? self.id,
            itemTitle: itemTitle ?? self.itemTitle
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
