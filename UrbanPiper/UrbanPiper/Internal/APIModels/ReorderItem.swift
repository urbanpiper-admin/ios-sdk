//
//  ReorderItem.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 21, 2019

import Foundation


@objc public class ReorderItem : NSObject, JSONDecodable, NSCoding{

    public var category : ItemCategory!
    public var currentStock : Int = 0
    public var id : Int = 0
    public var imageLandscapeUrl : String!
    public var imageUrl : String!
    public var itemCategory : ItemCategory!
    public var itemPrice : Decimal!
    @objc public var itemTitle : String!
    public var optionGroups : [ItemOptionGroup]!
    public var preOrderStartTime : Int?
    public var preOrderEndTime : Int?
    @objc public var quantity : Int = 0
    public var serviceTaxRate : Int?
    public var vatRate : Int?


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        currentStock = dictionary["current_stock"] as? Int ?? 0
        id = dictionary["id"] as? Int ?? 0
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
        quantity = dictionary["quantity"] as? Int ?? 0
        serviceTaxRate = dictionary["service_tax_rate"] as? Int
        vatRate = dictionary["vat_rate"] as? Int
        if let categoryData = dictionary["category"] as? [String : AnyObject]{
            category = ItemCategory(fromDictionary: categoryData)
        }
        if let itemCategoryData = dictionary["item_category"] as? [String : AnyObject]{
            itemCategory = ItemCategory(fromDictionary: itemCategoryData)
        }
        optionGroups = [ItemOptionGroup]()
        if let optionGroupsArray = dictionary["option_groups"] as? [[String : AnyObject]]{
            for dic in optionGroupsArray{
                guard let value = ItemOptionGroup(fromDictionary: dic) else { continue }
                optionGroups.append(value)
            }
        }
        preOrderStartTime = dictionary["pre_order_start_time"] as? Int
        preOrderEndTime = dictionary["pre_order_end_time"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String : AnyObject]
    {
        var dictionary = [String : AnyObject]()
        dictionary["current_stock"] = currentStock as AnyObject
        dictionary["id"] = id as AnyObject
        if let imageLandscapeUrl = imageLandscapeUrl {
            dictionary["image_landscape_url"] = imageLandscapeUrl as AnyObject
        }
        if let imageUrl = imageUrl {
            dictionary["image_url"] = imageUrl as AnyObject
        }
        if let itemPrice = itemPrice {
            dictionary["item_price"] = itemPrice as AnyObject
        }
        if let itemTitle = itemTitle {
            dictionary["item_title"] = itemTitle as AnyObject
        }

        dictionary["quantity"] = quantity as AnyObject
        
        if let serviceTaxRate = serviceTaxRate {
            dictionary["service_tax_rate"] = serviceTaxRate as AnyObject
        }
        if let vatRate = vatRate {
            dictionary["vat_rate"] = vatRate as AnyObject
        }
        if let category = category {
            dictionary["category"] = category.toDictionary() as AnyObject
        }
        if let itemCategory = itemCategory {
            dictionary["itemCategory"] = itemCategory.toDictionary() as AnyObject
        }
        if let optionGroups = optionGroups {
            var dictionaryElements = [[String : AnyObject]]()
            for optionGroupsElement in optionGroups {
                dictionaryElements.append(optionGroupsElement.toDictionary())
            }
            dictionary["optionGroups"] = dictionaryElements as AnyObject
        }
        if let preOrderStartTime = preOrderStartTime {
            dictionary["pre_order_start_time"] = preOrderStartTime as AnyObject
        }
        if let preOrderEndTime = preOrderEndTime {
            dictionary["pre_order_end_time"] = preOrderEndTime as AnyObject
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
        if let val = aDecoder.decodeObject(forKey: "current_stock") as? Int {
            currentStock = val
        } else {
            currentStock = aDecoder.decodeInteger(forKey: "current_stock")
        }
        if let val = aDecoder.decodeObject(forKey: "id") as? Int {
            id = val
        } else {
            id = aDecoder.decodeInteger(forKey: "id")
        }
        imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
        imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
        itemCategory = aDecoder.decodeObject(forKey: "item_category") as? ItemCategory
        itemPrice = aDecoder.decodeObject(forKey: "item_price") as? Decimal
        itemTitle = aDecoder.decodeObject(forKey: "item_title") as? String
        optionGroups = aDecoder.decodeObject(forKey: "option_groups") as? [ItemOptionGroup]
        if let val = aDecoder.decodeObject(forKey: "quantity") as? Int {
            quantity = val
        } else {
            quantity = aDecoder.decodeInteger(forKey: "quantity")
        }
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
        if let category = category {
            aCoder.encode(category, forKey: "category")
        }
        aCoder.encode(currentStock, forKey: "current_stock")
        aCoder.encode(id, forKey: "id")
        if let imageLandscapeUrl = imageLandscapeUrl {
            aCoder.encode(imageLandscapeUrl, forKey: "image_landscape_url")
        }
        if let imageUrl = imageUrl {
            aCoder.encode(imageUrl, forKey: "image_url")
        }
        if let itemCategory = itemCategory {
            aCoder.encode(itemCategory, forKey: "item_category")
        }
        if let itemPrice = itemPrice {
            aCoder.encode(itemPrice, forKey: "item_price")
        }
        if let itemTitle = itemTitle {
            aCoder.encode(itemTitle, forKey: "item_title")
        }
        if let optionGroups = optionGroups {
            aCoder.encode(optionGroups, forKey: "option_groups")
        }
        
        aCoder.encode(quantity, forKey: "quantity")

        if let serviceTaxRate = serviceTaxRate {
            aCoder.encode(serviceTaxRate, forKey: "service_tax_rate")
        }
        if let vatRate = vatRate {
            aCoder.encode(vatRate, forKey: "vat_rate")
        }
        if let preOrderStartTime = preOrderStartTime {
            aCoder.encode(preOrderStartTime, forKey: "pre_order_start_time")
        }
        if let preOrderEndTime = preOrderEndTime {
            aCoder.encode(preOrderEndTime, forKey: "pre_order_end_time")
        }
    }
}
