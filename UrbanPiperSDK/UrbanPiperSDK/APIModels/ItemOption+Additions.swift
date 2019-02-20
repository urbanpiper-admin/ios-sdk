//
//  ItemOption+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension ItemOption {

    public var totalAmount: Decimal {
        var totalAmount: Decimal = price
                
        if let nestedOptionGroups: [ItemOptionGroup] = nestedOptionGroups, nestedOptionGroups.count > 0 {
            for optionGroup: ItemOptionGroup in nestedOptionGroups {
                for item: ItemOption in optionGroup.options {
                    guard item.quantity > 0 else { continue }
                    totalAmount += item.totalAmount
                }
            }
        }

        return totalAmount
    }

    public func resetQuantity() {
        quantity = 0

        if let nestedOptionGroups = nestedOptionGroups, nestedOptionGroups.count > 0 {
            for optionGroup in nestedOptionGroups {
                for item in optionGroup.options {
                    if optionGroup.isDefault {
                        item.quantity = 1
                    } else {
                        item.quantity = 0
                    }
                }
            }
        }
    }

    public var isValidCartItemOption: Bool {
        guard quantity > 0 else { return false }
        if let groups = nestedOptionGroups, groups.count > 0 {

            var isValidItem : Bool = true

            for option in nestedOptionGroups {
                isValidItem = isValidItem && option.isValidCartOptionGroup
            }

            return isValidItem
        } else if quantity > 0 {
            return true
        }
        return false
    }

    public var optionsToAdd: [[String : Int]] {
        var options: [[String : Int]] = [[String : Int]]()

        if quantity > 0 {
            options.append(["id" : id])
        }
        
        if let optionGroups = nestedOptionGroups, optionGroups.count > 0 {
            for group in optionGroups {
                options.append(contentsOf: group.optionsToAdd)
            }
        }

        return options
    }

    public var optionsToRemove: [[String: Int]] {
        var options: [[String : Int]] = [[String : Int]]()

        if let optionGroups = nestedOptionGroups, optionGroups.count > 0 {
            for group in optionGroups {
                options.append(contentsOf: group.optionsToRemove)
            }
        } else if quantity == 0 {
            options.append(["id" : id])
        }

        return options
    }

    public var descriptionText: String? {
        if let groups = nestedOptionGroups, groups.count > 0 {
            let descriptionArray: [String] = groups.compactMap { $0.descriptionText }
            guard let titleText: String = title, descriptionArray.count > 0 else { return nil }
            let text: String = descriptionArray.joined(separator: "\n")
            return "\(titleText)\n\(text)"
        } else {
            return title
        }
    }
    
    convenience init(historicalOrderItemOptionGroupOption dictionary: [String: Any]) {
        self.init(fromDictionary: dictionary)
        
        nestedOptionGroups = [ItemOptionGroup]()
        if let nestedOptionGroupsArray: [[String:Any]] = dictionary["nested_option_groups"] as? [[String:Any]]{
            for dic in nestedOptionGroupsArray{
                let value = ItemOptionGroup.init(historicalOrderItemOptionGroup: dic)
                nestedOptionGroups.append(value)
            }
        }
    }

}

extension ItemOption {
    
    public func equitableCheckDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [String:Any]()
//        if currentStock != nil{
//            dictionary["current_stock"] = currentStock
//        }
        if id != nil{
            dictionary["id"] = id
        }
//        if price != nil{
//            dictionary["price"] = price
//        }
//        if title != nil{
//            dictionary["title"] = title
//        }
//        dictionary["quantity"] = quantity
        if nestedOptionGroups != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for nestedOptionGroupsElement in nestedOptionGroups {
                dictionaryElements.append(nestedOptionGroupsElement.equitableCheckDictionary())
            }
            dictionary["nested_option_groups"] = dictionaryElements
        }
        return dictionary
    }
    
    static public func == (lhs: ItemOption, rhs: ItemOption) -> Bool {
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
