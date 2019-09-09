//
//	OrderItem.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class OrderItem : NSObject, JSONDecodable{

	public var category : ItemCategory!
	public var charges : [AnyObject]!
	public var currentStock : Int!
//    public var extras : [AnyObject]!
    public var discount: Decimal?
	public var foodType : String!
	public var id : Int!
	public var imageLandscapeUrl : String!
	public var imageUrl : String!
	public var itemDesc : String!
	public var itemPrice : Decimal!
	public var itemTitle : String!
	public var likes : Int!
	public var options : [ItemOption]!
    public var optionsToRemove : [ItemOption]!
//    public var price : Decimal!
	public var quantity : Int!
//    public var slug : String!
	public var sortOrder : Int!
    public var subCategory : ItemCategory!
//    public var tags : [AnyObject]!
	public var taxPercentage : Float!
    public var toBeDiscounted: Bool = false
	public var taxes : [ItemTaxes]!
//    public var totalCharge : Float!
	public var totalTax : Float!
	public var weight : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		if let categoryData: [String : AnyObject] = dictionary["category"] as? [String : AnyObject]{
			category = ItemCategory(fromDictionary: categoryData)
		}
		charges = dictionary["charges"] as? [AnyObject]
		currentStock = dictionary["current_stock"] as? Int
//        extras = dictionary["extras"] as? [AnyObject]
        if let val: Decimal = dictionary["discount"] as? Decimal {
            discount = val
        } else if let val: Double = dictionary["discount"] as? Double {
            discount = Decimal(val).rounded
        } else if let val: Float = dictionary["discount"] as? Float {
            discount = Decimal(Double(val)).rounded
        } else {
            discount = Decimal.zero
        }
		foodType = dictionary["food_type"] as? String
		id = dictionary["id"] as? Int
		imageLandscapeUrl = dictionary["image_landscape_url"] as? String
		imageUrl = dictionary["image_url"] as? String
		itemDesc = dictionary["item_desc"] as? String
        
        if let val: Decimal = dictionary["item_price"] as? Decimal {
            itemPrice = val
        } else if let val: Double = dictionary["item_price"] as? Double {
            itemPrice = Decimal(val).rounded
        } else {
            itemPrice = Decimal.zero
        }

		itemTitle = dictionary["item_title"] as? String
		likes = dictionary["likes"] as? Int
		options = [ItemOption]()
		if let optionsArray: [[String : AnyObject]] = dictionary["options"] as? [[String : AnyObject]]{
			for dic in optionsArray{
				guard let value: ItemOption = ItemOption(fromDictionary: dic) else { continue }
				options.append(value)
			}
		}
        optionsToRemove = [ItemOption]()
        if let optionsToRemoveArray: [[String : AnyObject]] = dictionary["options_to_remove"] as? [[String : AnyObject]]{
            for dic in optionsToRemoveArray{
                guard let value: ItemOption = ItemOption(fromDictionary: dic) else { continue }
                optionsToRemove.append(value)
            }
        }
//        if let val: Decimal = dictionary["price"] as? Decimal {
//            //            price = val
//        } else if let val: Double = dictionary["price"] as? Double {
//            price = Decimal(val).rounded
//        } else {
//            price = Decimal.zero
//        }
        quantity = dictionary["quantity"] as? Int
//        slug = dictionary["slug"] as? String
		sortOrder = dictionary["sort_order"] as? Int ?? 0
        if let categoryData: [String : AnyObject] = dictionary["sub_category"] as? [String : AnyObject]{
            subCategory = ItemCategory(fromDictionary: categoryData)
        }
//        tags = dictionary["tags"] as? [AnyObject]
		taxPercentage = dictionary["tax_percentage"] as? Float
        toBeDiscounted = dictionary["to_be_discounted"] as? Bool ?? false
		taxes = [ItemTaxes]()
		if let taxesArray: [[String : AnyObject]] = dictionary["taxes"] as? [[String : AnyObject]]{
			for dic in taxesArray{
				guard let value: ItemTaxes = ItemTaxes(fromDictionary: dic) else { continue }
				taxes.append(value)
			}
		}
//        totalCharge = dictionary["total_charge"] as? Float
		totalTax = dictionary["total_tax"] as? Float
		weight = dictionary["weight"] as? Int
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
        if let charges = charges {
            dictionary["charges"] = charges as AnyObject
        }
        if let currentStock = currentStock {
            dictionary["current_stock"] = currentStock as AnyObject
        }
//        if let extras = extras {
//            dictionary["extras"] = extras as AnyObject
//        }
        if discount != nil {
            dictionary["discount"] = discount as AnyObject
        }
        if let foodType = foodType {
            dictionary["food_type"] = foodType as AnyObject
        }
        if let id = id {
            dictionary["id"] = id as AnyObject
        }
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
        if let itemTitle = itemTitle {
            dictionary["item_title"] = itemTitle as AnyObject
        }
        if let likes = likes {
            dictionary["likes"] = likes as AnyObject
        }
        if let options = options {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for optionsElement in options {
                dictionaryElements.append(optionsElement.toDictionary())
            }
            dictionary["options"] = dictionaryElements as AnyObject
        }
        if let optionsToRemove = optionsToRemove {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for optionsToRemoveElement in optionsToRemove {
                dictionaryElements.append(optionsToRemoveElement.toDictionary())
            }
            dictionary["options_to_remove"] = dictionaryElements as AnyObject
        }
//        if let price = price {
//            dictionary["price"] = price as AnyObject
//        }
        if let quantity = quantity {
            dictionary["quantity"] = quantity as AnyObject
        }
//        if let slug = slug {
//            dictionary["slug"] = slug as AnyObject
//        }
        if let sortOrder = sortOrder {
            dictionary["sort_order"] = sortOrder as AnyObject
        }
        if let subCategory = subCategory {
            dictionary["sub_category"] = subCategory.toDictionary() as AnyObject
        }
//        if let tags = tags {
//            dictionary["tags"] = tags as AnyObject
//        }
        if let taxPercentage = taxPercentage {
            dictionary["tax_percentage"] = taxPercentage as AnyObject
        }
        dictionary["to_be_discounted"] = toBeDiscounted as AnyObject
        if let taxes = taxes {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for taxesElement in taxes {
                dictionaryElements.append(taxesElement.toDictionary())
            }
            dictionary["taxes"] = dictionaryElements as AnyObject
        }
//        if let totalCharge = totalCharge {
//            dictionary["total_charge"] = totalCharge as AnyObject
//        }
        if let totalTax = totalTax {
            dictionary["total_tax"] = totalTax as AnyObject
        }
        if let weight = weight {
            dictionary["weight"] = weight as AnyObject
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
//         charges = aDecoder.decodeObject(forKey: "charges") as? [AnyObject]
//         currentStock = aDecoder.decodeInteger(forKey: "current_stock")
//         extras = aDecoder.decodeObject(forKey: "extras") as? [AnyObject]
//         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
//         id = aDecoder.decodeInteger(forKey: "id")
//         imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
//         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
//         itemDesc = aDecoder.decodeObject(forKey: "item_desc") as? String
//         itemPrice = aDecoder.decodeObject(forKey: "item_price") as? Decimal
//         itemTitle = aDecoder.decodeObject(forKey: "item_title") as? String
//         likes = aDecoder.decodeInteger(forKey: "likes")
//         options = aDecoder.decodeObject(forKey :"options") as? [ItemOption]
//         optionsToRemove = aDecoder.decodeObject(forKey :"options_to_remove") as? [ItemOption]
////         price = aDecoder.decodeObject(forKey: "price") as? Decimal
//         quantity = aDecoder.decodeInteger(forKey: "quantity")
//         slug = aDecoder.decodeObject(forKey: "slug") as? String
//         sortOrder = aDecoder.decodeInteger(forKey: "sort_order")
//         tags = aDecoder.decodeObject(forKey: "tags") as? [AnyObject]
//         taxPercentage = aDecoder.decodeObject(forKey: "tax_percentage") as? Float
//         taxes = aDecoder.decodeObject(forKey :"taxes") as? [ItemTaxes]
//         totalCharge = aDecoder.decodeObject(forKey: "total_charge") as? Float
//         totalTax = aDecoder.decodeObject(forKey: "total_tax") as? Float
//         weight = aDecoder.decodeInteger(forKey: "weight")
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
