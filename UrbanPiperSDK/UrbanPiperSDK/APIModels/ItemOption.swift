//
//	ItemOption.swift
//
//	Create by Vidhyadharan Mohanram on 19/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemOption : NSObject, NSCoding {

	public var currentStock : Int!
	public var descriptionField : String!
	public var foodType : String!
	public var id : Int!
	public var imageUrl : String!
	public var price : Decimal!
	public var sortOrder : Int!
	public var title : String!
	public var nestedOptionGroups : [ItemOptionGroup]!
    public var selectedQuantity: Int = 0


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		currentStock = dictionary["current_stock"] as? Int
		descriptionField = dictionary["description"] as? String
		foodType = dictionary["food_type"] as? String
		id = dictionary["id"] as? Int
		imageUrl = dictionary["image_url"] as? String

        if let val = dictionary["price"] as? Decimal {
            print("decimal amount value \(val)")
            price = val
        } else if let val = dictionary["price"] as? Double {
            print("double amount value \(val)")
            price = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: price).doubleValue))")
        } else if let val = dictionary["price"] as? Float {
            price = Decimal(Double(val)).rounded
            print("float amount value \(val)")
        } else if let val = dictionary["price"] as? Int {
            print("int amount value \(val)")
            price = Decimal(val).rounded
            print("Decimal Double \((NSDecimalNumber(decimal: price).doubleValue))")
        } else {
            price = Decimal(0).rounded
            print("amount value nil")
        }

		sortOrder = dictionary["sort_order"] as? Int ?? 0
		title = dictionary["title"] as? String
		nestedOptionGroups = [ItemOptionGroup]()
		if let nestedOptionGroupsArray = dictionary["nested_option_groups"] as? [[String:Any]]{
			for dic in nestedOptionGroupsArray{
				let value = ItemOptionGroup(fromDictionary: dic)
				nestedOptionGroups.append(value)
			}
		}

        selectedQuantity = dictionary["selected_quantity"] as? Int ?? 0
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if currentStock != nil{
			dictionary["current_stock"] = currentStock
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if foodType != nil{
			dictionary["food_type"] = foodType
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imageUrl != nil{
			dictionary["image_url"] = imageUrl
		}
		if price != nil{
			dictionary["price"] = price
		}
		if sortOrder != nil{
			dictionary["sort_order"] = sortOrder
		}
		if title != nil{
			dictionary["title"] = title
		}
		if nestedOptionGroups != nil{
			var dictionaryElements = [[String:Any]]()
			for nestedOptionGroupsElement in nestedOptionGroups {
				dictionaryElements.append(nestedOptionGroupsElement.toDictionary())
			}
			dictionary["nested_option_groups"] = dictionaryElements
		}
        dictionary["selected_quantity"] = selectedQuantity
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         currentStock = aDecoder.decodeObject(forKey: "current_stock") as? Int
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Decimal
         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         nestedOptionGroups = aDecoder.decodeObject(forKey :"nested_option_groups") as? [ItemOptionGroup]
        selectedQuantity = aDecoder.decodeObject(forKey: "selected_quantity") as? Int ?? 0
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if currentStock != nil{
			aCoder.encode(currentStock, forKey: "current_stock")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if foodType != nil{
			aCoder.encode(foodType, forKey: "food_type")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if imageUrl != nil{
			aCoder.encode(imageUrl, forKey: "image_url")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if sortOrder != nil{
			aCoder.encode(sortOrder, forKey: "sort_order")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if nestedOptionGroups != nil{
			aCoder.encode(nestedOptionGroups, forKey: "nested_option_groups")
		}
        aCoder.encode(selectedQuantity, forKey: "selected_quantity")
	}

}
