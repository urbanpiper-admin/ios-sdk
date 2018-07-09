//
//  ItemObject+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension ItemObject: NSCopying {

    public var totalAmount: Decimal {
        var totalAmount: Decimal = itemPrice ?? Decimal.zero
        for group in optionGroups {
            for item in group.options {
                totalAmount += item.totalAmount
            }
        }
        return totalAmount
    }

    public var isComboItem: Bool {
        return optionGroups.count > 1
    }

    public var isOptionGroupItem: Bool {
        return !isNestedOptionItem && optionGroups != nil && optionGroups.count == 1 && optionGroups.last!.options.count > 0 
    }
    
    public var isNestedOptionItem: Bool {
        return optionGroups.filter ({ (optionGroup) -> Bool in
            guard let options = optionGroup.options else { return false }
            return options.filter ({ (option) -> Bool in
                guard let nestedOptionGroup = option.nestedOptionGroups, nestedOptionGroup.count > 0 else { return false }
                return true
            }).count > 0
        }).count > 0
//        return optionGroups.filter { $0.options != nil && $0.options.filter { $0.nestedOptionGroups != nil && $0.nestedOptionGroups.count > 0 }.count > 0 }.count > 0
    }

    public var isValidCartItemObject: Bool {
        var isValidItem : Bool = true

        for group in optionGroups {
            isValidItem = isValidItem && group.isValidCartOptionGroup
        }

        return isValidItem
    }

    public var descriptionText: String? {
        let descriptionArray: [String] = optionGroups.compactMap { $0.descriptionText }
        guard descriptionArray.count > 0 else { return nil }
        return descriptionArray.joined(separator: "\n")
    }

    public var optionsToAdd: [[String : Int]]? {
        var options: [[String : Int]] = [[String : Int]]()

        guard let optionGroups = optionGroups, optionGroups.count > 0 else { return  nil }

        for group in optionGroups {
            options.append(contentsOf: group.optionsToAdd)
        }

        return options.count > 0 ? options : nil
    }

    public var optionsToRemove: [[String: Int]]? {
        var options: [[String : Int]] = [[String : Int]]()

        guard let optionGroups = optionGroups, optionGroups.count > 0 else { return  nil }

        for group in optionGroups {
            options.append(contentsOf: group.optionsToRemove)
        }

        return options.count > 0 ? options : nil
    }

    @objc public var apiItemDictionary: [String: Any] {
        var itemDictionary: [String : Any] = discountCouponApiItemDictionary

        if let options: [[String: Int]] = optionsToRemove {
            itemDictionary["options_to_remove"] = options
        }

        return itemDictionary
    }

    @objc public var discountCouponApiItemDictionary: [String: Any] {
        var itemDictionary = toDictionary()
        itemDictionary.removeValue(forKey: "option_groups")

        if let options = optionsToAdd {
            itemDictionary["options"] = options
        }

        itemDictionary["quantity"] = quantity
        itemDictionary["item_price"] = totalAmount
        
        return itemDictionary
    }
    
    @objc public convenience init(historicalOrderItemDictionary dictionary: [String: Any]) {
        self.init(fromDictionary: dictionary)
        
        optionGroups = [ItemOptionGroup]()
        if let optionGroupsArray: [[String:Any]] = dictionary["option_groups"] as? [[String:Any]]{
            for dic in optionGroupsArray{
                let value = ItemOptionGroup.init(historicalOrderItemOptionGroup: dic)
                optionGroups.append(value)
            }
        }
        
        quantity = dictionary["quantity"] as? Int ?? 0
        
        guard isOptionGroupItem else { return }
        itemPrice = 0
    }

}

extension ItemObject {

    public func copy(with zone: NSZone? = nil) -> Any {
        return ItemObject(fromDictionary: toDictionary())
    }

    public func equitableCheckDictionary() -> [String: Any] {
        var dictionary: [String : Any] = [String:Any]()
        if category != nil{
            dictionary["category"] = category.toDictionary()
        }
        if currentStock != nil{
            dictionary["current_stock"] = currentStock
        }
        if id != nil{
            dictionary["id"] = id
        }
        if itemTitle != nil{
            dictionary["item_title"] = itemTitle
        }
        if optionGroups != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
            for optionGroupsElement in optionGroups {
                dictionaryElements.append(optionGroupsElement.equitableCheckDictionary())
            }
            dictionary["option_groups"] = dictionaryElements
        }
        return dictionary
    }
    
    static public func == (lhs: ItemObject, rhs: ItemObject) -> Bool {
        guard lhs.id == rhs.id, lhs.itemTitle == rhs.itemTitle else { return false }
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()

        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
    }
}
