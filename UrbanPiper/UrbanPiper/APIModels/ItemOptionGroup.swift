//
//	ItemOptionGroup.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class ItemOptionGroup : NSObject {

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
	internal init(fromDictionary dictionary:  [String:Any]){
		descriptionField = dictionary["description"] as? String
		id = dictionary["id"] as? Int
		isDefault = dictionary["is_default"] as? Bool
		maxSelectable = dictionary["max_selectable"] as? Int
		minSelectable = dictionary["min_selectable"] as? Int
//        if maxSelectable < 0 {
//            maxSelectable = 1
//        }
//        if minSelectable < 0 {
//            minSelectable = 1
//        }
		options = [ItemOption]()
		if let optionsArray: [[String:Any]] = dictionary["options"] as? [[String:Any]]{
			for dic in optionsArray{
				let value: ItemOption = ItemOption(fromDictionary: dic)
                let defaultVal = isDefault ?? false
                if (!defaultVal && value.quantity == 0) || (defaultVal && value.quantity > 0) {
                    value.quantity = isDefault ? 1 : 0
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
        var dictionary: [String: Any] = [String:Any]()
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
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
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

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         isDefault = aDecoder.decodeObject(forKey: "is_default") as? Bool
//         maxSelectable = aDecoder.decodeObject(forKey: "max_selectable") as? Int
//         minSelectable = aDecoder.decodeObject(forKey: "min_selectable") as? Int
//         options = aDecoder.decodeObject(forKey :"options") as? [ItemOption]
//         sortOrder = aDecoder.decodeObject(forKey: "sort_order") as? Int
//         title = aDecoder.decodeObject(forKey: "title") as? String
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if descriptionField != nil{
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if isDefault != nil{
//            aCoder.encode(isDefault, forKey: "is_default")
//        }
//        if maxSelectable != nil{
//            aCoder.encode(maxSelectable, forKey: "max_selectable")
//        }
//        if minSelectable != nil{
//            aCoder.encode(minSelectable, forKey: "min_selectable")
//        }
//        if options != nil{
//            aCoder.encode(options, forKey: "options")
//        }
//        if sortOrder != nil{
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
//        
//    }

}


extension ItemOptionGroup {
    
    internal func equitableCheckDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [String:Any]()
        //        if isDefault != nil{
        //            dictionary["is_default"] = isDefault
        //        }
        if options != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for optionsElement in options {
                guard optionsElement.quantity > 0 else { continue }
                dictionaryElements.append(optionsElement.equitableCheckDictionary())
            }
            dictionary["options"] = dictionaryElements
        }
        
        return dictionary
    }
    
    static internal func == (lhs: ItemOptionGroup, rhs: ItemOptionGroup) -> Bool {
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()
        
        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
        
        //        return lhs.descriptionField == rhs.descriptionField &&
        //            lhs.id == rhs.id &&
        //            lhs.isDefault == rhs.isDefault &&
        //            lhs.maxSelectable == rhs.maxSelectable &&
        //            lhs.minSelectable == rhs.minSelectable &&
        //            lhs.options == rhs.options &&
        //            lhs.sortOrder == rhs.sortOrder &&
        //            lhs.title == rhs.title
    }
}
