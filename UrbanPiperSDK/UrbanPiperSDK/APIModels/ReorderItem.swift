//
//  ReorderItem.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 21, 2019

import Foundation


@objc public class ReorderItem : NSObject, NSCoding{

    public var category : ItemCategory!
    public var currentStock : Int!
    public var id : Int!
    public var imageLandscapeUrl : String!
    public var imageUrl : String!
    public var itemCategory : ItemCategory!
    public var itemPrice : Decimal!
    @objc public var itemTitle : String!
    public var optionGroups : [ItemOptionGroup]!
    public var preOrderStartTime : Int?
    public var preOrderEndTime : Int?
    public var quantity : Int!
    public var serviceTaxRate : Int!
    public var vatRate : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        currentStock = dictionary["current_stock"] as? Int
        id = dictionary["id"] as? Int
        imageLandscapeUrl = dictionary["image_landscape_url"] as? String
        imageUrl = dictionary["image_url"] as? String
     
        let priceVal: Any = dictionary["item_price"] ?? Decimal.zero
        if let val: Decimal = priceVal as? Decimal {
            itemPrice = val
        } else if let val: Double = priceVal as? Double {
            itemPrice = Decimal(val).rounded
        } else {
            itemPrice = Decimal.zero
        }
        
        itemTitle = dictionary["item_title"] as? String
        quantity = dictionary["quantity"] as? Int
        serviceTaxRate = dictionary["service_tax_rate"] as? Int
        vatRate = dictionary["vat_rate"] as? Int
        if let categoryData = dictionary["category"] as? [String:Any]{
            category = ItemCategory(fromDictionary: categoryData)
        }
        if let itemCategoryData = dictionary["item_category"] as? [String:Any]{
            itemCategory = ItemCategory(fromDictionary: itemCategoryData)
        }
        optionGroups = [ItemOptionGroup]()
        if let optionGroupsArray = dictionary["option_groups"] as? [[String:Any]]{
            for dic in optionGroupsArray{
                let value = ItemOptionGroup(fromDictionary: dic)
                optionGroups.append(value)
            }
        }
        preOrderStartTime = dictionary["pre_order_start_time"] as? Int
        preOrderEndTime = dictionary["pre_order_end_time"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if currentStock != nil{
            dictionary["current_stock"] = currentStock
        }
        if id != nil{
            dictionary["id"] = id
        }
        if imageLandscapeUrl != nil{
            dictionary["image_landscape_url"] = imageLandscapeUrl
        }
        if imageUrl != nil{
            dictionary["image_url"] = imageUrl
        }
        if itemPrice != nil{
            dictionary["item_price"] = itemPrice
        }
        if itemTitle != nil{
            dictionary["item_title"] = itemTitle
        }
        if quantity != nil{
            dictionary["quantity"] = quantity
        }
        if serviceTaxRate != nil{
            dictionary["service_tax_rate"] = serviceTaxRate
        }
        if vatRate != nil{
            dictionary["vat_rate"] = vatRate
        }
        if category != nil{
            dictionary["category"] = category.toDictionary()
        }
        if itemCategory != nil{
            dictionary["itemCategory"] = itemCategory.toDictionary()
        }
        if optionGroups != nil{
            var dictionaryElements = [[String:Any]]()
            for optionGroupsElement in optionGroups {
                dictionaryElements.append(optionGroupsElement.toDictionary())
            }
            dictionary["optionGroups"] = dictionaryElements
        }
        if preOrderStartTime != nil{
            dictionary["pre_order_start_time"] = preOrderStartTime
        }
        if preOrderEndTime != nil{
            dictionary["pre_order_end_time"] = preOrderEndTime
        }

        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        category = aDecoder.decodeObject(forKey: "category") as? ItemCategory
        currentStock = aDecoder.decodeObject(forKey: "current_stock") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
        imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
        itemCategory = aDecoder.decodeObject(forKey: "item_category") as? ItemCategory
        itemPrice = aDecoder.decodeObject(forKey: "item_price") as? Decimal
        itemTitle = aDecoder.decodeObject(forKey: "item_title") as? String
        optionGroups = aDecoder.decodeObject(forKey: "option_groups") as? [ItemOptionGroup]
        quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
        serviceTaxRate = aDecoder.decodeObject(forKey: "service_tax_rate") as? Int
        vatRate = aDecoder.decodeObject(forKey: "vat_rate") as? Int
        
        preOrderStartTime = aDecoder.decodeObject(forKey: "pre_order_start_time") as? Int
        preOrderEndTime = aDecoder.decodeObject(forKey: "pre_order_end_time") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if currentStock != nil{
            aCoder.encode(currentStock, forKey: "current_stock")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imageLandscapeUrl != nil{
            aCoder.encode(imageLandscapeUrl, forKey: "image_landscape_url")
        }
        if imageUrl != nil{
            aCoder.encode(imageUrl, forKey: "image_url")
        }
        if itemCategory != nil{
            aCoder.encode(itemCategory, forKey: "item_category")
        }
        if itemPrice != nil{
            aCoder.encode(itemPrice, forKey: "item_price")
        }
        if itemTitle != nil{
            aCoder.encode(itemTitle, forKey: "item_title")
        }
        if optionGroups != nil{
            aCoder.encode(optionGroups, forKey: "option_groups")
        }
        if quantity != nil{
            aCoder.encode(quantity, forKey: "quantity")
        }
        if serviceTaxRate != nil{
            aCoder.encode(serviceTaxRate, forKey: "service_tax_rate")
        }
        if vatRate != nil{
            aCoder.encode(vatRate, forKey: "vat_rate")
        }
        if preOrderStartTime != nil{
            aCoder.encode(preOrderStartTime, forKey: "pre_order_start_time")
        }
        if preOrderEndTime != nil{
            aCoder.encode(preOrderEndTime, forKey: "pre_order_end_time")
        }
    }
}
