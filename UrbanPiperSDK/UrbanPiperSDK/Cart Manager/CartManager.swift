//
//  CartManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 26/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public protocol CartManagerDelegate {

    func refreshCartUI()
//    func handleCart(error: CartError?)

}

public class CartManager: NSObject {

    @objc public static let shared: CartManager = CartManager()

    private typealias WeakRefCartManagerDelegate = WeakRef<CartManagerDelegate>
    private var cartManagerObservers: [WeakRefCartManagerDelegate] = [WeakRefCartManagerDelegate]()

    @objc public var cartItems = [CartItem]()

    public var groupedCartItems: [[CartItem]] {
        return Array(Dictionary(grouping:cartItems){$0.category.id ?? 0}.values)
    }
    
    @objc public var isReorder: Bool = false

    @objc public var couponCodeToApply: String?
    
    public var lastOrder: [String: Any]? = {
       return UserDefaults.standard.value(forKey: "lastOrderKey") as? [String: Any]
    }()
    {
        didSet {
            if lastOrder == nil {
                UserDefaults.standard.removeObject(forKey: "lastOrderKey")
            } else {
                UserDefaults.standard.set(lastOrder, forKey: "lastOrderKey")
            }
            let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
        }
    }

    @objc public var cartValue: Decimal {
        return cartItems.reduce (0.0, { $0 + ($1.totalAmount * Decimal($1.quantity)).rounded } )
    }

    @objc public var cartCount: Int {
        return cartItems.reduce (0, { $0 + $1.quantity } )
    }
    
    public var cartItemIds: [Int] {
        return cartItems.map { $0.id }
    }

    @objc public var cartPreOrderStartTime: Date? {
        var preOrderItems = cartItems.filter { $0.preOrderStartTime != nil }
        guard preOrderItems.count > 0 else { return nil }

        if preOrderItems.count > 1 {
            preOrderItems.sort { $0.preOrderStartTime! < $1.preOrderStartTime! }
        }
        
        let earliestTime = preOrderItems.last!.preOrderStartTime!
        return Date(timeIntervalSince1970: TimeInterval(earliestTime / 1000))
    }

    @objc public func cartCount(for itemId: Int) -> Int {
        return cartItems.reduce (0, { $0 + ($1.id == itemId ? $1.quantity : 0) } )
    }
    
    public func notesFor(itemId: Int) -> String {
        return cartItems.filter { $0.id == itemId }.last?.notes ?? ""
    }
    
    public func updateNotesFor(id: Int, notes: String?) {
        cartItems.filter { $0.id == id }.last?.notes = notes
    }

}

// Cart Observer Management

extension CartManager {

    @objc public static func addObserver(delegate: CartManagerDelegate) {
        let weakRefCartManagerDelegate: WeakRefCartManagerDelegate = WeakRefCartManagerDelegate(value: delegate)
        shared.cartManagerObservers.append(weakRefCartManagerDelegate)
    }


    @objc public static func removeObserver(delegate: CartManagerDelegate) {
        guard let index = (shared.cartManagerObservers.index { $0.value === delegate }) else { return }
        shared.cartManagerObservers.remove(at: index)
    }
    
}


// MARK: Cart Management

extension CartManager {

    @objc public func add(cartItem: CartItem, quantity: Int, notes: String? = nil, fromDetailScreen: Bool = false, fromCheckoutScreen: Bool = false) throws {
        if cartCount == 0 {
            AnalyticsManager.shared.track(event: .cartInit)
        }

        AnalyticsManager.shared.track(event: .addToCart(item: cartItem,
                                                        checkoutPageItemAdd: fromCheckoutScreen,
                                                        itemDetailsPageItemAdd: fromDetailScreen))
        
        if let item = cartItems.filter({ $0 == cartItem }).last {
            if item.isItemQuantityAvailable(quantity: quantity) {
                item.quantity += quantity
                item.notes = notes
            } else {
                let error = CartError.maxOrderableQuantityAdded(cartItem.currentStock)
                throw error
//                let _ = cartManagerObservers.map { $0.value?.handleCart(error: upError) }
            }
        } else {
            cartItem.quantity = 1
            cartItem.notes = notes

            cartItems.append(cartItem)
        }
        
        let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
    }

    public func remove(itemId: Int, quantity: Int) {
        guard let cartItem = cartItems.filter({ $0.id == itemId }).last else { return }
        
        AnalyticsManager.shared.track(event: .removeFromCart(item: cartItem))
        
        cartItem.quantity -= quantity

        guard cartItem.quantity <= 0 else {
            let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
            return
        }
        guard let index = cartItems.index(of: cartItem) else {
            let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
            return
        }
        cartItems.remove(at: index)

        let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
    }

    @objc public func clearCart() {
        isReorder = false
        cartItems.removeAll()
        let _ = cartManagerObservers.map { $0.value?.refreshCartUI() }
    }

}
