// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let pastOrderItem = try PastOrderItem(json)

import Foundation

// MARK: - PastOrderItem
@objc public class PastOrderItem: NSObject, Codable {
    @objc public let charges: [Charge]
    @objc public let discount: Int
    @objc public let foodType: String
    @objc public let id: Int
    @objc public let imageLandscapeurl, imageurl: String?
    @objc public let merchantid: String
    @objc public let optionsToAdd: [OptionGroupOption]
    @objc public let optionsToRemove: [OptionGroupOption]
    @objc public let price, quantity: Int
    @objc public let taxes: [Tax]
    @objc public let title: String
    @objc public let total, totalWithTax: Double
    @objc public let unitWeight: Int

    enum CodingKeys: String, CodingKey {
        case charges, discount
        case foodType = "food_type"
        case id
        case imageLandscapeurl = "image_landscape_url"
        case imageurl = "image_url"
        case merchantid = "merchant_id"
        case optionsToAdd = "options_to_add"
        case optionsToRemove = "options_to_remove"
        case price, quantity, taxes, title, total
        case totalWithTax = "total_with_tax"
        case unitWeight = "unit_weight"
    }

    init(charges: [Charge], discount: Int, foodType: String, id: Int, imageLandscapeurl: String?, imageurl: String?, merchantid: String, optionsToAdd: [OptionGroupOption], optionsToRemove: [OptionGroupOption], price: Int, quantity: Int, taxes: [Tax], title: String, total: Double, totalWithTax: Double, unitWeight: Int) {
        self.charges = charges
        self.discount = discount
        self.foodType = foodType
        self.id = id
        self.imageLandscapeurl = imageLandscapeurl
        self.imageurl = imageurl
        self.merchantid = merchantid
        self.optionsToAdd = optionsToAdd
        self.optionsToRemove = optionsToRemove
        self.price = price
        self.quantity = quantity
        self.taxes = taxes
        self.title = title
        self.total = total
        self.totalWithTax = totalWithTax
        self.unitWeight = unitWeight
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PastOrderItem.self, from: data)
        self.init(charges: me.charges, discount: me.discount, foodType: me.foodType, id: me.id, imageLandscapeurl: me.imageLandscapeurl, imageurl: me.imageurl, merchantid: me.merchantid, optionsToAdd: me.optionsToAdd, optionsToRemove: me.optionsToRemove, price: me.price, quantity: me.quantity, taxes: me.taxes, title: me.title, total: me.total, totalWithTax: me.totalWithTax, unitWeight: me.unitWeight)
    }
}

// MARK: Item convenience initializers and mutators

extension PastOrderItem {

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
        charges: [Charge]? = nil,
        discount: Int? = nil,
        foodType: String? = nil,
        id: Int? = nil,
        imageLandscapeurl: String? = nil,
        imageurl: String? = nil,
        merchantid: String? = nil,
        optionsToAdd: [OptionGroupOption]? = nil,
        optionsToRemove: [OptionGroupOption]? = nil,
        price: Int? = nil,
        quantity: Int? = nil,
        taxes: [Tax]? = nil,
        title: String? = nil,
        total: Double? = nil,
        totalWithTax: Double? = nil,
        unitWeight: Int? = nil
    ) -> PastOrderItem {
        return PastOrderItem(
            charges: charges ?? self.charges,
            discount: discount ?? self.discount,
            foodType: foodType ?? self.foodType,
            id: id ?? self.id,
            imageLandscapeurl: imageLandscapeurl ?? self.imageLandscapeurl,
            imageurl: imageurl ?? self.imageurl,
            merchantid: merchantid ?? self.merchantid,
            optionsToAdd: optionsToAdd ?? self.optionsToAdd,
            optionsToRemove: optionsToRemove ?? self.optionsToRemove,
            price: price ?? self.price,
            quantity: quantity ?? self.quantity,
            taxes: taxes ?? self.taxes,
            title: title ?? self.title,
            total: total ?? self.total,
            totalWithTax: totalWithTax ?? self.totalWithTax,
            unitWeight: unitWeight ?? self.unitWeight
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
