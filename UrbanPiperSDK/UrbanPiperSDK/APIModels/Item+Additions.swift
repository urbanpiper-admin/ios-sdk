//
//  Item+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 27/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

public struct StockQuantity {
    public static let unlimited = -1
    public static let noStock = 0
}

extension ItemObject {

    @objc public enum FoodType: Int, RawRepresentable {
        case veg = 1
        case nonVeg = 2
        case eggtarian = 3
    }

    public var foodTypeEnum: FoodType? {
        guard let intVal: Int = Int(foodType), let foodTypeEnum: FoodType = FoodType(rawValue: intVal) else { return  nil }
        return foodTypeEnum
    }

    public func isItemQuantityAvailable(quantity: Int) -> Bool {
        guard AppConfigManager.shared.firRemoteConfigDefaults.itemQtyRestrictToCurentStock else { return true }
        guard let stock = currentStock else { return true }
        guard stock != StockQuantity.unlimited else { return true }
        guard stock != StockQuantity.noStock else { return false }
        let currentCartStock = CartManager.shared.cartCount(for: self)
        guard stock >= currentCartStock + quantity else { return false }
        return true
    }

}
