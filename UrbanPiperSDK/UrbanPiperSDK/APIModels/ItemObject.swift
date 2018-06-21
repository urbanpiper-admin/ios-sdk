//
//	ItemObject.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemObject : NSObject, NSCoding{

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
	public var itemTitle : String!
	public var likes : Int!
	public var optionGroups : [ItemOptionGroup]!
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

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	@objc public init(fromDictionary dictionary:  [String:Any]){
		if let categoryData = dictionary["category"] as? [String:Any]{
			category = ItemCategory(fromDictionary: categoryData)
        } else if let categoryData = dictionary["item_category"] as? [String:Any]{
            category = ItemCategory(fromDictionary: categoryData)
        }
		currentStock = dictionary["current_stock"] as? Int
		extras = dictionary["extras"] as? [AnyObject]
		foodType = dictionary["food_type"] as? String
		fulfillmentModes = dictionary["fulfillment_modes"] as? [String]
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
		likes = dictionary["likes"] as? Int ?? 0
		optionGroups = [ItemOptionGroup]()
		if let optionGroupsArray = dictionary["option_groups"] as? [[String:Any]]{
			for dic in optionGroupsArray{
				let value = ItemOptionGroup(fromDictionary: dic)
				optionGroups.append(value)
			}
            if optionGroups.count > 1 {
                optionGroups.sort { $0.sortOrder < $1.sortOrder }
            }
		}
        priceDescriptor = dictionary["price_descriptor"] as? String
		serviceTaxRate = dictionary["service_tax_rate"] as? Float
        preOrderStartTime = dictionary["pre_order_start_time"] as? Int
        preOrderEndTime = dictionary["pre_order_end_time"] as? Int
		slug = dictionary["slug"] as? String
		sortOrder = dictionary["sort_order"] as? Int ?? 0
        if let subCategoryData = dictionary["sub_category"] as? [String:Any]{
            subCategory = ItemCategory(fromDictionary: subCategoryData)
        }
        tags = [ItemTag]()
        if let tagsArray = dictionary["tags"] as? [[String:Any]]{
            for dic in tagsArray{
                let value = ItemTag(fromDictionary: dic)
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
		var dictionary = [String:Any]()
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
		if itemTitle != nil{
			dictionary["item_title"] = itemTitle
		}
		if likes != nil{
			dictionary["likes"] = likes
		}
		if optionGroups != nil{
            var dictionaryElements = [[String:Any]]()
			for optionGroupsElement in optionGroups {
				dictionaryElements.append(optionGroupsElement.toDictionary())
			}
			dictionary["option_groups"] = dictionaryElements
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
            var dictionaryElements = [[String:Any]]()
            for tagsElement in tags {
                dictionaryElements.append(tagsElement.toDictionary())
            }
            dictionary["tags"] = dictionaryElements
        }
		if vatRate != nil{
			dictionary["vat_rate"] = vatRate
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
         extras = aDecoder.decodeObject(forKey: "extras") as? [AnyObject]
         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
         fulfillmentModes = aDecoder.decodeObject(forKey: "fulfillment_modes") as? [String]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
         itemDesc = aDecoder.decodeObject(forKey: "item_desc") as? String
         itemPrice = aDecoder.decodeObject(forKey: "item_price") as? Decimal
         itemTitle = aDecoder.decodeObject(forKey: "item_title") as? String
         likes = aDecoder.decodeObject(forKey: "likes") as? Int
         optionGroups = aDecoder.decodeObject(forKey :"option_groups") as? [ItemOptionGroup]
         priceDescriptor = aDecoder.decodeObject(forKey: "price_descriptor") as? String
         serviceTaxRate = aDecoder.decodeObject(forKey: "service_tax_rate") as? Float
        preOrderStartTime = aDecoder.decodeObject(forKey: "pre_order_start_time") as? Int
        preOrderEndTime = aDecoder.decodeObject(forKey: "pre_order_end_time") as? Int
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
        subCategory = aDecoder.decodeObject(forKey: "sub_category") as? ItemCategory
        tags = aDecoder.decodeObject(forKey :"tags") as? [ItemTag]
         vatRate = aDecoder.decodeObject(forKey: "vat_rate") as? Float

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
		if extras != nil{
			aCoder.encode(extras, forKey: "extras")
		}
		if foodType != nil{
			aCoder.encode(foodType, forKey: "food_type")
		}
		if fulfillmentModes != nil{
			aCoder.encode(fulfillmentModes, forKey: "fulfillment_modes")
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
		if optionGroups != nil{
			aCoder.encode(optionGroups, forKey: "option_groups")
		}
		if priceDescriptor != nil{
			aCoder.encode(priceDescriptor, forKey: "price_descriptor")
		}
		if serviceTaxRate != nil{
			aCoder.encode(serviceTaxRate, forKey: "service_tax_rate")
		}
        if preOrderStartTime != nil{
            aCoder.encode(preOrderStartTime, forKey: "pre_order_start_time")
        }
        if preOrderEndTime != nil{
            aCoder.encode(preOrderEndTime, forKey: "pre_order_end_time")
        }
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if sortOrder != nil{
			aCoder.encode(sortOrder, forKey: "sort_order")
		}
        if subCategory != nil{
            aCoder.encode(subCategory, forKey: "sub_category")
        }
        if tags != nil{
            aCoder.encode(tags, forKey: "tags")
        }
		if vatRate != nil{
			aCoder.encode(vatRate, forKey: "vat_rate")
		}

	}

}
