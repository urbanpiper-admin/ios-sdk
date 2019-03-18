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
//    func handleCart(error: CartError?)

}

internal class CartManager: NSObject {

    @objc internal static let shared: CartManager = CartManager()

//    private typealias WeakRefCartManagerDelegate = WeakRef<CartManagerDelegate>
//    private var cartManagerObservers: [WeakRefCartManagerDelegate] = [WeakRefCartManagerDelegate]()

    @objc internal var cartItems = [CartItem]()
    
    @objc internal var isReorder: Bool {
        guard cartItems.count > 0 else { return false }
        var isReorder: Bool = true
        
        for cartItem in cartItems {
            isReorder = isReorder && cartItem.isReorder
        }
        
        return isReorder
    }

    @objc internal var cartValue: Decimal {
        return cartItems.reduce (0.0, { $0 + ($1.totalAmount * Decimal($1.quantity)).rounded } )
    }

    @objc internal var cartCount: Int {
        return cartItems.reduce (0, { $0 + $1.quantity } )
    }
    
    @objc internal var cartPreOrderStartTime: Date? {
        var preOrderItems = cartItems.filter { $0.preOrderStartTime != nil }
        guard preOrderItems.count > 0 else { return nil }

        if preOrderItems.count > 1 {
            preOrderItems.sort { $0.preOrderStartTime! < $1.preOrderStartTime! }
        }
        
        let earliestTime = preOrderItems.last!.preOrderStartTime!
        return Date(timeIntervalSince1970: TimeInterval(earliestTime / 1000))
    }

    @objc internal func cartCount(for itemId: Int) -> Int {
        return cartItems.reduce (0, { $0 + ($1.id == itemId ? $1.quantity : 0) } )
    }
    
    internal func notesFor(itemId: Int) -> String {
        return cartItems.filter { $0.id == itemId }.last?.notes ?? ""
    }
    
    internal func updateNotesFor(id: Int, notes: String?) {
        cartItems.filter { $0.id == id }.last?.notes = notes
    }

}

//// Cart Observer Management
//
//extension CartManager {
//
//    @objc internal static func addObserver(delegate: CartManagerDelegate) {
//        let weakRefCartManagerDelegate: WeakRefCartManagerDelegate = WeakRefCartManagerDelegate(value: delegate)
//        shared.cartManagerObservers.append(weakRefCartManagerDelegate)
//    }
//
//
//    @objc internal static func removeObserver(delegate: CartManagerDelegate) {
//        guard let index = (shared.cartManagerObservers.index { $0.value === delegate }) else { return }
//        shared.cartManagerObservers.remove(at: index)
//    }
//
//}


// MARK: Cart Management

extension CartManager {

    @objc internal func add(cartItem: CartItem, quantity: Int, notes: String? = nil) throws {
        if cartCount == 0 {
            AnalyticsManager.shared.track(event: .cartInit)
        }
        
        let isCartItem: Bool
        
        if let item = cartItems.filter({ $0 == cartItem }).last {
            if item.isItemQuantityAvailable(quantity: quantity) {
                item.quantity += quantity
                item.notes = notes
            } else {
                let error = CartError.itemQuantityNotAvaialble(cartItem.currentStock - item.quantity)
                throw error
//                let _ = cartManagerObservers.map { $0.value?.handleCart(error: upError) }
            }
             isCartItem = cartItem === item
        } else {
            cartItem.quantity = quantity
            cartItem.notes = notes

            cartItems.append(cartItem)
            
            isCartItem = false
        }

        AnalyticsManager.shared.track(event: .addToCart(item: cartItem,
                                                        checkoutPageItemAdd: isCartItem,
                                                        itemDetailsPageItemAdd: cartItem.isItemDetailsItem))
        
        NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
//        let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
    }

    internal func remove(itemId: Int, quantity: Int) {
        guard let cartItem = cartItems.filter({ $0.id == itemId }).last else { return }
        
        AnalyticsManager.shared.track(event: .removeFromCart(item: cartItem))
        
        cartItem.quantity -= quantity

        guard cartItem.quantity <= 0 else {
            NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
//            let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
            return
        }
        guard let index = cartItems.index(of: cartItem) else {
            NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
//            let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
            return
        }
        cartItems.remove(at: index)

        NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
//        let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
    }

    @objc internal func clearCart() {
//        isReorder = false
        cartItems.removeAll()
        NotificationCenter.default.post(name: Notification.Name.cartChanged, object: nil)
//        let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
    }

}
