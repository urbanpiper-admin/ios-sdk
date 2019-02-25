//
//  ItemBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 11/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

public class ItemOptionBuilder: NSObject {
    
    public let itemOption: ItemOption?

    public weak var previousItemOptionBuilder: ItemOptionBuilder?
    
    public let optionGroups: [ItemOptionGroup]

    internal private(set) var selectedNestedOptions: [Int : ItemOptionBuilder] = [:]
    
    internal private(set) var itemsToAdd: [Int: [ItemOption]] = [:]
    
    public var isValidOptionGroup: Bool {
        var isValidItem : Bool = true
        
        for group in optionGroups {
            isValidItem = isValidItem && isOptionGroupValid(group: group)
            guard isValidItem else { break }
        }

        return isValidItem
    }
    
    public func isOptionGroupValid(group : ItemOptionGroup) -> Bool {
        var isValidItem : Bool = group.minSelectable == 0
        
        if let groupOptionBuilder = selectedNestedOptions[group.id] {
            isValidItem = groupOptionBuilder.isValidOptionGroup
        } else {
            
            let itemOptionsCount = itemsToAdd[group.id]?.count ?? 0
            
            if group.isMultipleSelectionGroup {
                isValidItem = (itemOptionsCount >= group.minSelectable && itemOptionsCount <= group.maxSelectable)
            } else if group.isSingleSelectionGroup {
                isValidItem = itemOptionsCount == 1
            }
        }
        return isValidItem
    }

    internal init(itemOption: ItemOption) {
        self.itemOption = itemOption
        self.optionGroups = itemOption.nestedOptionGroups
    }

    @objc public init(optionGroups: [ItemOptionGroup]) {
        self.itemOption = nil
        self.optionGroups = optionGroups
    }
    
    public var optionsToAdd: [ItemOption] {
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
    
    public var optionsToRemove: [ItemOption] {
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
    
//  MARK: Move it to an seperate extension file
    public var totalAmount: Decimal {
        var totalAmount: Decimal = Decimal.zero
        for option in optionsToAdd {
            totalAmount += option.price
        }
        return totalAmount
    }
    
//  MARK: Move it to an seperate extension file
    var descriptionText: String? {
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
    
    public func selectedOptionsFor(groupId: Int) -> [ItemOption] {
        var options: [ItemOption] = []
        
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
        
    public func addOption(groupId: Int, option: ItemOption, optionGroupHandler: ((ItemOptionBuilder?, UPError?) -> Void)? = nil) {
        guard let optionGroup = optionGroups.filter ({ $0.id == groupId}).last else {
            optionGroupHandler?(nil, UPError(type: .invalidGroupId))
            return
        }
        
        if let options = option.nestedOptionGroups, options.count > 0 {
            guard optionGroup.options.filter ({ $0.id == option.id }).last != nil else {
                optionGroupHandler?(nil, UPError(type: .invalidOption))
                return
            }
            
            if let previousOptionBuilder = selectedNestedOptions[groupId],
                let previousItemOptionId = previousOptionBuilder.itemOption?.id,
                previousItemOptionId == option.id {
                
                optionGroupHandler?(previousOptionBuilder, nil)
                return
            }
            
            selectedNestedOptions.removeValue(forKey: groupId)
            
            let nestedOptionBuilder = ItemOptionBuilder(itemOption: option)
            nestedOptionBuilder.previousItemOptionBuilder = self
            
            selectedNestedOptions[groupId] = nestedOptionBuilder
            
            optionGroupHandler?(nestedOptionBuilder, nil)
        } else if optionGroup.isMultipleSelectionGroup {
            if var selectedOptionGroupOptions = itemsToAdd[groupId] {
                guard selectedOptionGroupOptions.count < optionGroup.maxSelectable else {
                    let error: UPError = UPError(type: .maxItemOptionsSelected(optionGroup.maxSelectable))
                    optionGroupHandler?(nil, error)
                    return
                }
                selectedOptionGroupOptions.append(option)
                itemsToAdd[groupId] = selectedOptionGroupOptions
            } else {
                itemsToAdd[groupId] = [option]
            }
            
            optionGroupHandler?(nil, nil)
        } else {
            itemsToAdd[groupId] = [option]
            optionGroupHandler?(nil, nil)
        }
    }
    
    public func removeOption(groupId: Int, option: ItemOption) {
        guard let _ = optionGroups.filter ({ $0.id == groupId}).last else { return }

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

}
