// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let like = try Like(json)

import Foundation

// MARK: - Like
@objc public class Like: NSObject, Codable {
    @objc public let item: LikedItem
    @objc public let likedOn: Int

    enum CodingKeys: String, CodingKey {
        case item
        case likedOn = "liked_on"
    }

    init(item: LikedItem, likedOn: Int) {
        self.item = item
        self.likedOn = likedOn
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Like.self, from: data)
        self.init(item: me.item, likedOn: me.likedOn)
    }
}

// MARK: Like convenience initializers and mutators

extension Like {

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
        item: LikedItem? = nil,
        likedOn: Int? = nil
    ) -> Like {
        return Like(
            item: item ?? self.item,
            likedOn: likedOn ?? self.likedOn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
