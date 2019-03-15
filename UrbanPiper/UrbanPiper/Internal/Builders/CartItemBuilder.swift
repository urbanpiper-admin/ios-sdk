//
//  CartItemBuilder.swift
//  UrbanPiper
//
//  Created by Vid on 18/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objc private class CartItemBuilder: NSObject {

    public let item: Item
    
    internal var optionBuilder: ItemOptionBuilder?

    @objc public init(item: Item) {
        self.item = item
    }
    
    public var totalAmount: Decimal {
        var totalAmount: Decimal = item.itemPrice ?? Decimal.zero
        if let builder = optionBuilder {
            totalAmount += builder.totalAmount
        }
        return totalAmount
    }
    
    public func itemOptionBuilder() -> ItemOptionBuilder? {
        if optionBuilder != nil {
            return optionBuilder
        } else if item.optionGroups != nil, item.optionGroups.count > 0 {
            let itemOptionBuilder = ItemOptionBuilder(item: item)
            
            optionBuilder = itemOptionBuilder
        } else {
            optionBuilder = nil
        }
        return optionBuilder
    }

    
//    @objc public func build() throws -> CartItem {
//        if optionBuilder != nil, !(optionBuilder!.isValidOptionGroup.0) {
//            throw UPError(type: .unknown)
//        }
//        
//        do {
//            let optionsToAdd = try optionBuilder?.build()
//            return CartItem(item: item, optionBuilder: optionBuilder!)
//        } catch (let error) {
//            throw error
//        }
//    }
    
    
}
