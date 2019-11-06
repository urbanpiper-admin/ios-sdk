// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let orderItem = try OrderItem(json)

import Foundation

// MARK: - OrderItem
@objc public class OrderItem: NSObject, Codable {
    @objc public let category: ItemCategory
    @objc public let charges: [Charge]
    @objc public let currentStock, id: Int
    @objc public let imageLandscapeurl, imageurl: String
    @objc public let itemPrice: Double
    @objc public let itemTitle: String
    @objc public let price: Double
    @objc public let quantity, sortOrder: Int
    @objc public let taxPercentage: Float
    @objc public let taxes: [Tax]
    @objc public let totalCharge, totalTax: Double
    @objc public let weight: Int

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

    init(category: ItemCategory, charges: [Charge], currentStock: Int, id: Int, imageLandscapeurl: String, imageurl: String, itemPrice: Double, itemTitle: String, price: Double, quantity: Int, sortOrder: Int, taxPercentage: Float, taxes: [Tax], totalCharge: Double, totalTax: Double, weight: Int) {
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
        weight: Int? = nil
    ) -> OrderItem {
        return OrderItem(
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
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
//    // public func toDictionary() -> [String: AnyObject] {
//        var dictionary: [String: AnyObject] = [String: AnyObject]()
//        if let category = category {
//            dictionary["category"] = category.toDictionary() as AnyObject
//        }
//        if let charges = charges {
//            dictionary["charges"] = charges as AnyObject
//        }
//        if let currentStock = currentStock {
//            dictionary["current_stock"] = currentStock as AnyObject
//        }
////        if let extras = extras {
////            dictionary["extras"] = extras as AnyObject
////        }
//        if discount != nil {
//            dictionary["discount"] = discount as AnyObject
//        }
//        if let foodType = foodType {
//            dictionary["food_type"] = foodType as AnyObject
//        }
//        dictionary["id"] = id as AnyObject
//        if let imageLandscapeurl = imageLandscapeurl {
//            dictionary["image_landscape_url"] = imageLandscapeurl as AnyObject
//        }
//        if let imageUrl = imageUrl {
//            dictionary["image_url"] = imageUrl as AnyObject
//        }
//        if let itemDesc = itemDesc {
//            dictionary["item_desc"] = itemDesc as AnyObject
//        }
//        if let itemPrice = itemPrice {
//            dictionary["item_price"] = itemPrice as AnyObject
//        }
//        if let itemTitle = itemTitle {
//            dictionary["item_title"] = itemTitle as AnyObject
//        }
//        if let likes = likes {
//            dictionary["likes"] = likes as AnyObject
//        }
//        if let options = options {
//            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
//            for optionsElement in options {
//                dictionaryElements.append(optionsElement.toDictionary())
//            }
//            dictionary["options"] = dictionaryElements as AnyObject
//        }
//        if let optionsToRemove = optionsToRemove {
//            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
//            for optionsToRemoveElement in optionsToRemove {
//                dictionaryElements.append(optionsToRemoveElement.toDictionary())
//            }
//            dictionary["options_to_remove"] = dictionaryElements as AnyObject
//        }
////        if let price = price {
////            dictionary["price"] = price as AnyObject
////        }
//        if let quantity = quantity {
//            dictionary["quantity"] = quantity as AnyObject
//        }
////        if let slug = slug {
////            dictionary["slug"] = slug as AnyObject
////        }
//        if let sortOrder = sortOrder {
//            dictionary["sort_order"] = sortOrder as AnyObject
//        }
//        if let subCategory = subCategory {
//            dictionary["sub_category"] = subCategory.toDictionary() as AnyObject
//        }
////        if let tags = tags {
////            dictionary["tags"] = tags as AnyObject
////        }
//        if let taxPercentage = taxPercentage {
//            dictionary["tax_percentage"] = taxPercentage as AnyObject
//        }
//        dictionary["to_be_discounted"] = toBeDiscounted as AnyObject
//        if let taxes = taxes {
//            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
//            for taxesElement in taxes {
//                dictionaryElements.append(taxesElement.toDictionary())
//            }
//            dictionary["taxes"] = dictionaryElements as AnyObject
//        }
////        if let totalCharge = totalCharge {
////            dictionary["total_charge"] = totalCharge as AnyObject
////        }
//        if let totalTax = totalTax {
//            dictionary["total_tax"] = totalTax as AnyObject
//        }
//        if let weight = weight {
//            dictionary["weight"] = weight as AnyObject
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         category = aDecoder.decodeObject(forKey: "category") as? ItemCategory
//         charges = aDecoder.decodeObject(forKey: "charges") as? [AnyObject]
//         currentStock = aDecoder.decodeObject(forKey: "current_stock") as? Int
//         extras = aDecoder.decodeObject(forKey: "extras") as? [AnyObject]
//         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
//         imageLandscapeurl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
//         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
//         itemDesc = aDecoder.decodeObject(forKey: "item_desc") as? String
//         itemPrice = aDecoder.decodeObject(forKey: "item_price") as? Decimal
//         itemTitle = aDecoder.decodeObject(forKey: "item_title") as? String
//         likes = aDecoder.decodeObject(forKey: "likes") as? Int
//         options = aDecoder.decodeObject(forKey :"options") as? [ItemOption]
//         optionsToRemove = aDecoder.decodeObject(forKey :"options_to_remove") as? [ItemOption]
    ////         price = aDecoder.decodeObject(forKey: "price") as? Decimal
//         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
//         slug = aDecoder.decodeObject(forKey: "slug") as? String
//         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
//         tags = aDecoder.decodeObject(forKey: "tags") as? [AnyObject]
//         taxPercentage = aDecoder.decodeObject(forKey: "tax_percentage") as? Float
//         taxes = aDecoder.decodeObject(forKey :"taxes") as? [ItemTaxes]
//         totalCharge = aDecoder.decodeObject(forKey: "total_charge") as? Float
//         totalTax = aDecoder.decodeObject(forKey: "total_tax") as? Float
//         weight = aDecoder.decodeObject(forKey: "weight") as? Int
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let category = category {
//            aCoder.encode(category, forKey: "category")
//        }
//        if let charges = charges {
//            aCoder.encode(charges, forKey: "charges")
//        }
//        if let currentStock = currentStock {
//            aCoder.encode(currentStock, forKey: "current_stock")
//        }
//        if let extras = extras {
//            aCoder.encode(extras, forKey: "extras")
//        }
//        if let foodType = foodType {
//            aCoder.encode(foodType, forKey: "food_type")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let imageLandscapeurl = imageLandscapeurl {
//            aCoder.encode(imageLandscapeurl, forKey: "image_landscape_url")
//        }
//        if let imageUrl = imageUrl {
//            aCoder.encode(imageUrl, forKey: "image_url")
//        }
//        if let itemDesc = itemDesc {
//            aCoder.encode(itemDesc, forKey: "item_desc")
//        }
//        if let itemPrice = itemPrice {
//            aCoder.encode(itemPrice, forKey: "item_price")
//        }
//        if let itemTitle = itemTitle {
//            aCoder.encode(itemTitle, forKey: "item_title")
//        }
//        if let likes = likes {
//            aCoder.encode(likes, forKey: "likes")
//        }
//        if let options = options {
//            aCoder.encode(options, forKey: "options")
//        }
//        if let optionsToRemove = optionsToRemove {
//            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
//        }
    ////        if let price = price {
    ////            aCoder.encode(price, forKey: "price")
    ////        }
//        if let quantity = quantity {
//            aCoder.encode(quantity, forKey: "quantity")
//        }
//        if let slug = slug {
//            aCoder.encode(slug, forKey: "slug")
//        }
//        if let sortOrder = sortOrder {
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if let tags = tags {
//            aCoder.encode(tags, forKey: "tags")
//        }
//        if let taxPercentage = taxPercentage {
//            aCoder.encode(taxPercentage, forKey: "tax_percentage")
//        }
//        if let taxes = taxes {
//            aCoder.encode(taxes, forKey: "taxes")
//        }
//        if let totalCharge = totalCharge {
//            aCoder.encode(totalCharge, forKey: "total_charge")
//        }
//        if let totalTax = totalTax {
//            aCoder.encode(totalTax, forKey: "total_tax")
//        }
//        if let weight = weight {
//            aCoder.encode(weight, forKey: "weight")
//        }
//
//    }
}
