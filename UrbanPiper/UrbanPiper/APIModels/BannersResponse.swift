// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let bannersResponse = try BannersResponse(json)

import Foundation

// MARK: - BannersResponse
@objc public class BannersResponse: NSObject, JSONDecodable {
    @objc public let images: [BannerImage]
    @objc public let meta: Meta

    init(images: [BannerImage], meta: Meta) {
        self.images = images
        self.meta = meta
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(BannersResponse.self, from: data)
        self.init(images: me.images, meta: me.meta)
    }
}

// MARK: BannersResponse convenience initializers and mutators

extension BannersResponse {

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
        images: [BannerImage]? = nil,
        meta: Meta? = nil
    ) -> BannersResponse {
        return BannersResponse(
            images: images ?? self.images,
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
