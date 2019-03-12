//
//	OrderItem.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class OrderItem : NSObject{

	public private(set) var category : ItemCategory!
	public private(set) var charges : [AnyObject]!
	public private(set) var currentStock : Int!
//    public private(set) var extras : [AnyObject]!
    public private(set) var discount: Decimal?
	public private(set) var foodType : String!
	public private(set) var id : Int!
	public private(set) var imageLandscapeUrl : String!
	public private(set) var imageUrl : String!
	public private(set) var itemDesc : String!
	public private(set) var itemPrice : Decimal!
	public private(set) var itemTitle : String!
	public private(set) var likes : Int!
	public private(set) var options : [ItemOption]!
    public private(set) var optionsToRemove : [ItemOption]!
//    public private(set) var price : Decimal!
	public private(set) var quantity : Int!
//    public private(set) var slug : String!
	public private(set) var sortOrder : Int!
    public private(set) var subCategory : ItemCategory!
//    public private(set) var tags : [AnyObject]!
	public private(set) var taxPercentage : Float!
    public private(set) var toBeDiscounted: Bool = false
	public private(set) var taxes : [ItemTaxes]!
//    public private(set) var totalCharge : Float!
	public private(set) var totalTax : Float!
	public private(set) var weight : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		if let categoryData: [String:Any] = dictionary["category"] as? [String:Any]{
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
		if let optionsArray: [[String:Any]] = dictionary["options"] as? [[String:Any]]{
			for dic in optionsArray{
				let value: ItemOption = ItemOption(fromDictionary: dic)
				options.append(value)
			}
		}
        optionsToRemove = [ItemOption]()
        if let optionsToRemoveArray: [[String:Any]] = dictionary["options_to_remove"] as? [[String:Any]]{
            for dic in optionsToRemoveArray{
                let value: ItemOption = ItemOption(fromDictionary: dic)
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
        if let categoryData: [String:Any] = dictionary["sub_category"] as? [String:Any]{
            subCategory = ItemCategory(fromDictionary: categoryData)
        }
//        tags = dictionary["tags"] as? [AnyObject]
		taxPercentage = dictionary["tax_percentage"] as? Float
        toBeDiscounted = dictionary["to_be_discounted"] as? Bool ?? false
		taxes = [ItemTaxes]()
		if let taxesArray: [[String:Any]] = dictionary["taxes"] as? [[String:Any]]{
			for dic in taxesArray{
				let value: ItemTaxes = ItemTaxes(fromDictionary: dic)
				taxes.append(value)
			}
		}
//        totalCharge = dictionary["total_charge"] as? Float
		totalTax = dictionary["total_tax"] as? Float
		weight = dictionary["weight"] as? Int
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
        if charges != nil{
            dictionary["charges"] = charges
        }
        if currentStock != nil{
            dictionary["current_stock"] = currentStock
        }
//        if extras != nil{
//            dictionary["extras"] = extras
//        }
        if discount != nil {
            dictionary["discount"] = discount!
        }
        if foodType != nil{
            dictionary["food_type"] = foodType
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
        if itemTitle != nil{
            dictionary["item_title"] = itemTitle
        }
        if likes != nil{
            dictionary["likes"] = likes
        }
        if options != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for optionsElement in options {
                dictionaryElements.append(optionsElement.toDictionary())
            }
            dictionary["options"] = dictionaryElements
        }
        if optionsToRemove != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for optionsToRemoveElement in optionsToRemove {
                dictionaryElements.append(optionsToRemoveElement.toDictionary())
            }
            dictionary["options_to_remove"] = dictionaryElements
        }
//        if price != nil{
//            dictionary["price"] = price
//        }
        if quantity != nil{
            dictionary["quantity"] = quantity
        }
//        if slug != nil{
//            dictionary["slug"] = slug
//        }
        if sortOrder != nil{
            dictionary["sort_order"] = sortOrder
        }
        if subCategory != nil{
            dictionary["sub_category"] = subCategory.toDictionary()
        }
//        if tags != nil{
//            dictionary["tags"] = tags
//        }
        if taxPercentage != nil{
            dictionary["tax_percentage"] = taxPercentage
        }
        dictionary["to_be_discounted"] = toBeDiscounted
        if taxes != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for taxesElement in taxes {
                dictionaryElements.append(taxesElement.toDictionary())
            }
            dictionary["taxes"] = dictionaryElements
        }
//        if totalCharge != nil{
//            dictionary["total_charge"] = totalCharge
//        }
        if totalTax != nil{
            dictionary["total_tax"] = totalTax
        }
        if weight != nil{
            dictionary["weight"] = weight
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
//         currentStock = aDecoder.decodeObject(forKey: "current_stock") as? Int
//         extras = aDecoder.decodeObject(forKey: "extras") as? [AnyObject]
//         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
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
//        if category != nil{
//            aCoder.encode(category, forKey: "category")
//        }
//        if charges != nil{
//            aCoder.encode(charges, forKey: "charges")
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
//        if itemTitle != nil{
//            aCoder.encode(itemTitle, forKey: "item_title")
//        }
//        if likes != nil{
//            aCoder.encode(likes, forKey: "likes")
//        }
//        if options != nil{
//            aCoder.encode(options, forKey: "options")
//        }
//        if optionsToRemove != nil{
//            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
//        }
////        if price != nil{
////            aCoder.encode(price, forKey: "price")
////        }
//        if quantity != nil{
//            aCoder.encode(quantity, forKey: "quantity")
//        }
//        if slug != nil{
//            aCoder.encode(slug, forKey: "slug")
//        }
//        if sortOrder != nil{
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if tags != nil{
//            aCoder.encode(tags, forKey: "tags")
//        }
//        if taxPercentage != nil{
//            aCoder.encode(taxPercentage, forKey: "tax_percentage")
//        }
//        if taxes != nil{
//            aCoder.encode(taxes, forKey: "taxes")
//        }
//        if totalCharge != nil{
//            aCoder.encode(totalCharge, forKey: "total_charge")
//        }
//        if totalTax != nil{
//            aCoder.encode(totalTax, forKey: "total_tax")
//        }
//        if weight != nil{
//            aCoder.encode(weight, forKey: "weight")
//        }
//
//    }

}
