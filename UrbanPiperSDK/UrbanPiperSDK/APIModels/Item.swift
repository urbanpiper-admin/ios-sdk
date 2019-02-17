//
//	Item.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class Item : NSObject{

	public var category : ItemCategory!
	public var currentStock : Int!
	public var extras : [AnyObject]!
	public var foodType : String!
	public var fulfillmentModes : [String]!
	public var id : Int!
	public var imageLandscapeUrl : String!
	public var imageUrl : String!
	public var itemDesc : String!
	public var itemPrice : Decimal!
    public var total : Decimal!
	public var itemTitle : String!
	public var likes : Int!
	public var optionGroups : [ItemOptionGroup]!
    public var orderOptionsToAdd : [ItemOption]!
    public var orderOptionsToRemove : [ItemOption]!
	public var priceDescriptor : String!
	public var serviceTaxRate : Float!
    public var preOrderStartTime : Int?
    public var preOrderEndTime : Int?
	public var slug : String!
	public var sortOrder : Int!
    public var subCategory : ItemCategory!
	public var tags : [ItemTag]!
	public var vatRate : Float!
    @objc public var quantity: Int = 0
    public var isRecommendedItem: Bool = false
    public var isUpsoldItem: Bool = false
    public var isSearchItem: Bool = false
    public var notes: String?
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    @objc init(fromDictionary dictionary: [String:Any]){
        
        super.init()
        update(fromDictionary: dictionary)
    }

    func update(fromDictionary dictionary: [String:Any]){
    if let categoryData: [String:Any] = dictionary["category"] as? [String:Any]{
			category = ItemCategory(fromDictionary: categoryData)
        } else if let categoryData: [String:Any] = dictionary["item_category"] as? [String:Any]{
            category = ItemCategory(fromDictionary: categoryData)
        }
		currentStock = dictionary["current_stock"] as? Int ?? 0
		extras = dictionary["extras"] as? [AnyObject]
		foodType = dictionary["food_type"] as? String
		fulfillmentModes = dictionary["fulfillment_modes"] as? [String]
		id = dictionary["id"] as? Int
		imageLandscapeUrl = dictionary["image_landscape_url"] as? String
		imageUrl = dictionary["image_url"] as? String
		itemDesc = dictionary["item_desc"] as? String

        var priceVal: Any = dictionary["item_price"] ?? dictionary["price"] as Any
        if let val: Decimal = priceVal as? Decimal {
            itemPrice = val
        } else if let val: Double = priceVal as? Double {
            itemPrice = Decimal(val).rounded
        } else {
            itemPrice = Decimal.zero
        }
        
        priceVal = dictionary["total"] as Any
        if let val: Decimal = priceVal as? Decimal {
            total = val
        } else if let val: Double = priceVal as? Double {
            total = Decimal(val).rounded
        } else {
            total = Decimal.zero
        }

		itemTitle = dictionary["item_title"] as? String ?? dictionary["title"] as? String
		likes = dictionary["likes"] as? Int ?? 0
		optionGroups = [ItemOptionGroup]()
		if let optionGroupsArray: [[String:Any]] = dictionary["option_groups"] as? [[String:Any]]{
			for dic in optionGroupsArray{
				let value: ItemOptionGroup = ItemOptionGroup(fromDictionary: dic)
				optionGroups.append(value)
			}
            if optionGroups.count > 1 {
                optionGroups.sort { $0.sortOrder < $1.sortOrder }
            }
		}
        orderOptionsToAdd = [ItemOption]()
        if let orderOptionsToAddArray: [[String:Any]] = dictionary["options_to_add"] as? [[String:Any]]{
            for dic in orderOptionsToAddArray{
                let value: ItemOption = ItemOption(fromDictionary: dic)
                orderOptionsToAdd.append(value)
            }
        }
        orderOptionsToRemove = [ItemOption]()
        if let orderOptionsToRemoveArray: [[String:Any]] = dictionary["options_to_remove"] as? [[String:Any]]{
            for dic in orderOptionsToRemoveArray{
                let value: ItemOption = ItemOption(fromDictionary: dic)
                orderOptionsToRemove.append(value)
            }
        }

        priceDescriptor = dictionary["price_descriptor"] as? String
		serviceTaxRate = dictionary["service_tax_rate"] as? Float
        preOrderStartTime = dictionary["pre_order_start_time"] as? Int
        preOrderEndTime = dictionary["pre_order_end_time"] as? Int
		slug = dictionary["slug"] as? String
		sortOrder = dictionary["sort_order"] as? Int ?? 0
        if let subCategoryData: [String:Any] = dictionary["sub_category"] as? [String:Any]{
            subCategory = ItemCategory(fromDictionary: subCategoryData)
        }
        tags = [ItemTag]()
        if let tagsArray: [[String:Any]] = dictionary["tags"] as? [[String:Any]]{
            for dic in tagsArray{
                let value: ItemTag = ItemTag(fromDictionary: dic)
                tags.append(value)
            }
        }
		vatRate = dictionary["vat_rate"] as? Float
        quantity = dictionary["quantity"] as? Int ?? 0
	}

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if category != nil{
            dictionary["category"] = category.toDictionary()
        }
        if currentStock != nil{
            dictionary["current_stock"] = currentStock
        }
        if extras != nil{
            dictionary["extras"] = extras
        }
        if foodType != nil{
            dictionary["food_type"] = foodType
        }
        if fulfillmentModes != nil{
            dictionary["fulfillment_modes"] = fulfillmentModes
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
        if itemDesc != nil{
            dictionary["item_desc"] = itemDesc
        }
        if itemPrice != nil{
            dictionary["item_price"] = itemPrice
        }
        if total != nil{
            dictionary["total"] = total
        }
        if itemTitle != nil{
            dictionary["item_title"] = itemTitle
        }
        if likes != nil{
            dictionary["likes"] = likes
        }
        if optionGroups != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for optionGroupsElement in optionGroups {
                dictionaryElements.append(optionGroupsElement.toDictionary())
            }
            dictionary["option_groups"] = dictionaryElements
        }
        if orderOptionsToAdd != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for orderOptionsToAddElement in orderOptionsToAdd {
                dictionaryElements.append(orderOptionsToAddElement.toDictionary())
            }
            dictionary["options_to_add"] = dictionaryElements
        }
        if orderOptionsToRemove != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for orderOptionsToRemoveElement in orderOptionsToRemove {
                dictionaryElements.append(orderOptionsToRemoveElement.toDictionary())
            }
            dictionary["options_to_remove"] = dictionaryElements
        }
        if priceDescriptor != nil{
            dictionary["price_descriptor"] = priceDescriptor
        }
        if serviceTaxRate != nil{
            dictionary["service_tax_rate"] = serviceTaxRate
        }
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
        if subCategory != nil{
            dictionary["sub_category"] = subCategory.toDictionary()
        }
        if tags != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for tagsElement in tags {
                dictionaryElements.append(tagsElement.toDictionary())
            }
            dictionary["tags"] = dictionaryElements
        }
        if vatRate != nil{
            dictionary["vat_rate"] = vatRate
        }
        dictionary["quantity"] = quantity

        if notes != nil{
            dictionary["notes"] = notes
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
//         id = aDecoder.decodeObject(forKey: "id") as? Int
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
//        if category != nil{
//            aCoder.encode(category, forKey: "category")
//        }
//        if currentStock != nil{
//            aCoder.encode(currentStock, forKey: "current_stock")
//        }
//        if extras != nil{
//            aCoder.encode(extras, forKey: "extras")
//        }
//        if foodType != nil{
//            aCoder.encode(foodType, forKey: "food_type")
//        }
//        if fulfillmentModes != nil{
//            aCoder.encode(fulfillmentModes, forKey: "fulfillment_modes")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if imageLandscapeUrl != nil{
//            aCoder.encode(imageLandscapeUrl, forKey: "image_landscape_url")
//        }
//        if imageUrl != nil{
//            aCoder.encode(imageUrl, forKey: "image_url")
//        }
//        if itemDesc != nil{
//            aCoder.encode(itemDesc, forKey: "item_desc")
//        }
//        if itemPrice != nil{
//            aCoder.encode(itemPrice, forKey: "item_price")
//        }
//        if total != nil{
//            aCoder.encode(total, forKey: "total")
//        }
//        if itemTitle != nil{
//            aCoder.encode(itemTitle, forKey: "item_title")
//        }
//        if likes != nil{
//            aCoder.encode(likes, forKey: "likes")
//        }
//        if optionGroups != nil{
//            aCoder.encode(optionGroups, forKey: "option_groups")
//        }
//        if optionsToAdd != nil{
//            aCoder.encode(optionsToAdd, forKey: "options_to_add")
//        }
//        if optionsToRemove != nil{
//            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
//        }
//        if priceDescriptor != nil{
//            aCoder.encode(priceDescriptor, forKey: "price_descriptor")
//        }
//        if serviceTaxRate != nil{
//            aCoder.encode(serviceTaxRate, forKey: "service_tax_rate")
//        }
//        if preOrderStartTime != nil{
//            aCoder.encode(preOrderStartTime, forKey: "pre_order_start_time")
//        }
//        if preOrderEndTime != nil{
//            aCoder.encode(preOrderEndTime, forKey: "pre_order_end_time")
//        }
//        if slug != nil{
//            aCoder.encode(slug, forKey: "slug")
//        }
//        if sortOrder != nil{
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if subCategory != nil{
//            aCoder.encode(subCategory, forKey: "sub_category")
//        }
//        if tags != nil{
//            aCoder.encode(tags, forKey: "tags")
//        }
//        if vatRate != nil{
//            aCoder.encode(vatRate, forKey: "vat_rate")
//        }
//        if notes != nil{
//            aCoder.encode(notes, forKey: "notes")
//        }
//
//    }

}
