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
        return minSelectable == SelectionQuantity.one || maxSelectable == SelectionQuantity.one
    }

    public var isMultipleSelectionGroup: Bool {
        return maxSelectable > 1 || maxSelectable == SelectionQuantity.unlimited
    }

    public var isValidCartOptionGroup: Bool {
        guard let groupOptions: [ItemOption] = options, groupOptions.count > 0 else { return false }

        var isValidItem: Bool = minSelectable == SelectionQuantity.one ? false : true

        for option in groupOptions {
            isValidItem = isValidItem || option.isValidCartItemOption
        }

        return isValidItem
    }
    
    internal var reorderOptionsToAdd: [ItemOption] {
        var reorderOptionsToAdd = [ItemOption]()

        for option in options {
            let options = option.reorderOptionsToAdd
            
            for optionItem in options {
                optionItem.price = Decimal.zero
                optionItem.quantity = isDefault ? 0 : 1
            }
            
            reorderOptionsToAdd.append(contentsOf: options)
        }
        
        return reorderOptionsToAdd
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
            guard (isDefault && itemOption.quantity == 0) || (!isDefault && itemOption.quantity > 0) else { return nil }
            return itemOption.descriptionText
        })

        guard let titleText: String = title, descriptionArray.count > 0 else { return nil }
        let text: String = descriptionArray.joined(separator: ", ")
        return "• \(titleText): \(text)"
    }
    
    convenience init(historicalOrderItemOptionGroup dictionary: [String: Any]) {
        self.init(fromDictionary: dictionary)
        
        options = [ItemOption]()
        if let optionsArray: [[String:Any]] = dictionary["options"] as? [[String:Any]]{
            for dic in optionsArray{
                let value = ItemOption.init(historicalOrderItemOptionGroupOption: dic)
                value.price = Decimal.zero
                value.quantity = isDefault ? 0 : 1
                options.append(value)
            }
        }
    }

}
