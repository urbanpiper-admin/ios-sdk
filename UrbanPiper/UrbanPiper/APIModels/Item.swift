// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let item = try Item(json)

import Foundation

// MARK: - Item

@objcMembers public class Item: NSObject, JSONDecodable {
    public let category: ItemCategory
    public let currentStock: Int
    public let extras: [Extra]
    public let foodType: String
    public let fulfillmentModes: [String]?
    public let id: Int
    public let imageLandscapeurl, imageurl: String?
    public let itemDesc: String
    public let itemPrice: Double?
    public let itemTitle: String
    public let likes: Int
    public let optionGroups: [OptionGroup]?
    public let priceDescriptor: String?
    public let serviceTaxRate: Float
    public let slug: String
    public let sortOrder: Int
    public let tags: [ItemTag]
    public let vatRate: Float
    public let preOrderStartTime: Date?
    public let preOrderEndTime: Date?
    public let subCategory: SubCategory?

    internal var isRecommendedItem: Bool = false
    internal var isUpsoldItem: Bool = false
    internal var isSearchItem: Bool = false
    internal var isItemDetailsItem: Bool = false

    enum CodingKeys: String, CodingKey {
        case category
        case currentStock = "current_stock"
        case extras
        case foodType = "food_type"
        case fulfillmentModes = "fulfillment_modes"
        case id
        case imageLandscapeurl = "image_landscape_url"
        case imageurl = "image_url"
        case itemDesc = "item_desc"
        case itemPrice = "item_price"
        case itemTitle = "item_title"
        case likes
        case optionGroups = "option_groups"
        case priceDescriptor = "price_descriptor"
        case serviceTaxRate = "service_tax_rate"
        case slug
        case sortOrder = "sort_order"
        case tags
        case vatRate = "vat_rate"
        case preOrderStartTime = "pre_order_start_time"
        case preOrderEndTime = "pre_order_end_time"
        case subCategory = "sub_category"
    }

    init(category: ItemCategory, extras: [Extra], currentStock: Int, foodType: String, fulfillmentModes: [String]?, id: Int, imageLandscapeurl: String?, imageurl: String?, itemDesc: String, itemPrice: Double?, itemTitle: String, likes: Int, optionGroups: [OptionGroup]?, priceDescriptor: String?, serviceTaxRate: Float, slug: String, sortOrder: Int, tags: [ItemTag], vatRate: Float, preOrderStartTime: Date?, preOrderEndTime: Date?, subCategory: SubCategory?) {
        self.category = category
        self.currentStock = currentStock
        self.extras = extras
        self.foodType = foodType
        self.fulfillmentModes = fulfillmentModes
        self.id = id
        self.imageLandscapeurl = imageLandscapeurl
        self.imageurl = imageurl
        self.itemDesc = itemDesc
        self.itemPrice = itemPrice
        self.itemTitle = itemTitle
        self.likes = likes
        self.optionGroups = optionGroups
        self.priceDescriptor = priceDescriptor
        self.serviceTaxRate = serviceTaxRate
        self.slug = slug
        self.sortOrder = sortOrder
        self.tags = tags
        self.vatRate = vatRate
        self.preOrderStartTime = preOrderStartTime
        self.preOrderEndTime = preOrderEndTime
        self.subCategory = subCategory
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Item.self, from: data)
        self.init(category: me.category, extras: me.extras, currentStock: me.currentStock, foodType: me.foodType, fulfillmentModes: me.fulfillmentModes, id: me.id, imageLandscapeurl: me.imageLandscapeurl, imageurl: me.imageurl, itemDesc: me.itemDesc, itemPrice: me.itemPrice, itemTitle: me.itemTitle, likes: me.likes, optionGroups: me.optionGroups, priceDescriptor: me.priceDescriptor, serviceTaxRate: me.serviceTaxRate, slug: me.slug, sortOrder: me.sortOrder, tags: me.tags, vatRate: me.vatRate, preOrderStartTime: me.preOrderStartTime, preOrderEndTime: me.preOrderEndTime, subCategory: me.subCategory)
    }
}

// MARK: Object convenience initializers and mutators

extension Item {
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
        category: ItemCategory? = nil,
        currentStock: Int? = nil,
        extras: [Extra]? = nil,
        foodType: String? = nil,
        fulfillmentModes: [String]?? = nil,
        id: Int? = nil,
        imageLandscapeurl: String? = nil,
        imageurl: String? = nil,
        itemDesc: String? = nil,
        itemPrice: Double? = nil,
        itemTitle: String? = nil,
        likes: Int? = nil,
        optionGroups: [OptionGroup]? = nil,
        priceDescriptor: String? = nil,
        serviceTaxRate: Float? = nil,
        slug: String? = nil,
        sortOrder: Int? = nil,
        tags: [ItemTag]? = nil,
        vatRate: Float? = nil,
        preOrderStartTime: Date? = nil,
        preOrderEndTime: Date? = nil,
        subCategory: SubCategory? = nil
    ) -> Item {
        Item(
            category: category ?? self.category,
            extras: extras ?? self.extras,
            currentStock: currentStock ?? self.currentStock,
            foodType: foodType ?? self.foodType,
            fulfillmentModes: fulfillmentModes ?? self.fulfillmentModes,
            id: id ?? self.id,
            imageLandscapeurl: imageLandscapeurl ?? self.imageLandscapeurl,
            imageurl: imageurl ?? self.imageurl,
            itemDesc: itemDesc ?? self.itemDesc,
            itemPrice: itemPrice ?? self.itemPrice,
            itemTitle: itemTitle ?? self.itemTitle,
            likes: likes ?? self.likes,
            optionGroups: optionGroups ?? self.optionGroups,
            priceDescriptor: priceDescriptor ?? self.priceDescriptor,
            serviceTaxRate: serviceTaxRate ?? self.serviceTaxRate,
            slug: slug ?? self.slug,
            sortOrder: sortOrder ?? self.sortOrder,
            tags: tags ?? self.tags,
            vatRate: vatRate ?? self.vatRate,
            preOrderStartTime: preOrderStartTime ?? self.preOrderStartTime,
            preOrderEndTime: preOrderEndTime ?? self.preOrderEndTime,
            subCategory: subCategory ?? self.subCategory
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
