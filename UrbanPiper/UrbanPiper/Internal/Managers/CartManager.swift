//
//  CartManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 26/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc internal protocol CartManagerDelegate {
    func refreshCartUI()
}

internal class CartManager: NSObject {
    @objc internal static let shared: CartManager = CartManager()

    @objc internal var cartItems = [CartItem]()

    @objc internal var isReorder: Bool {
        guard cartItems.count > 0 else { return false }
        var isReorder: Bool = true

        for cartItem in cartItems {
            isReorder = isReorder && cartItem.isReorder
        }

        return isReorder
    }

    @objc internal var cartValue: Double {
        cartItems.reduce(0.0) { $0 + ($1.totalAmount * Double($1.quantity)) }
    }

    @objc internal var cartCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }

    @objc internal var cartPreOrderStartTime: Date? {
        var preOrderItems = cartItems.filter { $0.preOrderStartTime != nil }
        guard preOrderItems.count > 0 else { return nil }

        if preOrderItems.count > 1 {
            preOrderItems.sort { $0.preOrderStartTime! < $1.preOrderStartTime! }
        }

        let earliestTime = preOrderItems.last!.preOrderStartTime!
        return earliestTime
    }

    @objc internal func cartCount(for itemId: Int) -> Int {
        cartItems.reduce(0) { $0 + ($1.id == itemId ? $1.quantity : 0) }
    }

    internal func notesFor(itemId: Int) -> String {
        cartItems.filter { $0.id == itemId }.last?.notes ?? ""
    }

    internal func updateNotesFor(id: Int, notes: String?) {
        guard let item = cartItems.filter({ $0.id == id }).last else { return }
        guard let index = cartItems.firstIndex(of: item) else { return }
        let newItem = item.with(notes: notes)
        cartItems.remove(at: index)
        cartItems.insert(newItem, at: index)
    }
}

// MARK: Cart Management

extension CartManager {
    @objc internal func add(cartItem: CartItem, quantity: Int, notes: String? = nil) throws {
        if cartCount == 0 {
            AnalyticsManager.shared.track(event: .cartInit)
        }

        let isCartItem: Bool

        if let item = cartItems.filter({ $0 == cartItem }).last {
            if item.isItemQuantityAvailable(quantity: quantity) {
                guard let index = cartItems.firstIndex(of: item) else { return }
                let newItem = item.with(quantity: item.quantity + quantity, notes: notes)
                cartItems.remove(at: index)
                cartItems.insert(newItem, at: index)
            } else {
                let error = CartError.itemQuantityNotAvaialble(cartItem.currentStock - item.quantity)
                throw error
            }
            isCartItem = cartItem === item
        } else {
            let newCartItem = cartItem.with(quantity: quantity, notes: notes)

            cartItems.append(newCartItem)

            isCartItem = false
        }

        AnalyticsManager.shared.track(event: .addToCart(item: cartItem,
                                                        checkoutPageItemAdd: isCartItem,
                                                        itemDetailsPageItemAdd: cartItem.isItemDetailsItem))

        NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
    }

    internal func remove(itemId: Int, quantity: Int) {
        guard let cartItem = cartItems.filter({ $0.id == itemId }).last else { return }

        AnalyticsManager.shared.track(event: .removeFromCart(item: cartItem))

        guard let index = cartItems.firstIndex(of: cartItem) else { return }
        let newCartItem = cartItem.with(quantity: cartItem.quantity - quantity)
        cartItems.remove(at: index)

        if newCartItem.quantity > 0 {
            cartItems.insert(newCartItem, at: index)
        }

        NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
    }

    @objc internal func clearCart() {
        cartItems.removeAll()
        NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
    }
}
