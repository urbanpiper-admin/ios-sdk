//
//	Item.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class Item : NSObject, JSONDecodable{

	public var category : ItemCategory!
	public var currentStock : Int = 0
	public var extras : [ItemExtra]!
	public var foodType : String!
//    public var fulfillmentModes : [String]!
	public var id : Int = 0
	public var imageLandscapeUrl : String!
	public var imageUrl : String!
	public var itemDesc : String!
	public var itemPrice : Decimal!
	public var itemTitle : String!
	public var likes : Int?
	public var optionGroups : [ItemOptionGroup]!
    public var orderOptionsToAdd : [ItemOption]!
    public var orderOptionsToRemove : [ItemOption]!
	public var priceDescriptor : String!
//    public var serviceTaxRate : Float!
    public var preOrderStartTime : Int?
    public var preOrderEndTime : Int?
	public var slug : String!
	public var sortOrder : Int = 0
    public var subCategory : ItemCategory?
//    public var tags : [ItemTag]!
//    public var vatRate : Float!
    
//    public var total : Decimal!

//    @objc public var quantity: Int = 0
    internal var isRecommendedItem: Bool = false
    internal var isUpsoldItem: Bool = false
    internal var isSearchItem: Bool = false
    
    internal var isItemDetailsItem: Bool = false

    public var notes: String?
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    @objc required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        
        super.init()
        if let categoryData: [String : AnyObject] = dictionary["category"] as? [String : AnyObject]{
			category = ItemCategory(fromDictionary: categoryData)
        } else if let categoryData: [String : AnyObject] = dictionary["item_category"] as? [String : AnyObject]{
            category = ItemCategory(fromDictionary: categoryData)
        }
		currentStock = dictionary["current_stock"] as? Int ?? 0
        extras = [ItemExtra]()
        if let extrasArray: [[String : AnyObject]] = dictionary["extras"] as? [[String : AnyObject]]{
            for dic in extrasArray{
                guard let value: ItemExtra = ItemExtra(fromDictionary: dic) else { continue }
                extras.append(value)
            }
        }
		foodType = dictionary["food_type"] as? String
//        fulfillmentModes = dictionary["fulfillment_modes"] as? [String]
		id = dictionary["id"] as? Int ?? 0
		imageLandscapeUrl = dictionary["image_landscape_url"] as? String
		imageUrl = dictionary["image_url"] as? String
		itemDesc = dictionary["item_desc"] as? String

        let priceVal: Any = dictionary["item_price"] ?? dictionary["price"] as Any
        if let val: Decimal = priceVal as? Decimal {
            itemPrice = val
        } else if let val: Double = priceVal as? Double {
            itemPrice = Decimal(val).rounded
        } else {
            itemPrice = Decimal.zero
        }
        
//        priceVal = dictionary["total"] as Any
//        if let val: Decimal = priceVal as? Decimal {
//            total = val
//        } else if let val: Double = priceVal as? Double {
//            total = Decimal(val).rounded
//        } else {
//            total = Decimal.zero
//        }

		itemTitle = dictionary["item_title"] as? String ?? dictionary["title"] as? String
		likes = dictionary["likes"] as? Int ?? 0
		optionGroups = [ItemOptionGroup]()
		if let optionGroupsArray: [[String : AnyObject]] = dictionary["option_groups"] as? [[String : AnyObject]]{
			for dic in optionGroupsArray{
				guard let value: ItemOptionGroup = ItemOptionGroup(fromDictionary: dic) else { continue }
				optionGroups.append(value)
			}
            if optionGroups.count > 1 {
                optionGroups.sort { $0.sortOrder < $1.sortOrder }
            }
		}
        orderOptionsToAdd = [ItemOption]()
        if let orderOptionsToAddArray: [[String : AnyObject]] = dictionary["options_to_add"] as? [[String : AnyObject]]{
            for dic in orderOptionsToAddArray{
                guard let value: ItemOption = ItemOption(fromDictionary: dic) else { continue }
                orderOptionsToAdd.append(value)
            }
        }
        orderOptionsToRemove = [ItemOption]()
        if let orderOptionsToRemoveArray: [[String : AnyObject]] = dictionary["options_to_remove"] as? [[String : AnyObject]]{
            for dic in orderOptionsToRemoveArray{
                guard let value: ItemOption = ItemOption(fromDictionary: dic) else { continue }
                orderOptionsToRemove.append(value)
            }
        }

        priceDescriptor = dictionary["price_descriptor"] as? String
//        serviceTaxRate = dictionary["service_tax_rate"] as? Float
        preOrderStartTime = dictionary["pre_order_start_time"] as? Int
        preOrderEndTime = dictionary["pre_order_end_time"] as? Int
		slug = dictionary["slug"] as? String
		sortOrder = dictionary["sort_order"] as? Int ?? 0
        if let subCategoryData: [String : AnyObject] = dictionary["sub_category"] as? [String : AnyObject]{
            subCategory = ItemCategory(fromDictionary: subCategoryData)
        }
//        tags = [ItemTag]()
//        if let tagsArray: [[String : AnyObject]] = dictionary["tags"] as? [[String : AnyObject]]{
//            for dic in tagsArray{
//                guard let value: ItemTag = ItemTag(fromDictionary: dic) else { continue }
//                tags.append(value)
//            }
//        }
//        vatRate = dictionary["vat_rate"] as? Float
//        quantity = dictionary["quantity"] as? Int ?? 0
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let category = category {
            dictionary["category"] = category.toDictionary() as AnyObject
        }
        dictionary["current_stock"] = currentStock as AnyObject
        if let extras = extras {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for itemExtraElement in extras {
                dictionaryElements.append(itemExtraElement.toDictionary())
            }
            dictionary["extras"] = dictionaryElements as AnyObject
        }
        if let foodType = foodType {
            dictionary["food_type"] = foodType as AnyObject
        }
//        if let fulfillmentModes = fulfillmentModes {
//            dictionary["fulfillment_modes"] = fulfillmentModes as AnyObject
//        }
        dictionary["id"] = id as AnyObject
        
        if let imageLandscapeUrl = imageLandscapeUrl {
            dictionary["image_landscape_url"] = imageLandscapeUrl as AnyObject
        }
        if let imageUrl = imageUrl {
            dictionary["image_url"] = imageUrl as AnyObject
        }
        if let itemDesc = itemDesc {
            dictionary["item_desc"] = itemDesc as AnyObject
        }
        if let itemPrice = itemPrice {
            dictionary["item_price"] = itemPrice as AnyObject
        }
//        if let total = total {
//            dictionary["total"] = total as AnyObject
//        }
        if let itemTitle = itemTitle {
            dictionary["item_title"] = itemTitle as AnyObject
        }
        if let likes = likes {
            dictionary["likes"] = likes as AnyObject
        }
        if let optionGroups = optionGroups {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for optionGroupsElement in optionGroups {
                dictionaryElements.append(optionGroupsElement.toDictionary())
            }
            dictionary["option_groups"] = dictionaryElements as AnyObject
        }
        if let orderOptionsToAdd = orderOptionsToAdd {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for orderOptionsToAddElement in orderOptionsToAdd {
                dictionaryElements.append(orderOptionsToAddElement.toDictionary())
            }
            dictionary["options_to_add"] = dictionaryElements as AnyObject
        }
        if let orderOptionsToRemove = orderOptionsToRemove {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for orderOptionsToRemoveElement in orderOptionsToRemove {
                dictionaryElements.append(orderOptionsToRemoveElement.toDictionary())
            }
            dictionary["options_to_remove"] = dictionaryElements as AnyObject
        }
        if let priceDescriptor = priceDescriptor {
            dictionary["price_descriptor"] = priceDescriptor as AnyObject
        }
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
        
        if let subCategory = subCategory {
            dictionary["sub_category"] = subCategory.toDictionary() as AnyObject
        }
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
//        dictionary["quantity"] = quantity as AnyObject

        if let notes = notes {
            dictionary["notes"] = notes as AnyObject
        }

        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         category = aDecoder.decodeObject(forKey: "category") as? ItemCategory
//         currentStock = aDecoder.decodeObject(forKey: "current_stock") as? Int
//         extras = aDecoder.decodeObject(forKey: "extras") as? [AnyObject]
//         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
//         fulfillmentModes = aDecoder.decodeObject(forKey: "fulfillment_modes") as? [String]
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
//         imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
//         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
//         itemDesc = aDecoder.decodeObject(forKey: "item_desc") as? String
//         itemPrice = aDecoder.decodeObject(forKey: "item_price") as? Decimal
//         total = aDecoder.decodeObject(forKey: "total") as? Decimal
//         itemTitle = aDecoder.decodeObject(forKey: "item_title") as? String
//         likes = aDecoder.decodeObject(forKey: "likes") as? Int
//         optionGroups = aDecoder.decodeObject(forKey :"option_groups") as? [ItemOptionGroup]
//         optionsToAdd = aDecoder.decodeObject(forKey :"options_to_add") as? [ItemOption]
//         optionsToRemove = aDecoder.decodeObject(forKey :"options_to_remove") as? [ItemOption]
//         priceDescriptor = aDecoder.decodeObject(forKey: "price_descriptor") as? String
//         serviceTaxRate = aDecoder.decodeObject(forKey: "service_tax_rate") as? Float
//        preOrderStartTime = aDecoder.decodeObject(forKey: "pre_order_start_time") as? Int
//        preOrderEndTime = aDecoder.decodeObject(forKey: "pre_order_end_time") as? Int
//         slug = aDecoder.decodeObject(forKey: "slug") as? String
//         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
//        subCategory = aDecoder.decodeObject(forKey: "sub_category") as? ItemCategory
//        tags = aDecoder.decodeObject(forKey :"tags") as? [ItemTag]
//         vatRate = aDecoder.decodeObject(forKey: "vat_rate") as? Float
//         notes = aDecoder.decodeObject(forKey: "notes") as? String
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
//        if let currentStock = currentStock {
//            aCoder.encode(currentStock, forKey: "current_stock")
//        }
//        if let extras = extras {
//            aCoder.encode(extras, forKey: "extras")
//        }
//        if let foodType = foodType {
//            aCoder.encode(foodType, forKey: "food_type")
//        }
//        if let fulfillmentModes = fulfillmentModes {
//            aCoder.encode(fulfillmentModes, forKey: "fulfillment_modes")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let imageLandscapeUrl = imageLandscapeUrl {
//            aCoder.encode(imageLandscapeUrl, forKey: "image_landscape_url")
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
//        if let total = total {
//            aCoder.encode(total, forKey: "total")
//        }
//        if let itemTitle = itemTitle {
//            aCoder.encode(itemTitle, forKey: "item_title")
//        }
//        if let likes = likes {
//            aCoder.encode(likes, forKey: "likes")
//        }
//        if let optionGroups = optionGroups {
//            aCoder.encode(optionGroups, forKey: "option_groups")
//        }
//        if let optionsToAdd = optionsToAdd {
//            aCoder.encode(optionsToAdd, forKey: "options_to_add")
//        }
//        if let optionsToRemove = optionsToRemove {
//            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
//        }
//        if let priceDescriptor = priceDescriptor {
//            aCoder.encode(priceDescriptor, forKey: "price_descriptor")
//        }
//        if let serviceTaxRate = serviceTaxRate {
//            aCoder.encode(serviceTaxRate, forKey: "service_tax_rate")
//        }
//        if let preOrderStartTime = preOrderStartTime {
//            aCoder.encode(preOrderStartTime, forKey: "pre_order_start_time")
//        }
//        if let preOrderEndTime = preOrderEndTime {
//            aCoder.encode(preOrderEndTime, forKey: "pre_order_end_time")
//        }
//        if let slug = slug {
//            aCoder.encode(slug, forKey: "slug")
//        }
//        if let sortOrder = sortOrder {
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if let subCategory = subCategory {
//            aCoder.encode(subCategory, forKey: "sub_category")
//        }
//        if let tags = tags {
//            aCoder.encode(tags, forKey: "tags")
//        }
//        if let vatRate = vatRate {
//            aCoder.encode(vatRate, forKey: "vat_rate")
//        }
//        if let notes = notes {
//            aCoder.encode(notes, forKey: "notes")
//        }
//
//    }

}
