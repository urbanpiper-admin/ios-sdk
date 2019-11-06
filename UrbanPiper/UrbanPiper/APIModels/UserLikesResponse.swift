// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let userLikesResponse = try UserLikesResponse(json)

import Foundation

// MARK: - UserLikesResponse
@objc public class UserLikesResponse: NSObject, JSONDecodable {
    @objc public let likes: [Like]
    @objc public let meta: Meta

    init(likes: [Like], meta: Meta) {
        self.likes = likes
        self.meta = meta
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UserLikesResponse.self, from: data)
        self.init(likes: me.likes, meta: me.meta)
    }
}

// MARK: UserLikesResponse convenience initializers and mutators

extension UserLikesResponse {

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
        likes: [Like]? = nil,
        meta: Meta? = nil
    ) -> UserLikesResponse {
        return UserLikesResponse(
            likes: likes ?? self.likes,
            meta: meta ?? self.meta
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
