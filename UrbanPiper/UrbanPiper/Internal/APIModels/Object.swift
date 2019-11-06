// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let object = try Object(json)

import Foundation

// MARK: - Object
@objc public class Object: NSObject, Codable {
    @objc public let comboCount: Int
    @objc public let objectDescription: String?
    @objc public let id: Int
    @objc public let image: String?
    @objc public let itemCount: Int
    @objc public let loadFromWeb: Bool
    @objc public let name, slug: String
    @objc public let sortOrder: Int
    @objc public let weburl: String?
    @objc public let subCategories: [SubCategory]?

    enum CodingKeys: String, CodingKey {
        case comboCount = "combo_count"
        case objectDescription = "description"
        case id, image
        case itemCount = "item_count"
        case loadFromWeb = "load_from_web"
        case name, slug
        case sortOrder = "sort_order"
        case weburl = "web_url"
        case subCategories = "sub_categories"
    }

    init(comboCount: Int, objectDescription: String?, id: Int, image: String?, itemCount: Int, loadFromWeb: Bool, name: String, slug: String, sortOrder: Int, weburl: String?, subCategories: [SubCategory]?) {
        self.comboCount = comboCount
        self.objectDescription = objectDescription
        self.id = id
        self.image = image
        self.itemCount = itemCount
        self.loadFromWeb = loadFromWeb
        self.name = name
        self.slug = slug
        self.sortOrder = sortOrder
        self.weburl = weburl
        self.subCategories = subCategories
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Object.self, from: data)
        self.init(comboCount: me.comboCount, objectDescription: me.objectDescription, id: me.id, image: me.image, itemCount: me.itemCount, loadFromWeb: me.loadFromWeb, name: me.name, slug: me.slug, sortOrder: me.sortOrder, weburl: me.weburl, subCategories: me.subCategories)
    }
}

// MARK: Object convenience initializers and mutators

extension Object {

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
        comboCount: Int? = nil,
        objectDescription: String? = nil,
        id: Int? = nil,
        image: String? = nil,
        itemCount: Int? = nil,
        loadFromWeb: Bool? = nil,
        name: String? = nil,
        slug: String? = nil,
        sortOrder: Int? = nil,
        weburl: String? = nil,
        subCategories: [SubCategory]?? = nil
    ) -> Object {
        return Object(
            comboCount: comboCount ?? self.comboCount,
            objectDescription: objectDescription ?? self.objectDescription,
            id: id ?? self.id,
            image: image ?? self.image,
            itemCount: itemCount ?? self.itemCount,
            loadFromWeb: loadFromWeb ?? self.loadFromWeb,
            name: name ?? self.name,
            slug: slug ?? self.slug,
            sortOrder: sortOrder ?? self.sortOrder,
            weburl: weburl ?? self.weburl,
            subCategories: subCategories ?? self.subCategories
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
