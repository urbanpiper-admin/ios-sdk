//
//  ItemOption+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension ItemOption {

//    public var totalAmount: Decimal {
//        var totalAmount: Decimal = price
//                
//        if let nestedOptionGroups: [ItemOptionGroup] = nestedOptionGroups, nestedOptionGroups.count > 0 {
//            for optionGroup: ItemOptionGroup in nestedOptionGroups {
//                for item: ItemOption in optionGroup.options {
//                    guard item.quantity > 0 else { continue }
//                    totalAmount += item.totalAmount
//                }
//            }
//        }
//
//        return totalAmount
//    }

//    public func resetQuantity() {
//        quantity = 0
//
//        if let nestedOptionGroups = nestedOptionGroups, nestedOptionGroups.count > 0 {
//            for optionGroup in nestedOptionGroups {
//                for item in optionGroup.options {
//                    if optionGroup.isDefault {
//                        item.quantity = 1
//                    } else {
//                        item.quantity = 0
//                    }
//                }
//            }
//        }
//    }

//    public var isValidCartItemOption: Bool {
//        guard quantity > 0 else { return false }
//        if let groups = nestedOptionGroups, groups.count > 0 {
//
//            var isValidItem : Bool = true
//
//            for option in nestedOptionGroups {
//                isValidItem = isValidItem && option.isValidCartOptionGroup
//            }
//
//            return isValidItem
//        } else if quantity > 0 {
//            return true
//        }
//        return false
//    }

    internal var reorderOptionsToAdd: [ItemOption] {
        var reorderOptionsToAdd = [ItemOption]()
        
        if let optionGroups = nestedOptionGroups, optionGroups.count > 0 {
            for optionGroup in nestedOptionGroups {
                reorderOptionsToAdd.append(contentsOf: optionGroup.reorderOptionsToAdd)
            }
        } else {
            reorderOptionsToAdd.append(self)
        }
        
        return reorderOptionsToAdd
    }
    
//    public var optionsToAdd: [[String : Int]] {
//        var options: [[String : Int]] = [[String : Int]]()
//
//        if quantity > 0 {
//            options.append(["id" : id])
//        }
//
//        if let optionGroups = nestedOptionGroups, optionGroups.count > 0 {
//            for group in optionGroups {
//                options.append(contentsOf: group.optionsToAdd)
//            }
//        }
//
//        return options
//    }
//
//    public var optionsToRemove: [[String: Int]] {
//        var options: [[String : Int]] = [[String : Int]]()
//
//        if let optionGroups = nestedOptionGroups, optionGroups.count > 0 {
//            for group in optionGroups {
//                options.append(contentsOf: group.optionsToRemove)
//            }
//        } else if quantity == 0 {
//            options.append(["id" : id])
//        }
//
//        return options
//    }
//
//    public var descriptionText: String? {
//        if let groups = nestedOptionGroups, groups.count > 0 {
//            let descriptionArray: [String] = groups.compactMap { $0.descriptionText }
//            guard let titleText: String = title, descriptionArray.count > 0 else { return nil }
//            let text: String = descriptionArray.joined(separator: "\n")
//            return "\(titleText)\n\(text)"
//        } else {
//            return title
//        }
//    }
//
//    convenience init(historicalOrderItemOptionGroupOption dictionary: [String: Any]) {
//        self.init(fromDictionary: dictionary)
//
//        nestedOptionGroups = [ItemOptionGroup]()
//        if let nestedOptionGroupsArray: [[String:Any]] = dictionary["nested_option_groups"] as? [[String:Any]]{
//            for dic in nestedOptionGroupsArray{
//                let value = ItemOptionGroup.init(historicalOrderItemOptionGroup: dic)
//                nestedOptionGroups.append(value)
//            }
//        }
//    }

}
