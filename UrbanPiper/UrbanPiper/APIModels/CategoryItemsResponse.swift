// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let categoryItemsResponse = try CategoryItemsResponse(json)

import Foundation

// MARK: - CategoryItemsResponse

@objcMembers public class CategoryItemsResponse: NSObject, JSONDecodable {
    public let combos: [JSONAny]?
    public let meta: Meta
    public let objects: [Item]

    init(combos: [JSONAny]?, meta: Meta, objects: [Item]) {
        self.combos = combos
        self.meta = meta
        self.objects = objects
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CategoryItemsResponse.self, from: data)
        self.init(combos: me.combos, meta: me.meta, objects: me.objects)
    }
}

// MARK: CategoryItemsResponse convenience initializers and mutators

extension CategoryItemsResponse {
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
        combos: [JSONAny]? = nil,
        meta: Meta? = nil,
        objects: [Item]? = nil
    ) -> CategoryItemsResponse {
        CategoryItemsResponse(
            combos: combos ?? self.combos,
            meta: meta ?? self.meta,
            objects: objects ?? self.objects
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
