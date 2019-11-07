// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let bannerImage = try BannerImage(json)

import Foundation

// MARK: - BannerImage
@objcMembers public class BannerImage: NSObject, Codable {
    public let created, id: Int
    public let image: String
    public let imgType, markups: String

    enum CodingKeys: String, CodingKey {
        case created, id, image
        case imgType = "img_type"
        case markups
    }

    init(created: Int, id: Int, image: String, imgType: String, markups: String) {
        self.created = created
        self.id = id
        self.image = image
        self.imgType = imgType
        self.markups = markups
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(BannerImage.self, from: data)
        self.init(created: me.created, id: me.id, image: me.image, imgType: me.imgType, markups: me.markups)
    }
}

// MARK: BannerImage convenience initializers and mutators

extension BannerImage {

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
        created: Int? = nil,
        id: Int? = nil,
        image: String? = nil,
        imgType: String? = nil,
        markups: String? = nil
    ) -> BannerImage {
        return BannerImage(
            created: created ?? self.created,
            id: id ?? self.id,
            image: image ?? self.image,
            imgType: imgType ?? self.imgType,
            markups: markups ?? self.markups
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
