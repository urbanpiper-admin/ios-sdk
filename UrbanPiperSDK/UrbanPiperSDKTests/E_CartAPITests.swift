//
//  E_CartAPITests.swift
//  UrbanPiperSDKTests
//
//  Created by Vid on 14/03/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import XCTest
import UrbanPiperSDK
import Vinyl

class E_CartAPITests: XCTestCase {
    
    static var turntable: Turntable = {
//        let configuration = TurntableConfiguration(recordingMode: .missingTracks(recordingPath: nil))
//        return Turntable(vinylName: "Cart API Responses", turntableConfiguration: configuration)
        return Turntable(vinylName: "Cart API Responses")
    }()
    
    var turntable: Turntable {
        return E_CartAPITests.turntable
    }

    lazy var upSDK: UrbanPiperSDK = {
        return UrbanPiperSDK.sharedInstance()
    }()
    
    override class func setUp() {
        let bizId: String = "76720224"
        let apiUsername: String = "biz_adm_clients_BTWNKmcbJCeb"
        let apiKey: String = "d8e16d812ebe53c7907fe1969210566a981c8962"
        
        UrbanPiperSDK.intialize(bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, session: turntable, callback: { (sdkEvent) in
            print("sdk event \(sdkEvent)")
        })
    }

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    lazy var storeId: Int = {
        return A_GeneralAPITests.nearestStoreResponse.store!.bizLocationId
    }()
    
    lazy var categoryId: Int = {
       return B_GeneralCatalogueAPITests.itemCategories.objects.first!.id
    }()
    
    lazy var categoryItems: CategoryItemsResponse = {
        return B_GeneralCatalogueAPITests.categoryItems
    }()
    
    
    func testAddRemoveItem() {
        guard let item: Item = categoryItems.objects.filter ({ $0.currentStock > 0 }).last else {
            XCTAssert(false, "No items available")
            return
        }

        let cartItem = CartItem(item: item)
        
        try! upSDK.addItemToCart(cartItem: cartItem, quantity: 2)
        XCTAssert(upSDK.getCartCount() == 2, "Cart count mismatch")
        
        try! upSDK.addItemToCart(cartItem: cartItem, quantity: 1)
        XCTAssert(upSDK.getCartCount() == 3, "Cart count mismatch")

        XCTAssert(upSDK.getItemCountFor(itemId: item.id) == 3, "Cart item count mismatch")

        do {
            try upSDK.addItemToCart(cartItem: cartItem, quantity: 50)
            XCTAssert(false, "This should not happened as the item quantity of the item is greater than the current stock of item")
        }
        catch CartError.itemQuantityNotAvaialble(let avaialbleCount) {
            XCTAssert(avaialbleCount == cartItem.currentStock - 3, "Issues with returning the max quantity that can be added for the item")
        } catch {
            XCTAssert(upSDK.getCartCount() == 3, "Cart item add failed")
        }
        
        try! upSDK.addItemToCart(cartItem: cartItem, quantity: cartItem.currentStock - 3)
        XCTAssert(upSDK.getCartCount() == cartItem.currentStock, "Cart count mismatch")

        
        do {
            try upSDK.addItemToCart(cartItem: cartItem, quantity: 1)
            XCTAssert(false, "This should not happened as the item quantity of the item is greater than the current stock of item")
        }
        catch CartError.itemQuantityNotAvaialble(let avaialbleCount) {
            XCTAssert(avaialbleCount == 0, "Issues with returning the max quantity that can be added for the item")
        } catch {
            XCTAssert(upSDK.getCartCount() == 3, "Cart item add failed")
        }
        
        upSDK.removeItemFromCart(itemId: cartItem.id, quantity: 49)
        XCTAssert(upSDK.getCartCount() == 1, "Cart item remove failed")
        
        XCTAssert(upSDK.getItemCountFor(itemId: item.id) == 1, "Cart item count mismatch")

        upSDK.removeItemFromCart(itemId: cartItem.id, quantity: 49)
        XCTAssert(upSDK.getCartCount() == 0, "Cart item remove failed")
        
        XCTAssert(upSDK.getItemCountFor(itemId: item.id) == 0, "Cart item count mismatch")
    }

}
