// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let item = try Item(json)

import Foundation

// MARK: - Item
@objc public class Item: NSObject, JSONDecodable {
    @objc public let category: ItemCategory
    @objc public let currentStock: Int
    @objc public let extras: [Extra]
    @objc public let foodType: String
    @objc public let fulfillmentModes: [String]?
    @objc public let id: Int
    @objc public let imageLandscapeurl, imageurl: String?
    @objc public let itemDesc: String
    @objc public let itemPrice: Double
    @objc public let itemTitle: String
    @objc public let likes: Int
    @objc public let optionGroups: [OptionGroup]?
    @objc public let orderOptionsToAdd: [OptionGroupOption]?
    @objc public let orderOptionsToRemove: [OptionGroupOption]?
    @objc public let priceDescriptor: String?
    @objc public let serviceTaxRate: Float
    @objc public let slug: String
    @objc public let sortOrder: Int
    @objc public let tags: [ItemTag]
    @objc public let vatRate: Float
    @objc public let preOrderStartTime: Date?
    @objc public let preOrderEndTime: Date?
    @objc public let subCategory: SubCategory?
    
    internal var isRecommendedItem: Bool = false
    internal var isUpsoldItem: Bool = false
    internal var isSearchItem: Bool = false

    internal var isItemDetailsItem: Bool = false

    public var notes: String?

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
        case orderOptionsToAdd = "options_to_add"
        case orderOptionsToRemove = "options_to_remove"
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

    init(category: ItemCategory, extras: [Extra], currentStock: Int, foodType: String, fulfillmentModes: [String]?, id: Int, imageLandscapeurl: String?, imageurl: String?, itemDesc: String, itemPrice: Double, itemTitle: String, likes: Int, optionGroups: [OptionGroup]?, orderOptionsToAdd: [OptionGroupOption]?, orderOptionsToRemove: [OptionGroupOption]?, priceDescriptor: String?, serviceTaxRate: Float, slug: String, sortOrder: Int, tags: [ItemTag], vatRate: Float, preOrderStartTime: Date?, preOrderEndTime: Date?, subCategory: SubCategory?) {
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
        self.orderOptionsToAdd = orderOptionsToAdd
        self.orderOptionsToRemove = orderOptionsToRemove
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
        self.init(category: me.category, extras: me.extras, currentStock: me.currentStock, foodType: me.foodType, fulfillmentModes: me.fulfillmentModes, id: me.id, imageLandscapeurl: me.imageLandscapeurl, imageurl: me.imageurl, itemDesc: me.itemDesc, itemPrice: me.itemPrice, itemTitle: me.itemTitle, likes: me.likes, optionGroups: me.optionGroups, orderOptionsToAdd: me.orderOptionsToAdd, orderOptionsToRemove: me.orderOptionsToRemove, priceDescriptor: me.priceDescriptor, serviceTaxRate: me.serviceTaxRate, slug: me.slug, sortOrder: me.sortOrder, tags: me.tags, vatRate: me.vatRate, preOrderStartTime: me.preOrderStartTime, preOrderEndTime: me.preOrderEndTime, subCategory: me.subCategory)
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
        orderOptionsToAdd: [OptionGroupOption]? = nil,
        orderOptionsToRemove: [OptionGroupOption]? = nil,
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
        return Item(
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
            orderOptionsToAdd: orderOptionsToAdd ?? self.orderOptionsToAdd,
            orderOptionsToRemove: orderOptionsToRemove ?? self.orderOptionsToRemove,
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
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    /**
         * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
         */
//        public func toDictionary() -> [String : AnyObject]
//        {
//            var dictionary: [String : AnyObject] = [String : AnyObject]()
//            dictionary["category"] = category.toDictionary() as AnyObject
//            dictionary["current_stock"] = currentStock as AnyObject
//            
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for itemExtraElement in extras {
//                dictionaryElements.append(itemExtraElement.toDictionary())
//            }
//            dictionary["extras"] = dictionaryElements as AnyObject
//
//            dictionary["food_type"] = foodType as AnyObject
//
//    //        if let fulfillmentModes = fulfillmentModes {
//    //            dictionary["fulfillment_modes"] = fulfillmentModes as AnyObject
//    //        }
//            dictionary["id"] = id as AnyObject
//            
//            if let imageLandscapeurl = imageLandscapeurl {
//                dictionary["image_landscape_url"] = imageLandscapeurl as AnyObject
//            }
//            if let imageurl = imageurl {
//                dictionary["image_url"] = imageurl as AnyObject
//            }
//            dictionary["item_desc"] = itemDesc as AnyObject
//            dictionary["item_price"] = itemPrice as AnyObject
//    //        if let total = total {
//    //            dictionary["total"] = total as AnyObject
//    //        }
//            dictionary["item_title"] = itemTitle as AnyObject
//            dictionary["likes"] = likes as AnyObject
//            if let optionGroups = optionGroups {
//                var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//                for optionGroupsElement in optionGroups {
//                    dictionaryElements.append(optionGroupsElement.toDictionary())
//                }
//                dictionary["option_groups"] = dictionaryElements as AnyObject
//            }
//            if let orderOptionsToAdd = orderOptionsToAdd {
//                var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//                for orderOptionsToAddElement in orderOptionsToAdd {
//                    dictionaryElements.append(orderOptionsToAddElement.toDictionary())
//                }
//                dictionary["options_to_add"] = dictionaryElements as AnyObject
//            }
//            if let orderOptionsToRemove = orderOptionsToRemove {
//                var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//                for orderOptionsToRemoveElement in orderOptionsToRemove {
//                    dictionaryElements.append(orderOptionsToRemoveElement.toDictionary())
//                }
//                dictionary["options_to_remove"] = dictionaryElements as AnyObject
//            }
//            if let priceDescriptor = priceDescriptor {
//                dictionary["price_descriptor"] = priceDescriptor as AnyObject
//            }
//    //        if let serviceTaxRate = serviceTaxRate {
//    //            dictionary["service_tax_rate"] = serviceTaxRate as AnyObject
//    //        }
//            if let preOrderStartTime = preOrderStartTime {
//                dictionary["pre_order_start_time"] = preOrderStartTime as AnyObject
//            }
//            if let preOrderEndTime = preOrderEndTime {
//                dictionary["pre_order_end_time"] = preOrderEndTime as AnyObject
//            }
//            dictionary["slug"] = slug as AnyObject
//
//            dictionary["sort_order"] = sortOrder as AnyObject
//            
//            if let subCategory = subCategory {
//                dictionary["sub_category"] = subCategory.toDictionary() as AnyObject
//            }
//    //        if let tags = tags {
//    //            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//    //            for tagsElement in tags {
//    //                dictionaryElements.append(tagsElement.toDictionary())
//    //            }
//    //            dictionary["tags"] = dictionaryElements as AnyObject
//    //        }
//    //        if let vatRate = vatRate {
//    //            dictionary["vat_rate"] = vatRate as AnyObject
//    //        }
//    //        dictionary["quantity"] = quantity as AnyObject
//
//            if let notes = notes {
//                dictionary["notes"] = notes as AnyObject
//            }
//
//            return dictionary
//        }
}
