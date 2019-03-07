//
//  CartItem.swift
//  UrbanPiperSDK
//
//  Created by Vid on 11/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

public class CartItem: NSObject {

    private var optionBuilder: ItemOptionBuilder?
    public private(set) var optionsToAdd: [ItemOption] = []
    private var optionsToRemove: [ItemOption] = []
    
    public private(set)  var category : ItemCategory!
    public private(set)  var currentStock : Int!
//    public private(set)  var extras : [AnyObject]!
//    public private(set)  var foodType : String!
    public private(set)  var id : Int!
    public private(set)  var imageLandscapeUrl : String!
    public private(set)  var imageUrl : String!
//    public private(set)  var itemDesc : String!
    public private(set)  var itemPrice : Decimal!
    public private(set)  var itemTitle : String!
//    public private(set)  var likes : Int!
//    var optionGroups : [ItemOptionGroup]!
//    public private(set)  var priceDescriptor : String!
//    var serviceTaxRate : Float!
    public private(set)  var preOrderStartTime : Int?
    public private(set)  var preOrderEndTime : Int?
    public private(set)  var slug : String!
    public private(set)  var sortOrder : Int!
//    public private(set)  var subCategory : ItemCategory!
//    public private(set)  var tags : [ItemTag]!
    
    public private(set) var isRecommendedItem: Bool = false
    public private(set) var isUpsoldItem: Bool = false
    public private(set) var isSearchItem: Bool = false
    public private(set) var isItemDetailsItem: Bool = false
    internal(set) var isReorder: Bool = false

//    var vatRate : Float!
    
    public internal(set) var quantity: Int = 0
    
    public internal(set) var notes: String?
    
    public var totalAmount: Decimal {
        var totalAmount: Decimal = itemPrice ?? Decimal.zero
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

        self.currentStock = reorderItem.currentStock
        self.id = reorderItem.id
        self.imageLandscapeUrl = reorderItem.imageLandscapeUrl
        self.imageUrl = reorderItem.imageUrl
        self.itemPrice = reorderItem.itemPrice
        self.itemTitle = reorderItem.itemTitle
        self.quantity = reorderItem.quantity
//        self.serviceTaxRate = reorderItem.serviceTaxRate
//        self.vatRate = reorderItem.vatRate
        self.category = reorderItem.category
//        self.itemCategory = reorderItem.itemCategory
        
//        self.optionGroups = reorderItem.optionGroups
        self.preOrderStartTime = reorderItem.preOrderStartTime
        self.preOrderEndTime = reorderItem.preOrderEndTime
        
        for group in reorderItem.optionGroups {
            self.optionsToAdd.append(contentsOf: group.reorderOptionsToAdd)
        }
        
        isReorder = true
    }

    
    @objc public init(item: Item) {
        self.category = item.category
        self.currentStock = item.currentStock
//        self.extras = item.extras
//        self.foodType = item.foodType
        self.id = item.id
        self.imageLandscapeUrl = item.imageLandscapeUrl
        self.imageUrl = item.imageUrl
//        self.itemDesc = item.itemDesc
        
        self.itemPrice = item.itemPrice ?? Decimal.zero
        
        self.itemTitle = item.itemTitle
//        self.likes = item.likes
//        self.optionGroups = item.optionGroups
//        self.priceDescriptor = item.priceDescriptor
        self.preOrderStartTime = item.preOrderStartTime
        self.preOrderEndTime = item.preOrderEndTime
        self.slug = item.slug
        self.sortOrder = item.sortOrder
//        self.subCategory = item.subCategory
//        self.tags = item.tags
        
        self.isRecommendedItem = item.isRecommendedItem
        self.isUpsoldItem = item.isUpsoldItem
        self.isSearchItem = item.isSearchItem
        self.isItemDetailsItem = item.isItemDetailsItem
        
        self.quantity = item.quantity
        
        self.optionsToAdd = item.orderOptionsToAdd ?? []
        self.optionsToRemove = item.orderOptionsToRemove ?? []
    }
    
    convenience init(item: Item, optionBuilder: ItemOptionBuilder) {
        self.init(item: item)

        self.optionBuilder = optionBuilder

        self.optionsToAdd = optionBuilder.optionsToAdd
        self.optionsToRemove = optionBuilder.optionsToRemove
    }
    
    public func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()

        if category != nil{
            dictionary["category"] = category.toDictionary()
        }
        if currentStock != nil{
            dictionary["current_stock"] = currentStock
        }
//        if extras != nil{
//            dictionary["extras"] = extras
//        }
//        if foodType != nil{
//            dictionary["food_type"] = foodType
//        }
        if id != nil{
            dictionary["id"] = id
        }
        if imageLandscapeUrl != nil{
            dictionary["image_landscape_url"] = imageLandscapeUrl
        }
        if imageUrl != nil{
            dictionary["image_url"] = imageUrl
        }
//        if itemDesc != nil{
//            dictionary["item_desc"] = itemDesc
//        }
        if itemPrice != nil{
            dictionary["item_price"] = itemPrice
        }
        if itemTitle != nil{
            dictionary["item_title"] = itemTitle
        }
//        if likes != nil{
//            dictionary["likes"] = likes
//        }
        if optionsToAdd.count > 0{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for orderOptionsToAddElement in optionsToAdd {
//                dictionaryElements.append(orderOptionsToAddElement.toDictionary())
                dictionaryElements.append(["id": orderOptionsToAddElement.id])
            }
            dictionary["options"] = dictionaryElements
        }
        if optionsToRemove.count > 0 {
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for orderOptionsToRemoveElement in optionsToRemove {
//                dictionaryElements.append(orderOptionsToRemoveElement.toDictionary())
                dictionaryElements.append(["id": orderOptionsToRemoveElement.id])
            }
            dictionary["options_to_remove"] = dictionaryElements
        }
//        if priceDescriptor != nil{
//            dictionary["price_descriptor"] = priceDescriptor
//        }
//        if serviceTaxRate != nil{
//            dictionary["service_tax_rate"] = serviceTaxRate
//        }
        if preOrderStartTime != nil{
            dictionary["pre_order_start_time"] = preOrderStartTime
        }
        if preOrderEndTime != nil{
            dictionary["pre_order_end_time"] = preOrderEndTime
        }
        if slug != nil{
            dictionary["slug"] = slug
        }
        if sortOrder != nil{
            dictionary["sort_order"] = sortOrder
        }
//        if subCategory != nil{
//            dictionary["sub_category"] = subCategory.toDictionary()
//        }
//        if tags != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for tagsElement in tags {
//                dictionaryElements.append(tagsElement.toDictionary())
//            }
//            dictionary["tags"] = dictionaryElements
//        }
//        if vatRate != nil{
//            dictionary["vat_rate"] = vatRate
//        }
        dictionary["quantity"] = quantity
        
        if notes != nil{
            dictionary["notes"] = notes
        }
        
        return dictionary
    }
    
    public func isItemQuantityAvailable(quantity: Int) -> Bool {
        guard let stock = currentStock else { return true }
        guard stock != StockQuantity.unlimited else { return true }
        guard stock != StockQuantity.noStock else { return false }
        let currentCartStock = CartManager.shared.cartCount(for: id)
        guard stock >= currentCartStock + quantity else { return false }
        return true
    }
    
    public func equitableCheckDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [String:Any]()
//        if category != nil{
//            dictionary["category"] = category.equitableCheckDictionary()
//        }
//        if currentStock != nil{
//            dictionary["current_stock"] = currentStock
//        }
        if id != nil{
            dictionary["id"] = id
        }
        if optionsToAdd.count > 0{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for orderOptionsToAddElement in optionsToAdd {
                dictionaryElements.append(orderOptionsToAddElement.equitableCheckDictionary())
            }
            dictionary["options_to_add"] = dictionaryElements
        }
        if optionsToRemove.count > 0 {
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for orderOptionsToRemoveElement in optionsToRemove {
                dictionaryElements.append(orderOptionsToRemoveElement.equitableCheckDictionary())
            }
            dictionary["options_to_remove"] = dictionaryElements
        }
//        if itemTitle != nil{
//            dictionary["item_title"] = itemTitle
//        }
//        if optionGroups != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for optionGroupsElement in optionGroups {
//                dictionaryElements.append(optionGroupsElement.equitableCheckDictionary())
//            }
//            dictionary["option_groups"] = dictionaryElements
//        }
        return dictionary
    }
    
    static public func == (lhs: CartItem, rhs: CartItem) -> Bool {
        guard lhs.id == rhs.id, lhs.itemTitle == rhs.itemTitle else { return false }
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()
        
        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
    }
}
