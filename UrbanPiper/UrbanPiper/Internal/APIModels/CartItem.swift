//
//  CartItem.swift
//  UrbanPiper
//
//  Created by Vid on 11/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objc public class CartItem: NSObject {
    private var optionBuilder: ItemOptionBuilder?
    public var optionsToAdd: [OptionGroupOption] = []
    private var optionsToRemove: [OptionGroupOption] = []

    public var category: ItemCategory!
    public var currentStock: Int = 0
//    public var extras : [AnyObject]!
//    public var foodType : String!
    public var id: Int = 0
    public var imageLandscapeurl: String!
    public var imageUrl: String!
//    public var itemDesc : String!
    public var itemPrice: Double!
    public var itemTitle: String!
//    public var likes : Int?
    //   var optionGroups : [ItemOptionGroup]!
//    public var priceDescriptor : String!
    //   var serviceTaxRate : Float!
    public var preOrderStartTime: Date?
    public var preOrderEndTime: Date?
    public var slug: String!
    public var sortOrder: Int = 0
//    public var subCategory : ItemCategory!
//    public var tags : [ItemTag]!

    public var isRecommendedItem: Bool = false
    public var isUpsoldItem: Bool = false
    public var isSearchItem: Bool = false
    public var isItemDetailsItem: Bool = false
    public internal(set) var isReorder: Bool = false

    //   var vatRate : Float!

    public var quantity: Int = 0

    public var notes: String?

    public var totalAmount: Double {
        var totalAmount: Double = itemPrice ?? Double.zero
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

    @objc public init(reorderItem: ReorderItem) {
        currentStock = reorderItem.currentStock
        id = reorderItem.id
        imageLandscapeurl = reorderItem.imageLandscapeurl
        imageUrl = reorderItem.imageurl
        itemPrice = reorderItem.itemPrice
        itemTitle = reorderItem.itemTitle
        quantity = reorderItem.quantity
//        self.serviceTaxRate = reorderItem.serviceTaxRate
//        self.vatRate = reorderItem.vatRate
        category = reorderItem.category
//        self.itemCategory = reorderItem.itemCategory

//        self.optionGroups = reorderItem.optionGroups
        preOrderStartTime = reorderItem.preOrderStartTime
        preOrderEndTime = reorderItem.preOrderEndTime

        for group in reorderItem.optionGroups {
            optionsToAdd.append(contentsOf: group.reorderOptionsToAdd)
        }

        isReorder = true
    }

    @objc public init(item: Item) {
        category = item.category
        currentStock = item.currentStock
//        self.extras = item.extras
//        self.foodType = item.foodType
        id = item.id
        imageLandscapeurl = item.imageLandscapeurl
        imageUrl = item.imageurl
//        self.itemDesc = item.itemDesc

        itemPrice = item.itemPrice

        itemTitle = item.itemTitle
//        self.likes = item.likes
//        self.optionGroups = item.optionGroups
//        self.priceDescriptor = item.priceDescriptor
        preOrderStartTime = item.preOrderStartTime
        preOrderEndTime = item.preOrderEndTime
        slug = item.slug
        sortOrder = item.sortOrder
//        self.subCategory = item.subCategory
//        self.tags = item.tags

        isRecommendedItem = item.isRecommendedItem
        isUpsoldItem = item.isUpsoldItem
        isSearchItem = item.isSearchItem
        isItemDetailsItem = item.isItemDetailsItem

//        self.quantity = item.quantity

        optionsToAdd = item.orderOptionsToAdd ?? []
        optionsToRemove = item.orderOptionsToRemove ?? []
    }

    convenience init(item: Item, optionBuilder: ItemOptionBuilder) {
        self.init(item: item)

        self.optionBuilder = optionBuilder

        optionsToAdd = optionBuilder.optionsToAdd
        optionsToRemove = optionBuilder.optionsToRemove
    }

    public func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()

        if let category = category {
            dictionary["category"] = category.toDictionary() as AnyObject
        }
        dictionary["current_stock"] = currentStock as AnyObject
//        if let extras = extras {
//            dictionary["extras"] = extras as AnyObject
//        }
//        if let foodType = foodType {
//            dictionary["food_type"] = foodType as AnyObject
//        }
        dictionary["id"] = id as AnyObject
        if let imageLandscapeurl = imageLandscapeurl {
            dictionary["image_landscape_url"] = imageLandscapeurl as AnyObject
        }
        if let imageUrl = imageUrl {
            dictionary["image_url"] = imageUrl as AnyObject
        }
//        if let itemDesc = itemDesc {
//            dictionary["item_desc"] = itemDesc as AnyObject
//        }
        if let itemPrice = itemPrice {
            dictionary["item_price"] = itemPrice as AnyObject
        }
        if let itemTitle = itemTitle {
            dictionary["item_title"] = itemTitle as AnyObject
        }
//        if let likes = likes {
//            dictionary["likes"] = likes as AnyObject
//        }
        if optionsToAdd.count > 0 {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for orderOptionsToAddElement in optionsToAdd {
//                dictionaryElements.append(orderOptionsToAddElement.toDictionary())
                dictionaryElements.append(["id": orderOptionsToAddElement.id as AnyObject])
            }
            dictionary["options"] = dictionaryElements as AnyObject
        }
        if optionsToRemove.count > 0 {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for orderOptionsToRemoveElement in optionsToRemove {
//                dictionaryElements.append(orderOptionsToRemoveElement.toDictionary())
                dictionaryElements.append(["id": orderOptionsToRemoveElement.id as AnyObject])
            }
            dictionary["options_to_remove"] = dictionaryElements as AnyObject
        }
//        if let priceDescriptor = priceDescriptor {
//            dictionary["price_descriptor"] = priceDescriptor as AnyObject
//        }
//        if let serviceTaxRate = serviceTaxRate {
//            dictionary["service_tax_rate"] = serviceTaxRate as AnyObject
//        }
        if let preOrderStartTime = preOrderStartTime {
            dictionary["pre_order_start_time"] = preOrderStartTime as AnyObject
        }
        if let preOrderEndTime = preOrderEndTime {
            dictionary["pre_order_end_time"] = preOrderEndTime as AnyObject
        }
        if let slug = slug {
            dictionary["slug"] = slug as AnyObject
        }

        dictionary["sort_order"] = sortOrder as AnyObject

//        if let subCategory = subCategory {
//            dictionary["sub_category"] = subCategory.toDictionary() as AnyObject
//        }
//        if let tags = tags {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for tagsElement in tags {
//                dictionaryElements.append(tagsElement.toDictionary())
//            }
//            dictionary["tags"] = dictionaryElements as AnyObject
//        }
//        if let vatRate = vatRate {
//            dictionary["vat_rate"] = vatRate as AnyObject
//        }
        dictionary["quantity"] = quantity as AnyObject

        if let notes = notes {
            dictionary["notes"] = notes as AnyObject
        }

        return dictionary
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
//        if let category = category {
//            dictionary["category"] = category.equitableCheckDictionary()
//        }
//        if let currentStock = currentStock {
//            dictionary["current_stock"] = currentStock as AnyObject
//        }
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
//        if let itemTitle = itemTitle {
//            dictionary["item_title"] = itemTitle as AnyObject
//        }
//        if let optionGroups = optionGroups {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for optionGroupsElement in optionGroups {
//                dictionaryElements.append(optionGroupsElement.equitableCheckDictionary())
//            }
//            dictionary["option_groups"] = dictionaryElements as AnyObject
//        }
        return dictionary
    }

    internal static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        guard lhs.id == rhs.id, lhs.itemTitle == rhs.itemTitle else { return false }
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()

        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
    }
}
