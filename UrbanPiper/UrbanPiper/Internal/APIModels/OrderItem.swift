// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let orderItem = try OrderItem(json)

import Foundation

// MARK: - OrderItem

@objcMembers public class OrderItem: NSObject, Codable {
    public let category: ItemCategory
    public let charges: [Charge]
    public let currentStock, id: Int
    public let imageLandscapeurl, imageurl: String
    public let itemPrice: Double
    public let itemTitle: String
    public let price: Double
    public let quantity: Int
    public let sortOrder: Int?
    public let taxPercentage: Float
    public let taxes: [Tax]
    public let totalCharge, totalTax: Double
    public let weight: Float

    enum CodingKeys: String, CodingKey {
        case category, charges
        case currentStock = "current_stock"
        case id
        case imageLandscapeurl = "image_landscape_url"
        case imageurl = "image_url"
        case itemPrice = "item_price"
        case itemTitle = "item_title"
        case price, quantity
        case sortOrder = "sort_order"
        case taxPercentage = "tax_percentage"
        case taxes
        case totalCharge = "total_charge"
        case totalTax = "total_tax"
        case weight
    }

    init(category: ItemCategory, charges: [Charge], currentStock: Int, id: Int, imageLandscapeurl: String, imageurl: String, itemPrice: Double, itemTitle: String, price: Double, quantity: Int, sortOrder: Int?, taxPercentage: Float, taxes: [Tax], totalCharge: Double, totalTax: Double, weight: Float) {
        self.category = category
        self.charges = charges
        self.currentStock = currentStock
        self.id = id
        self.imageLandscapeurl = imageLandscapeurl
        self.imageurl = imageurl
        self.itemPrice = itemPrice
        self.itemTitle = itemTitle
        self.price = price
        self.quantity = quantity
        self.sortOrder = sortOrder
        self.taxPercentage = taxPercentage
        self.taxes = taxes
        self.totalCharge = totalCharge
        self.totalTax = totalTax
        self.weight = weight
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OrderItem.self, from: data)
        self.init(category: me.category, charges: me.charges, currentStock: me.currentStock, id: me.id, imageLandscapeurl: me.imageLandscapeurl, imageurl: me.imageurl, itemPrice: me.itemPrice, itemTitle: me.itemTitle, price: me.price, quantity: me.quantity, sortOrder: me.sortOrder, taxPercentage: me.taxPercentage, taxes: me.taxes, totalCharge: me.totalCharge, totalTax: me.totalTax, weight: me.weight)
    }
}

// MARK: OrderItem convenience initializers and mutators

extension OrderItem {
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        category: ItemCategory? = nil,
        charges: [Charge]? = nil,
        currentStock: Int? = nil,
        id: Int? = nil,
        imageLandscapeurl: String? = nil,
        imageurl: String? = nil,
        itemPrice: Double? = nil,
        itemTitle: String? = nil,
        price: Double? = nil,
        quantity: Int? = nil,
        sortOrder: Int? = nil,
        taxPercentage: Float? = nil,
        taxes: [Tax]? = nil,
        totalCharge: Double? = nil,
        totalTax: Double? = nil,
        weight: Float? = nil
    ) -> OrderItem {
        OrderItem(
            category: category ?? self.category,
            charges: charges ?? self.charges,
            currentStock: currentStock ?? self.currentStock,
            id: id ?? self.id,
            imageLandscapeurl: imageLandscapeurl ?? self.imageLandscapeurl,
            imageurl: imageurl ?? self.imageurl,
            itemPrice: itemPrice ?? self.itemPrice,
            itemTitle: itemTitle ?? self.itemTitle,
            price: price ?? self.price,
            quantity: quantity ?? self.quantity,
            sortOrder: sortOrder ?? self.sortOrder,
            taxPercentage: taxPercentage ?? self.taxPercentage,
            taxes: taxes ?? self.taxes,
            totalCharge: totalCharge ?? self.totalCharge,
            totalTax: totalTax ?? self.totalTax,
            weight: weight ?? self.weight
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
