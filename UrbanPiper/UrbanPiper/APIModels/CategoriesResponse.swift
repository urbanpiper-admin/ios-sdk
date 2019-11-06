// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let categoriesResponse = try CategoriesResponse(json)

import Foundation

// MARK: - CategoriesResponse
@objc public class CategoriesResponse: NSObject, JSONDecodable {
    @objc public let biz: Biz
    @objc public let clearCache: Bool
    @objc public let meta: Meta
    @objc public let objects: [Object]

    enum CodingKeys: String, CodingKey {
        case biz
        case clearCache = "clear_cache"
        case meta, objects
    }

    init(biz: Biz, clearCache: Bool, meta: Meta, objects: [Object]) {
        self.biz = biz
        self.clearCache = clearCache
        self.meta = meta
        self.objects = objects
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CategoriesResponse.self, from: data)
        self.init(biz: me.biz, clearCache: me.clearCache, meta: me.meta, objects: me.objects)
    }
}

// MARK: CategoriesResponse convenience initializers and mutators

extension CategoriesResponse {

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
        biz: Biz? = nil,
        clearCache: Bool? = nil,
        meta: Meta? = nil,
        objects: [Object]? = nil
    ) -> CategoriesResponse {
        return CategoriesResponse(
            biz: biz ?? self.biz,
            clearCache: clearCache ?? self.clearCache,
            meta: meta ?? self.meta,
            objects: objects ?? self.objects
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
