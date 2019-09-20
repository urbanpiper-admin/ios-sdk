//
//	ItemOptionGroup.swift
//
//	Create by Vidhyadharan Mohanram on 11/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class ItemOptionGroup: NSObject, JSONDecodable {
    public var descriptionField: String!
    public var id: Int = 0
    public var isDefault: Bool
    public var maxSelectable: Int = 0
    public var minSelectable: Int = 0
    public var options: [ItemOption]!
    public var sortOrder: Int = 0
    public var title: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int ?? 0
        isDefault = dictionary["is_default"] as? Bool ?? false
        maxSelectable = dictionary["max_selectable"] as? Int ?? 0
        minSelectable = dictionary["min_selectable"] as? Int ?? 0
//        if maxSelectable < 0 {
//            maxSelectable = 1
//        }
//        if minSelectable < 0 {
//            minSelectable = 1
//        }
        options = [ItemOption]()
        if let optionsArray: [[String: AnyObject]] = dictionary["options"] as? [[String: AnyObject]] {
            for dic in optionsArray {
                guard let value: ItemOption = ItemOption(fromDictionary: dic) else { continue }
//                let defaultVal = isDefault ?? false
//                if (!defaultVal && value.quantity == 0) || (defaultVal && value.quantity > 0) {
//                    value.quantity = isDefault ? 1 : 0
//                }
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
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let descriptionField = descriptionField {
            dictionary["description"] = descriptionField as AnyObject
        }
        dictionary["id"] = id as AnyObject

        dictionary["is_default"] = isDefault as AnyObject

        dictionary["max_selectable"] = maxSelectable as AnyObject

        dictionary["min_selectable"] = minSelectable as AnyObject

        if let options = options {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for optionsElement in options {
                dictionaryElements.append(optionsElement.toDictionary())
            }
            dictionary["options"] = dictionaryElements as AnyObject
        }
        dictionary["sort_order"] = sortOrder as AnyObject
        if let title = title {
            dictionary["title"] = title as AnyObject
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
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
//         isDefault = aDecoder.decodeBool(forKey: "is_default")
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
//        if let descriptionField = descriptionField {
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let isDefault = isDefault {
//            aCoder.encode(isDefault, forKey: "is_default")
//        }
//        if let maxSelectable = maxSelectable {
//            aCoder.encode(maxSelectable, forKey: "max_selectable")
//        }
//        if let minSelectable = minSelectable {
//            aCoder.encode(minSelectable, forKey: "min_selectable")
//        }
//        if let options = options {
//            aCoder.encode(options, forKey: "options")
//        }
//        if let sortOrder = sortOrder {
//            aCoder.encode(sortOrder, forKey: "sort_order")
//        }
//        if let title = title {
//            aCoder.encode(title, forKey: "title")
//        }
//
//    }
}

extension ItemOptionGroup {
    internal func equitableCheckDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        //        if let isDefault = isDefault {
        //            dictionary["is_default"] = isDefault as AnyObject
        //        }
        if let options = options {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for optionsElement in options {
                guard optionsElement.quantity > 0 else { continue }
                dictionaryElements.append(optionsElement.equitableCheckDictionary())
            }
            dictionary["options"] = dictionaryElements as AnyObject
        }

        return dictionary
    }

    internal static func == (lhs: ItemOptionGroup, rhs: ItemOptionGroup) -> Bool {
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
