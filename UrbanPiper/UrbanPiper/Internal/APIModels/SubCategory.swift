// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let subCategory = try SubCategory(json)

import Foundation

// MARK: - SubCategory

@objcMembers public class SubCategory: NSObject, Codable {
    public let subCategoryDescription: String?
    public let id: Int
    public let image: String?
    public let name: String
    public let slug: String?
    public let sortOrder: Int

    enum CodingKeys: String, CodingKey {
        case subCategoryDescription = "description"
        case id, image, name, slug
        case sortOrder = "sort_order"
    }

    init(subCategoryDescription: String?, id: Int, image: String?, name: String, slug: String?, sortOrder: Int) {
        self.subCategoryDescription = subCategoryDescription
        self.id = id
        self.image = image
        self.name = name
        self.slug = slug
        self.sortOrder = sortOrder
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SubCategory.self, from: data)
        self.init(subCategoryDescription: me.subCategoryDescription, id: me.id, image: me.image, name: me.name, slug: me.slug, sortOrder: me.sortOrder)
    }
}

// MARK: SubCategory convenience initializers and mutators

extension SubCategory {
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
        subCategoryDescription: String? = nil,
        id: Int? = nil,
        image: String? = nil,
        name: String? = nil,
        slug: String? = nil,
        sortOrder: Int? = nil
    ) -> SubCategory {
        SubCategory(
            subCategoryDescription: subCategoryDescription ?? self.subCategoryDescription,
            id: id ?? self.id,
            image: image ?? self.image,
            name: name ?? self.name,
            slug: slug ?? self.slug,
            sortOrder: sortOrder ?? self.sortOrder
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
