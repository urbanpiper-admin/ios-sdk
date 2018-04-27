//
//	OrderItem.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class OrderItem : NSObject, NSCoding{

	public var category : ItemCategory!
	public var charges : [AnyObject]!
	public var currentStock : Int!
	public var extras : [AnyObject]!
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
	public var slug : String!
	public var sortOrder : Int!
	public var tags : [AnyObject]!
	public var taxPercentage : Float!
	public var taxes : [ItemTaxes]!
	public var totalCharge : Float!
	public var totalTax : Float!
	public var weight : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		if let categoryData = dictionary["category"] as? [String:Any]{
			category = ItemCategory(fromDictionary: categoryData)
		}
		charges = dictionary["charges"] as? [AnyObject]
		currentStock = dictionary["current_stock"] as? Int
		extras = dictionary["extras"] as? [AnyObject]
		foodType = dictionary["food_type"] as? String
		id = dictionary["id"] as? Int
		imageLandscapeUrl = dictionary["image_landscape_url"] as? String
		imageUrl = dictionary["image_url"] as? String
		itemDesc = dictionary["item_desc"] as? String
        
        if let val = dictionary["item_price"] as? Decimal {
            print("decimal amount value \(val)")
            itemPrice = val
        } else if let val = dictionary["item_price"] as? Double {
            print("double amount value \(val)")
            itemPrice = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: itemPrice).doubleValue))")
        } else if let val = dictionary["item_price"] as? Float {
            itemPrice = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = dictionary["item_price"] as? Int {
            print("int amount value \(val)")
            itemPrice = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: itemPrice).doubleValue))")
        } else {
            itemPrice = Decimal(0).rounded
            print("amount value nil")
        }

		itemTitle = dictionary["item_title"] as? String
		likes = dictionary["likes"] as? Int
		options = [ItemOption]()
		if let optionsArray = dictionary["options"] as? [[String:Any]]{
			for dic in optionsArray{
				let value = ItemOption(fromDictionary: dic)
				options.append(value)
			}
		}
        optionsToRemove = [ItemOption]()
        if let optionsToRemoveArray = dictionary["options_to_remove"] as? [[String:Any]]{
            for dic in optionsToRemoveArray{
                let value = ItemOption(fromDictionary: dic)
                optionsToRemove.append(value)
            }
        }
//        if let val = dictionary["price"] as? Decimal {
//            print("decimal amount value \(val)")
//            price = val
//        } else if let val = dictionary["price"] as? Double {
//            price = Decimal(val).rounded
//            print("Decimal Double \((NSDecimalNumber(decimal: price).doubleValue))")
//        } else if let val = dictionary["price"] as? Float {
//            price = Decimal(Double(val)).rounded
//            print("float amount value \(val)")
//        } else if let val = dictionary["price"] as? Int {
//            price = Decimal(val).rounded
//            print("Decimal Double \((NSDecimalNumber(decimal: price).doubleValue))")
//        } else {
//            price = Decimal(0).rounded
//            print("amount value nil")
//        }
        quantity = dictionary["quantity"] as? Int
		slug = dictionary["slug"] as? String
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		tags = dictionary["tags"] as? [AnyObject]
		taxPercentage = dictionary["tax_percentage"] as? Float
		taxes = [ItemTaxes]()
		if let taxesArray = dictionary["taxes"] as? [[String:Any]]{
			for dic in taxesArray{
				let value = ItemTaxes(fromDictionary: dic)
				taxes.append(value)
			}
		}
		totalCharge = dictionary["total_charge"] as? Float
		totalTax = dictionary["total_tax"] as? Float
		weight = dictionary["weight"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if category != nil{
			dictionary["category"] = category.toDictionary()
		}
		if charges != nil{
			dictionary["charges"] = charges
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
			var dictionaryElements = [[String:Any]]()
			for optionsElement in options {
				dictionaryElements.append(optionsElement.toDictionary())
			}
			dictionary["options"] = dictionaryElements
		}
        if optionsToRemove != nil{
            var dictionaryElements = [[String:Any]]()
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
		if slug != nil{
			dictionary["slug"] = slug
		}
		if sortOrder != nil{
			dictionary["sort_order"] = sortOrder
		}
		if tags != nil{
			dictionary["tags"] = tags
		}
		if taxPercentage != nil{
			dictionary["tax_percentage"] = taxPercentage
		}
		if taxes != nil{
            var dictionaryElements = [[String:Any]]()
			for taxesElement in taxes {
				dictionaryElements.append(taxesElement.toDictionary())
			}
			dictionary["taxes"] = dictionaryElements
		}
		if totalCharge != nil{
			dictionary["total_charge"] = totalCharge
		}
		if totalTax != nil{
			dictionary["total_tax"] = totalTax
		}
		if weight != nil{
			dictionary["weight"] = weight
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
         charges = aDecoder.decodeObject(forKey: "charges") as? [AnyObject]
         currentStock = aDecoder.decodeObject(forKey: "current_stock") as? Int
         extras = aDecoder.decodeObject(forKey: "extras") as? [AnyObject]
         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
         itemDesc = aDecoder.decodeObject(forKey: "item_desc") as? String
         itemPrice = aDecoder.decodeObject(forKey: "item_price") as? Decimal
         itemTitle = aDecoder.decodeObject(forKey: "item_title") as? String
         likes = aDecoder.decodeObject(forKey: "likes") as? Int
         options = aDecoder.decodeObject(forKey :"options") as? [ItemOption]
         optionsToRemove = aDecoder.decodeObject(forKey :"options_to_remove") as? [ItemOption]
//         price = aDecoder.decodeObject(forKey: "price") as? Decimal
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
         tags = aDecoder.decodeObject(forKey: "tags") as? [AnyObject]
         taxPercentage = aDecoder.decodeObject(forKey: "tax_percentage") as? Float
         taxes = aDecoder.decodeObject(forKey :"taxes") as? [ItemTaxes]
         totalCharge = aDecoder.decodeObject(forKey: "total_charge") as? Float
         totalTax = aDecoder.decodeObject(forKey: "total_tax") as? Float
         weight = aDecoder.decodeObject(forKey: "weight") as? Int

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
		if charges != nil{
			aCoder.encode(charges, forKey: "charges")
		}
		if currentStock != nil{
			aCoder.encode(currentStock, forKey: "current_stock")
		}
		if extras != nil{
			aCoder.encode(extras, forKey: "extras")
		}
		if foodType != nil{
			aCoder.encode(foodType, forKey: "food_type")
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
		if itemDesc != nil{
			aCoder.encode(itemDesc, forKey: "item_desc")
		}
		if itemPrice != nil{
			aCoder.encode(itemPrice, forKey: "item_price")
		}
		if itemTitle != nil{
			aCoder.encode(itemTitle, forKey: "item_title")
		}
		if likes != nil{
			aCoder.encode(likes, forKey: "likes")
		}
		if options != nil{
			aCoder.encode(options, forKey: "options")
		}
        if optionsToRemove != nil{
            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
        }
//        if price != nil{
//            aCoder.encode(price, forKey: "price")
//        }
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if sortOrder != nil{
			aCoder.encode(sortOrder, forKey: "sort_order")
		}
		if tags != nil{
			aCoder.encode(tags, forKey: "tags")
		}
		if taxPercentage != nil{
			aCoder.encode(taxPercentage, forKey: "tax_percentage")
		}
		if taxes != nil{
			aCoder.encode(taxes, forKey: "taxes")
		}
		if totalCharge != nil{
			aCoder.encode(totalCharge, forKey: "total_charge")
		}
		if totalTax != nil{
			aCoder.encode(totalTax, forKey: "total_tax")
		}
		if weight != nil{
			aCoder.encode(weight, forKey: "weight")
		}

	}

}
