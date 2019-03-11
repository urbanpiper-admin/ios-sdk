//
//  ItemBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 11/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

/// ItemOptionBuilder is a helper class to build a cartItem with item options.
public class ItemOptionBuilder: NSObject {
    
    fileprivate var selectedNestedOptions: [Int : ItemOptionBuilder] = [:]
    
    fileprivate var itemsToAdd: [Int: [ItemOption]] = [:]

    fileprivate let itemOption: ItemOption?
    
    fileprivate let optionGroups: [ItemOptionGroup]

    internal var isValidOptionGroup: (Bool, ItemOptionGroup?) {
        var isValidItem : Bool = true
        
        for group in optionGroups {
            let result = isOptionGroupValid(group: group)
            isValidItem = isValidItem && result.0
            guard isValidItem else {
                return (isValidItem, result.1 ?? group)
            }
        }

        return (isValidItem, nil)
    }
    
    internal func isOptionGroupValid(group : ItemOptionGroup) -> (Bool, ItemOptionGroup?) {
        var isValidItem : Bool = group.minSelectable == 0
        
        if let groupOptionBuilder = selectedNestedOptions[group.id], groupOptionBuilder.optionsToAdd.count > 0 {
            return groupOptionBuilder.isValidOptionGroup
        } else {
            let itemOptionsCount = itemsToAdd[group.id]?.count ?? 0
            
            if group.isMultipleSelectionGroup {
                isValidItem = (itemOptionsCount >= group.minSelectable && itemOptionsCount <= group.maxSelectable)
            } else if group.isSingleSelectionGroup {
                isValidItem = itemOptionsCount == 1
            }
            return (isValidItem, isValidItem ? group : nil)
        }
    }
    
    internal var optionsToAdd: [ItemOption] {
        var options: [ItemOption] = []
        
        for (_, itemOptionBuilder) in selectedNestedOptions {
            guard itemOptionBuilder.itemOption != nil else { continue }

            let selectedSubOptions = itemOptionBuilder.optionsToAdd
            guard selectedSubOptions.count > 0 else { continue }
            options.append(contentsOf: selectedSubOptions)
        }
        
        for (_, itemOptions) in itemsToAdd {
            options.append(contentsOf: itemOptions)
        }
        
        if let primaryOption = itemOption, options.count > 0 {
            options.insert(primaryOption, at: 0)
        }
        
        return options
    }
    
    internal var optionsToRemove: [ItemOption] {
        var options: [ItemOption] = []
        
        let selectedOptions: [ItemOption] = optionsToAdd
        
        guard selectedOptions.count > 0 else { return options }
        
        for (_, itemOptionBuilder) in selectedNestedOptions {
            guard itemOptionBuilder.itemOption != nil else { continue }
            options.append(contentsOf: itemOptionBuilder.optionsToRemove)
        }
        
        for optionGroup in optionGroups {
            guard optionGroup.isDefault else { continue }
            for option in optionGroup.options {
                guard !selectedOptions.contains(option) else { continue }
                options.append(option)
            }
        }
        
        return options
    }
    
    internal var descriptionText: String? {
        var descriptionArray: [String] = []
        
        for (_, itemOptionBuilder) in selectedNestedOptions {
            guard itemOptionBuilder.itemOption != nil else { continue }
            guard let text = itemOptionBuilder.descriptionText else { continue }
            descriptionArray.append(text)
        }
        
        var itemOptionGroupDict: [ItemOptionGroup : [ItemOption]] = [:]
        
        for (groupId, itemOptions) in itemsToAdd {
            let group = optionGroups.filter ({ $0.id == groupId }).last!
            let sortedItemOptions = itemOptions.sorted { $0.sortOrder < $1.sortOrder }
            
            itemOptionGroupDict[group] = sortedItemOptions
        }
        
        let sortedDictionary = itemOptionGroupDict.sorted { $0.key.sortOrder < $1.key.sortOrder }
        
        for (group, itemOptions) in sortedDictionary {
            descriptionArray.append("• \(group.title!): \(itemOptions.map {$0.title}.joined(separator: ", "))")
        }
        
        return descriptionArray.joined(separator: "\n")
    }
    
    internal let item: Item?
    
    /// the current total value of the item factoring the added options
    public var totalAmount: Decimal {
        var totalAmount: Decimal = item?.itemPrice ?? Decimal.zero
        for option in optionsToAdd {
            totalAmount += option.price
        }
        return totalAmount
    }
    
    /// The initializer takes the `Item` as a parameter
    ///
    /// - Parameter item: An `Item` object that contains nested options
    @objc public init?(item: Item) {
        guard item.optionGroups != nil, item.optionGroups.count > 0 else { return nil }
        self.item = item
        self.optionGroups = item.optionGroups
        
        self.itemOption = nil
    }
    
    internal init(itemOption: ItemOption) {
        self.item = nil
        
        self.itemOption = itemOption
        self.optionGroups = itemOption.nestedOptionGroups
    }
}


extension ItemOptionBuilder {
    
    /// Function returns a list of `ItemOption` objects that where added for a given group id
    ///
    /// - Parameter groupId: The group id to filter the added `ItemOption` objects by
    /// - Returns: Returns an list of `ItemOption` objects that belong to the passed in group id
    public func selectedOptionsFor(groupId: Int) -> [ItemOption] {
        var options: [ItemOption] = []
        
        guard let _ = optionGroups.filter ({ $0.id == groupId}).last else {
            for (_, itemOptionBuilder) in selectedNestedOptions {
                guard itemOptionBuilder.itemOption != nil else { continue }
                options.append(contentsOf: itemOptionBuilder.selectedOptionsFor(groupId: groupId))
            }
            return options
        }
        
        if let itemOptionBuilder = selectedNestedOptions[groupId] {
            let selectedSubOptions = itemOptionBuilder.optionsToAdd
            if  selectedSubOptions.count > 0 {
                options.append(itemOptionBuilder.itemOption!)
            }
        }
        
        if let groupOptions = itemsToAdd[groupId], groupOptions.count > 0 {
            options.append(contentsOf: groupOptions)
        }
        
        return options
    }
        
//    public func addOption(groupId: Int, option: ItemOption, optionGroupHandler: ((ItemOptionBuilder?, UPError?) -> Void)? = nil) {
    /// Function to add an `ItemOption` to the ItemOptionBuilder
    ///
    /// - Parameters:
    ///   - groupId: The group id to which the `ItemOption` belongs to
    ///   - option: The `ItemOption` that is to be added to the ItemOptionBuilder
    /// - Throws: Throws an error if the added `ItemOption` count for a group exceeds that of the specified `ItemOptionGroup.maxSelectable` value of the group
    public func addOption(groupId: Int, option: ItemOption) throws {

        guard let optionGroup = optionGroups.filter ({ $0.id == groupId}).last else {
            for (_, itemOptionBuilder) in selectedNestedOptions {
                guard itemOptionBuilder.itemOption != nil else { continue }
                do {
                    try itemOptionBuilder.addOption(groupId: groupId, option: option)
                } catch (let error) {
                    throw error
                }
            }
            return
        }
        
        if let options = option.nestedOptionGroups, options.count > 0 {
            guard optionGroup.options.filter ({ $0.id == option.id }).last != nil else {
//                optionGroupHandler?(nil, UPError(type: .invalidOption))
                return
            }
            
            if let previousOptionBuilder = selectedNestedOptions[groupId],
                let previousItemOptionId = previousOptionBuilder.itemOption?.id,
                previousItemOptionId == option.id {
                
//                optionGroupHandler?(previousOptionBuilder, nil)
                return
            }
            
            selectedNestedOptions.removeValue(forKey: groupId)
            
            let nestedOptionBuilder = ItemOptionBuilder(itemOption: option)
            
            selectedNestedOptions[groupId] = nestedOptionBuilder
            
//            optionGroupHandler?(nestedOptionBuilder, nil)
        } else if optionGroup.isMultipleSelectionGroup {
            if var selectedOptionGroupOptions = itemsToAdd[groupId] {
                guard selectedOptionGroupOptions.count < optionGroup.maxSelectable else {
                    let error = ItemOptionBuilderError.maxItemOptionsSelected(optionGroup.maxSelectable)
                    throw error
//                    optionGroupHandler?(nil, error)
//                    return
                }
                selectedOptionGroupOptions.append(option)
                itemsToAdd[groupId] = selectedOptionGroupOptions
            } else {
                itemsToAdd[groupId] = [option]
            }
            
//            optionGroupHandler?(nil, nil)
        } else {
            itemsToAdd[groupId] = [option]
//            optionGroupHandler?(nil, nil)
        }
    }
    
    /// Function to remove an `ItemOption` from ItemOptionBuilder
    ///
    /// - Parameters:
    ///   - groupId: The group id to which the `ItemOption` belongs to
    ///   - option: The `ItemOption` to be removed from the ItemOptionBuilder
    public func removeOption(groupId: Int, option: ItemOption) {
        guard let _ = optionGroups.filter ({ $0.id == groupId}).last else {
            for (_, itemOptionBuilder) in selectedNestedOptions {
                guard itemOptionBuilder.itemOption != nil else { continue }
                itemOptionBuilder.removeOption(groupId: groupId, option: option)
            }
            return
        }

        if let options = option.nestedOptionGroups, options.count > 0, selectedNestedOptions[groupId] != nil {
            selectedNestedOptions.removeValue(forKey: groupId)
        } else if var selectedOptionGroupOptions = itemsToAdd[groupId], let index = selectedOptionGroupOptions.index(of: option) {
            selectedOptionGroupOptions.remove(at: index)
            if selectedOptionGroupOptions.count == 0 {
                itemsToAdd.removeValue(forKey: groupId)
            } else {
                itemsToAdd[groupId] = selectedOptionGroupOptions
            }
        }
    }
    
    /// Build function validates if the `ItemOption`'s have been added according to the values specified by the `ItemOptionGroup.minSelectable` and `ItemOptionGroup.maxSelectable` variables in the `ItemOptionGroup`
    ///
    /// - Returns: Returns an CartItem that can be added to the Cart if ItemOptions are added as specified
    /// - Throws: throws an error with the first group having an invalid number of option addition to the ItemOptionBuilder
    public func build() throws -> CartItem {
        let result = isValidOptionGroup
        
        guard result.0 else {
            throw ItemOptionBuilderError.invalid(group: result.1!)
        }
        
        return CartItem(item: item!, optionBuilder: self)
    }

}
