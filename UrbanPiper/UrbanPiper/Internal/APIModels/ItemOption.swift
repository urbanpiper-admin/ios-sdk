//
//	ItemOption.swift
//
//	Create by Vidhyadharan Mohanram on 19/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class ItemOption : NSObject, JSONDecodable {

	public var currentStock : Int?
	public var descriptionField : String!
	public var foodType : String!
	public var id : Int = 0
	public var imageUrl : String!
	public var price : Decimal!
    public var recommended : Bool = false
	public var sortOrder : Int = 0
	@objc public var title : String!
	public var nestedOptionGroups : [ItemOptionGroup]!
    internal var quantity: Int = 0


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		currentStock = dictionary["current_stock"] as? Int
		descriptionField = dictionary["description"] as? String
		foodType = dictionary["food_type"] as? String
		id = dictionary["id"] as? Int ?? 0
		imageUrl = dictionary["image_url"] as? String

        if let val: Decimal = dictionary["price"] as? Decimal {
            price = val
        } else if let val: Double = dictionary["price"] as? Double {
            price = Decimal(val).rounded
        } else {
            price = Decimal.zero
        }

        recommended = dictionary["recommended"] as? Bool ?? false
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		title = dictionary["title"] as? String
		nestedOptionGroups = [ItemOptionGroup]()
		if let nestedOptionGroupsArray: [[String : AnyObject]] = dictionary["nested_option_groups"] as? [[String : AnyObject]]{
			for dic in nestedOptionGroupsArray{
				guard let value: ItemOptionGroup = ItemOptionGroup(fromDictionary: dic) else { continue }
				nestedOptionGroups.append(value)
			}
		}

        quantity = dictionary["quantity"] as? Int ?? 0
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let currentStock = currentStock {
            dictionary["current_stock"] = currentStock as AnyObject
        }
        if let descriptionField = descriptionField {
            dictionary["description"] = descriptionField as AnyObject
        }
        if let foodType = foodType {
            dictionary["food_type"] = foodType as AnyObject
        }
        dictionary["id"] = id as AnyObject
        if let imageUrl = imageUrl {
            dictionary["image_url"] = imageUrl as AnyObject
        }
        if let price = price {
            dictionary["price"] = price as AnyObject
        }
        dictionary["recommended"] = recommended as AnyObject
        dictionary["sort_order"] = sortOrder as AnyObject
        if let title = title {
            dictionary["title"] = title as AnyObject
        }
//        if let nestedOptionGroups = nestedOptionGroups {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for nestedOptionGroupsElement in nestedOptionGroups {
//                dictionaryElements.append(nestedOptionGroupsElement.toDictionary())
//            }
//            dictionary["nested_option_groups"] = dictionaryElements as AnyObject
//        }
        dictionary["quantity"] = quantity as AnyObject
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         currentStock = aDecoder.decodeObject(forKey: "current_stock") as? Int
//         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
//         foodType = aDecoder.decodeObject(forKey: "food_type") as? String
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
//         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
//         recommended = aDecoder.decodeBool(forKey: "recommended") ?? false
//         price = aDecoder.decodeObject(forKey: "price") as? Decimal
//         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
//         title = aDecoder.decodeObject(forKey: "title") as? String
//         nestedOptionGroups = aDecoder.decodeObject(forKey :"nested_option_groups") as? [ItemOptionGroup]
//        if let val = aDecoder.decodeObject(forKey: "quantity") as? Int {
//            quantity = val
//        } else {
//            quantity = aDecoder.decodeInteger(forKey: "quantity")
//        }
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let currentStock = currentStock {
//            aCoder.encode(currentStock, forKey: "current_stock")
//        }
//        if let descriptionField = descriptionField {
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if let foodType = foodType {
//            aCoder.encode(foodType, forKey: "food_type")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let imageUrl = imageUrl {
//            aCoder.encode(imageUrl, forKey: "image_url")
//        }
//        if let price = price {
//            aCoder.encode(price, forKey: "price")
//        }
//        aCoder.encode(recommended, forKey: "recommended")
//        if let sortOrder = sortOrder {
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if let title = title {
//            aCoder.encode(title, forKey: "title")
//        }
//        if let nestedOptionGroups = nestedOptionGroups {
//            aCoder.encode(nestedOptionGroups, forKey: "nested_option_groups")
//        }
//        aCoder.encode(quantity, forKey: "quantity")
//    }

}

extension ItemOption {
    
    internal func equitableCheckDictionary() -> [String : AnyObject] {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        //        if let currentStock = currentStock {
        //            dictionary["current_stock"] = currentStock as AnyObject
        //        }
        dictionary["id"] = id as AnyObject
        //        if let price = price {
        //            dictionary["price"] = price as AnyObject
        //        }
        //        if let title = title {
        //            dictionary["title"] = title as AnyObject
        //        }
        //        dictionary["quantity"] = quantity as AnyObject
        if let nestedOptionGroups = nestedOptionGroups {
            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
            for nestedOptionGroupsElement in nestedOptionGroups {
                dictionaryElements.append(nestedOptionGroupsElement.equitableCheckDictionary())
            }
            dictionary["nested_option_groups"] = dictionaryElements as AnyObject
        }
        return dictionary
    }
    
    static internal func == (lhs: ItemOption, rhs: ItemOption) -> Bool {
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()
        
        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
        
        //        return lhs.currentStock == rhs.currentStock  &&
        //            lhs.descriptionField == rhs.descriptionField  &&
        //            lhs.foodType == rhs.foodType  &&
        //            lhs.id == rhs.id  &&
        //            lhs.imageUrl == rhs.imageUrl  &&
        //            lhs.price == rhs.price  &&
        //            lhs.sortOrder == rhs.sortOrder  &&
        //            lhs.title  == rhs.title  &&
        //            lhs.nestedOptionGroups == rhs.nestedOptionGroups &&
        //            lhs.quantity  == rhs.quantity
    }
}


