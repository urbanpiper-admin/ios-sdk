//
//  CartItem.swift
//  UrbanPiper
//
//  Created by Vid on 11/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objcMembers public class CartItem: NSObject, Codable {
    private var optionBuilder: ItemOptionBuilder?
    public let optionsToAdd: [OptionGroupOption]
    private let optionsToRemove: [OptionGroupOption]

    public let category: ItemCategory
    public let currentStock: Int
    public let id: Int
    public let imageLandscapeurl: String?
    public let imageurl: String?
    public let itemPrice: Double
    public let itemTitle: String
    public let preOrderStartTime: Date?
    public let preOrderEndTime: Date?
    public let slug: String?
    public let sortOrder: Int?
    public let quantity: Int
    public let notes: String?

    var isRecommendedItem: Bool = false
    var isUpsoldItem: Bool = false
    var isSearchItem: Bool = false
    var isItemDetailsItem: Bool = false
    var isReorder: Bool = false

    enum CodingKeys: String, CodingKey {
        case category
        case currentStock = "current_stock"
        case id
        case imageLandscapeurl = "image_landscape_url"
        case imageurl = "image_url"
        case itemPrice = "item_price"
        case itemTitle = "item_title"
        case optionsToAdd = "options"
        case optionsToRemove = "options_to_remove"
        case preOrderStartTime = "pre_order_start_time"
        case preOrderEndTime = "pre_order_end_time"
        case slug
        case sortOrder = "sort_order"
        case quantity
        case notes
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CartItem.self, from: data)
        self.init(optionBuilder: me.optionBuilder, category: me.category, currentStock: me.currentStock, id: me.id, imageLandscapeurl: me.imageLandscapeurl, imageurl: me.imageurl, itemPrice: me.itemPrice, itemTitle: me.itemTitle, optionsToAdd: me.optionsToAdd, optionsToRemove: me.optionsToRemove, preOrderStartTime: me.preOrderStartTime, preOrderEndTime: me.preOrderEndTime, slug: me.slug, sortOrder: me.sortOrder, quantity: me.quantity, notes: me.notes, isReorder: me.isReorder, isRecommendedItem: me.isRecommendedItem, isUpsoldItem: me.isUpsoldItem, isSearchItem: me.isSearchItem, isItemDetailsItem: me.isItemDetailsItem)
    }

    private init(optionBuilder: ItemOptionBuilder? = nil, category: ItemCategory, currentStock: Int, id: Int, imageLandscapeurl: String?, imageurl: String?, itemPrice: Double, itemTitle: String, optionsToAdd: [OptionGroupOption], optionsToRemove: [OptionGroupOption], preOrderStartTime: Date?, preOrderEndTime: Date?, slug: String?, sortOrder: Int?, quantity: Int, notes: String?, isReorder: Bool = false, isRecommendedItem: Bool = false, isUpsoldItem: Bool = false, isSearchItem: Bool = false, isItemDetailsItem: Bool = false) {
        self.optionBuilder = optionBuilder
        self.category = category
        self.currentStock = currentStock
        self.id = id
        self.imageLandscapeurl = imageLandscapeurl
        self.imageurl = imageurl
        self.itemPrice = itemPrice
        self.itemTitle = itemTitle
        self.optionsToAdd = optionsToAdd
        self.optionsToRemove = optionsToRemove
        self.preOrderStartTime = preOrderStartTime
        self.preOrderEndTime = preOrderEndTime
        self.slug = slug
        self.sortOrder = sortOrder
        self.quantity = quantity
        self.notes = notes
        self.isReorder = isReorder
        self.isRecommendedItem = isRecommendedItem
        self.isUpsoldItem = isUpsoldItem
        self.isSearchItem = isSearchItem
        self.isItemDetailsItem = isItemDetailsItem
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(category, forKey: .category)
        try container.encode(currentStock, forKey: .currentStock)
        try container.encode(id, forKey: .id)
        try container.encode(imageLandscapeurl, forKey: .imageLandscapeurl)
        try container.encode(imageurl, forKey: .imageurl)
        try container.encode(itemPrice, forKey: .itemPrice)
        try container.encode(itemTitle, forKey: .itemTitle)
        try container.encode(preOrderStartTime, forKey: .preOrderStartTime)
        try container.encode(preOrderEndTime, forKey: .preOrderEndTime)
        try container.encode(slug, forKey: .slug)
        try container.encode(sortOrder, forKey: .sortOrder)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(notes, forKey: .notes)

        if optionsToAdd.count > 0 {
            var dictionaryElements: [[String: Int]] = [[String: Int]]()
            for orderOptionsToAddElement in optionsToAdd {
                dictionaryElements.append(["id": orderOptionsToAddElement.id])
            }
            try container.encode(dictionaryElements, forKey: .optionsToAdd)
        }
        if optionsToRemove.count > 0 {
            var dictionaryElements: [[String: Int]] = [[String: Int]]()
            for orderOptionsToRemoveElement in optionsToRemove {
                dictionaryElements.append(["id": orderOptionsToRemoveElement.id])
            }
            try container.encode(dictionaryElements, forKey: .optionsToRemove)
        }
    }

//    public func toDictionary() -> [String: AnyObject] {
//        var dictionary = [String: AnyObject]()
//
//        dictionary["category"] = category.toDictionary() as AnyObject
//        dictionary["current_stock"] = currentStock as AnyObject
//        dictionary["id"] = id as AnyObject
//        if let imageLandscapeurl = imageLandscapeurl {
//            dictionary["image_landscape_url"] = imageLandscapeurl as AnyObject
//        }
//        if let imageUrl = imageurl {
//            dictionary["image_url"] = imageUrl as AnyObject
//        }
//        dictionary["item_price"] = itemPrice as AnyObject
//        dictionary["item_title"] = itemTitle as AnyObject
//        if optionsToAdd.count > 0 {
//            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
//            for orderOptionsToAddElement in optionsToAdd {
//                dictionaryElements.append(["id": orderOptionsToAddElement.id as AnyObject])
//            }
//            dictionary["options"] = dictionaryElements as AnyObject
//        }
//        if optionsToRemove.count > 0 {
//            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
//            for orderOptionsToRemoveElement in optionsToRemove {
//                dictionaryElements.append(["id": orderOptionsToRemoveElement.id as AnyObject])
//            }
//            dictionary["options_to_remove"] = dictionaryElements as AnyObject
//        }
//        if let preOrderStartTime = preOrderStartTime {
//            dictionary["pre_order_start_time"] = preOrderStartTime as AnyObject
//        }
//        if let preOrderEndTime = preOrderEndTime {
//            dictionary["pre_order_end_time"] = preOrderEndTime as AnyObject
//        }
//        if let slug = slug {
//            dictionary["slug"] = slug as AnyObject
//        }
//
//        if let sortOrder = sortOrder {
//            dictionary["sort_order"] = sortOrder as AnyObject
//        }
//
//        dictionary["quantity"] = quantity as AnyObject
//
//        if let notes = notes {
//            dictionary["notes"] = notes as AnyObject
//        }
//
//        return dictionary
//    }

    internal static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        guard lhs.id == rhs.id, lhs.itemTitle == rhs.itemTitle else { return false }
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()

        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
    }
}

extension CartItem {
    public var totalAmount: Double {
        var totalAmount: Double = itemPrice
        for item in optionsToAdd {
            totalAmount += item.price
        }
        return totalAmount
    }

    public var descriptionText: String? {
        let descriptionText = optionBuilder?.descriptionText
        guard descriptionText == nil else { return descriptionText }
        guard let optionsText = orderOptionsText else { return nil }
        return "• \(optionsText)"
    }

    internal var orderOptionsText: String? {
        let sortedOptions = optionsToAdd.sorted { $0.title.count > $1.title.count }

        let descriptionArray: [String] = sortedOptions.compactMap { $0.title }
        guard descriptionArray.count > 0 else { return nil }
        return descriptionArray.joined(separator: ", ")
    }

    public func isItemQuantityAvailable(quantity: Int) -> Bool {
        guard currentStock != StockQuantity.unlimited else { return true }
        guard currentStock != StockQuantity.noStock else { return false }
        let currentCartStock = CartManager.shared.cartCount(for: id)
        guard currentStock >= currentCartStock + quantity else { return false }
        return true
    }

    internal func equitableCheckDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        if optionsToAdd.count > 0 {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for orderOptionsToAddElement in optionsToAdd {
                dictionaryElements.append(orderOptionsToAddElement.equitableCheckDictionary())
            }
            dictionary["options_to_add"] = dictionaryElements as AnyObject
        }
        if optionsToRemove.count > 0 {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for orderOptionsToRemoveElement in optionsToRemove {
                dictionaryElements.append(orderOptionsToRemoveElement.equitableCheckDictionary())
            }
            dictionary["options_to_remove"] = dictionaryElements as AnyObject
        }
        return dictionary
    }
}

// MARK: Object convenience initializers and mutators

extension CartItem {
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    public convenience init(reorderItem: ReorderItem) {
        let currentStock = reorderItem.currentStock
        let id = reorderItem.id
        let imageLandscapeurl = reorderItem.imageLandscapeurl
        let imageurl = reorderItem.imageurl
        let itemPrice = reorderItem.itemPrice
        let itemTitle = reorderItem.itemTitle
        let quantity = reorderItem.quantity
        let category = reorderItem.category
        let preOrderStartTime = reorderItem.preOrderStartTime
        let preOrderEndTime = reorderItem.preOrderEndTime

        var optionsToAdd: [OptionGroupOption] = []
        for group in reorderItem.optionGroups {
            optionsToAdd.append(contentsOf: group.reorderOptionsToAdd)
        }
        let optionsToRemove = [OptionGroupOption]()

        let isReorder = true

        self.init(category: category, currentStock: currentStock, id: id, imageLandscapeurl: imageLandscapeurl, imageurl: imageurl, itemPrice: itemPrice, itemTitle: itemTitle, optionsToAdd: optionsToAdd, optionsToRemove: optionsToRemove, preOrderStartTime: preOrderStartTime, preOrderEndTime: preOrderEndTime, slug: nil, sortOrder: nil, quantity: quantity, notes: nil, isReorder: isReorder)
    }

    public convenience init(item: Item) {
        let currentStock = item.currentStock
        let id = item.id
        let imageLandscapeurl = item.imageLandscapeurl
        let imageurl = item.imageurl
        let itemPrice = item.itemPrice
        let itemTitle = item.itemTitle
        let quantity = 0
        let category = item.category
        let preOrderStartTime = item.preOrderStartTime
        let preOrderEndTime = item.preOrderEndTime
        let optionsToAdd = [OptionGroupOption]()
        let optionsToRemove = [OptionGroupOption]()

        let slug = item.slug
        let sortOrder = item.sortOrder

        let isRecommendedItem = item.isRecommendedItem
        let isUpsoldItem = item.isUpsoldItem
        let isSearchItem = item.isSearchItem
        let isItemDetailsItem = item.isItemDetailsItem

        self.init(category: category, currentStock: currentStock, id: id, imageLandscapeurl: imageLandscapeurl, imageurl: imageurl, itemPrice: itemPrice, itemTitle: itemTitle, optionsToAdd: optionsToAdd, optionsToRemove: optionsToRemove, preOrderStartTime: preOrderStartTime, preOrderEndTime: preOrderEndTime, slug: slug, sortOrder: sortOrder, quantity: quantity, notes: nil, isRecommendedItem: isRecommendedItem, isUpsoldItem: isUpsoldItem, isSearchItem: isSearchItem, isItemDetailsItem: isItemDetailsItem)
    }

    convenience init(item: Item, optionBuilder: ItemOptionBuilder) {
        let currentStock = item.currentStock
        let id = item.id
        let imageLandscapeurl = item.imageLandscapeurl
        let imageurl = item.imageurl
        let itemPrice = item.itemPrice
        let itemTitle = item.itemTitle
        let quantity = 0
        let category = item.category
        let preOrderStartTime = item.preOrderStartTime
        let preOrderEndTime = item.preOrderEndTime
        let optionsToAdd = optionBuilder.optionsToAdd
        let optionsToRemove = optionBuilder.optionsToRemove

        let slug = item.slug
        let sortOrder = item.sortOrder

        let isRecommendedItem = item.isRecommendedItem
        let isUpsoldItem = item.isUpsoldItem
        let isSearchItem = item.isSearchItem
        let isItemDetailsItem = item.isItemDetailsItem

        self.init(optionBuilder: optionBuilder, category: category, currentStock: currentStock, id: id, imageLandscapeurl: imageLandscapeurl, imageurl: imageurl, itemPrice: itemPrice, itemTitle: itemTitle, optionsToAdd: optionsToAdd, optionsToRemove: optionsToRemove, preOrderStartTime: preOrderStartTime, preOrderEndTime: preOrderEndTime, slug: slug, sortOrder: sortOrder, quantity: quantity, notes: nil, isRecommendedItem: isRecommendedItem, isUpsoldItem: isUpsoldItem, isSearchItem: isSearchItem, isItemDetailsItem: isItemDetailsItem)
    }

    public func with(
        quantity: Int? = nil,
        notes: String? = nil
    ) -> CartItem {
        CartItem(optionBuilder: optionBuilder,
                 category: category,
                 currentStock: currentStock,
                 id: id,
                 imageLandscapeurl: imageLandscapeurl,
                 imageurl: imageurl,
                 itemPrice: itemPrice,
                 itemTitle: itemTitle,
                 optionsToAdd: optionsToAdd,
                 optionsToRemove: optionsToRemove,
                 preOrderStartTime: preOrderStartTime,
                 preOrderEndTime: preOrderEndTime,
                 slug: slug,
                 sortOrder: sortOrder,
                 quantity: quantity ?? self.quantity,
                 notes: notes ?? self.notes,
                 isRecommendedItem: isRecommendedItem,
                 isUpsoldItem: isUpsoldItem,
                 isSearchItem: isSearchItem,
                 isItemDetailsItem: isItemDetailsItem)
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
