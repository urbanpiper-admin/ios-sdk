//
//  ItemBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 11/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

public class ItemBuilder: NSObject {
    
    internal let item: Item
    
    var itemsToAdd: [ItemOption] = []
    internal var itemsToRemove: [ItemOption] = []

    public init(item: Item) {
        self.item = item
    }
        
    public func add(option: ItemOption) {
        itemsToAdd.append(option)

        if let itemOption = itemsToRemove.filter ({ $0.id == option.id }).last, let index = itemsToRemove.index(of: itemOption), option.recommended {
            itemsToRemove.remove(at: index)
        }
    }
    
    public func remove(option: ItemOption) {
        if let itemOption = itemsToAdd.filter ({ $0.id == option.id }).last, let index = itemsToAdd.index(of: itemOption) {
            itemsToAdd.remove(at: index)
        }

        if option.recommended, itemsToRemove.filter ({ $0.id == option.id }).last != nil {
            itemsToRemove.append(option)
        }
    }
    
    public func build() -> CartItem {
        return CartItem()
    }
}
