//
//  ItemOptionGroup+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 22/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension ItemOptionGroup {

    struct SelectionQuantity {
        static let unlimited = -1
        static let none = 0
        static let one = 1
    }

    public var isSingleSelectionGroup: Bool {
        return minSelectable == SelectionQuantity.one
    }

    public var isMultipleSelectionGroup: Bool {
        return maxSelectable > 1 || maxSelectable == SelectionQuantity.unlimited
    }

    public var isValidCartOptionGroup: Bool {
        guard let groupOptions = options, groupOptions.count > 0 else { return false }

        var isValidItem = minSelectable == SelectionQuantity.one ? false : true

        for option in groupOptions {
            isValidItem = isValidItem || option.isValidCartItemOption
        }

        return isValidItem
    }

    public var optionsToAdd: [[String : Int]] {
        var optionsToAdd = [[String : Int]]()

        for option in options {
            guard !isDefault || option.nestedOptionGroups.count > 0 else { continue }
            optionsToAdd.append(contentsOf: option.optionsToAdd)
        }

        return optionsToAdd
    }

    public var optionsToRemove: [[String: Int]] {
        var optionsToRemove = [[String : Int]]()

        for option in options {
            guard isDefault || option.nestedOptionGroups.count > 0 else { continue }
            optionsToRemove.append(contentsOf: option.optionsToRemove)
        }

        return optionsToRemove
    }

    public var descriptionText: String? {
        let descriptionArray = options.compactMap({ (itemOption) -> String? in
            guard (isDefault && itemOption.selectedQuantity == 0) || (!isDefault && itemOption.selectedQuantity > 0) else { return nil }
            return itemOption.descriptionText
        })

        guard let titleText = title, descriptionArray.count > 0 else { return nil }
        let text = descriptionArray.joined(separator: ", ")
        return "• \(titleText): \(text)"
    }
    
    convenience init(historicalOrderItemOptionGroup dictionary: [String: Any]) {
        self.init(fromDictionary: dictionary)
        
        options = [ItemOption]()
        if let optionsArray = dictionary["options"] as? [[String:Any]]{
            for dic in optionsArray{
                let value = ItemOption.init(historicalOrderItemOptionGroupOption: dic)
                value.selectedQuantity = isDefault ? 0 : 1
                options.append(value)
            }
        }
    }

}

extension ItemOptionGroup {
    
    public func equitableCheckDictionary() -> [String: Any] {
        var dictionary = [String:Any]()
        if isDefault != nil{
            dictionary["is_default"] = isDefault
        }
        if options != nil{
            var dictionaryElements = [[String:Any]]()
            for optionsElement in options {
                guard optionsElement.selectedQuantity > 0 else { continue }
                dictionaryElements.append(optionsElement.equitableCheckDictionary())
            }
            dictionary["options"] = dictionaryElements
        }
        
        return dictionary
    }
    
    static public func == (lhs: ItemOptionGroup, rhs: ItemOptionGroup) -> Bool {
        return lhs.descriptionField  == rhs.descriptionField  &&
            lhs.id  == rhs.id  &&
            lhs.isDefault  == rhs.isDefault  &&
            lhs.maxSelectable  == rhs.maxSelectable  &&
            lhs.minSelectable  == rhs.minSelectable  &&
            lhs.options  == rhs.options  &&
            lhs.sortOrder  == rhs.sortOrder  &&
            lhs.title  == rhs.title
    }
}
