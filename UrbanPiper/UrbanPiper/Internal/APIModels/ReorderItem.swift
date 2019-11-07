// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let itemsAvailable = try ReorderItem(json)

import Foundation

// MARK: - ReorderItem
@objcMembers public class ReorderItem: NSObject, Codable {
    public let category: ItemCategory
    public let currentStock, id: Int
    public let imageLandscapeurl, imageurl: String
    public let itemCategory: ItemCategory
    public let itemPrice: Double
    public let itemTitle: String
    public let optionGroups: [OptionGroup]
    public let quantity: Int
    public let serviceTaxRate, vatRate: Float
    public let preOrderStartTime: Date?
    public let preOrderEndTime: Date?


    enum CodingKeys: String, CodingKey {
        case category
        case currentStock = "current_stock"
        case id
        case imageLandscapeurl = "image_landscape_url"
        case imageurl = "image_url"
        case itemCategory = "item_category"
        case itemPrice = "item_price"
        case itemTitle = "item_title"
        case optionGroups = "option_groups"
        case quantity
        case serviceTaxRate = "service_tax_rate"
        case vatRate = "vat_rate"
        case preOrderStartTime = "pre_order_start_time"
        case preOrderEndTime = "pre_order_end_time"
    }

    init(category: ItemCategory, currentStock: Int, id: Int, imageLandscapeurl: String, imageurl: String, itemCategory: ItemCategory, itemPrice: Double, itemTitle: String, optionGroups: [OptionGroup], quantity: Int, serviceTaxRate: Float, vatRate: Float, preOrderStartTime: Date?, preOrderEndTime: Date?) {
        self.category = category
        self.currentStock = currentStock
        self.id = id
        self.imageLandscapeurl = imageLandscapeurl
        self.imageurl = imageurl
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
        self.itemTitle = itemTitle
        self.optionGroups = optionGroups
        self.quantity = quantity
        self.serviceTaxRate = serviceTaxRate
        self.vatRate = vatRate
        self.preOrderStartTime = preOrderStartTime
        self.preOrderEndTime = preOrderEndTime
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ReorderItem.self, from: data)
        self.init(category: me.category, currentStock: me.currentStock, id: me.id, imageLandscapeurl: me.imageLandscapeurl, imageurl: me.imageurl, itemCategory: me.itemCategory, itemPrice: me.itemPrice, itemTitle: me.itemTitle, optionGroups: me.optionGroups, quantity: me.quantity, serviceTaxRate: me.serviceTaxRate, vatRate: me.vatRate, preOrderStartTime: me.preOrderStartTime, preOrderEndTime: me.preOrderEndTime)
    }

}

// MARK: ReorderItem convenience initializers and mutators

extension ReorderItem {

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
        id: Int? = nil,
        imageLandscapeurl: String? = nil,
        imageurl: String? = nil,
        itemCategory: ItemCategory? = nil,
        itemPrice: Double? = nil,
        itemTitle: String? = nil,
        optionGroups: [OptionGroup]? = nil,
        quantity: Int? = nil,
        serviceTaxRate: Float? = nil,
        vatRate: Float? = nil,
        preOrderStartTime: Date? = nil,
        preOrderEndTime: Date? = nil
    ) -> ReorderItem {
        return ReorderItem(
            category: category ?? self.category,
            currentStock: currentStock ?? self.currentStock,
            id: id ?? self.id,
            imageLandscapeurl: imageLandscapeurl ?? self.imageLandscapeurl,
            imageurl: imageurl ?? self.imageurl,
            itemCategory: itemCategory ?? self.itemCategory,
            itemPrice: itemPrice ?? self.itemPrice,
            itemTitle: itemTitle ?? self.itemTitle,
            optionGroups: optionGroups ?? self.optionGroups,
            quantity: quantity ?? self.quantity,
            serviceTaxRate: serviceTaxRate ?? self.serviceTaxRate,
            vatRate: vatRate ?? self.vatRate,
            preOrderStartTime: preOrderStartTime ?? self.preOrderStartTime,
            preOrderEndTime: preOrderEndTime ?? self.preOrderEndTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
