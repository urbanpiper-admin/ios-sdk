//
//	ItemOptionGroup.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class ItemOptionGroup : NSObject, NSCoding {

	public var descriptionField : String!
	public var id : Int!
	public var isDefault : Bool!
	public var maxSelectable : Int!
	public var minSelectable : Int!
	public var options : [ItemOption]!
	public var sortOrder : Int!
	public var title : String!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		descriptionField = dictionary["description"] as? String
		id = dictionary["id"] as? Int
		isDefault = dictionary["is_default"] as? Bool
		maxSelectable = dictionary["max_selectable"] as? Int
		minSelectable = dictionary["min_selectable"] as? Int
		options = [ItemOption]()
		if let optionsArray = dictionary["options"] as? [[String:Any]]{
			for dic in optionsArray{
				let value = ItemOption(fromDictionary: dic)
                let defaultVal = isDefault ?? false
                if (!defaultVal && value.selectedQuantity == 0) || (defaultVal && value.selectedQuantity > 0) {
                    value.selectedQuantity = isDefault ? 1 : 0
                }
				options.append(value)
			}
            if options.count > 1 {
                options.sort { $0.sortOrder < $1.sortOrder }
            }
		}
		sortOrder = dictionary["sort_order"] as? Int ?? 0
		title = dictionary["title"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isDefault != nil{
			dictionary["is_default"] = isDefault
		}
		if maxSelectable != nil{
			dictionary["max_selectable"] = maxSelectable
		}
		if minSelectable != nil{
			dictionary["min_selectable"] = minSelectable
		}
		if options != nil{
			var dictionaryElements = [[String:Any]]()
			for optionsElement in options {
				dictionaryElements.append(optionsElement.toDictionary())
			}
			dictionary["options"] = dictionaryElements
		}
		if sortOrder != nil{
			dictionary["sort_order"] = sortOrder
		}
		if title != nil{
			dictionary["title"] = title
		}

		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDefault = aDecoder.decodeObject(forKey: "is_default") as? Bool
         maxSelectable = aDecoder.decodeObject(forKey: "max_selectable") as? Int
         minSelectable = aDecoder.decodeObject(forKey: "min_selectable") as? Int
         options = aDecoder.decodeObject(forKey :"options") as? [ItemOption]
         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isDefault != nil{
			aCoder.encode(isDefault, forKey: "is_default")
		}
		if maxSelectable != nil{
			aCoder.encode(maxSelectable, forKey: "max_selectable")
		}
		if minSelectable != nil{
			aCoder.encode(minSelectable, forKey: "min_selectable")
		}
		if options != nil{
			aCoder.encode(options, forKey: "options")
		}
		if sortOrder != nil{
			aCoder.encode(sortOrder, forKey: "sort_order")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
        
	}

}


