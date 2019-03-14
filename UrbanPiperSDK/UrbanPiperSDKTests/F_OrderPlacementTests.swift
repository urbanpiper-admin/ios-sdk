//
//  F_OrderPlacementTests.swift
//  UrbanPiperSDKTests
//
//  Created by Vid on 13/03/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import XCTest
import UrbanPiperSDK
import Vinyl

class F_OrderPlacementTests: XCTestCase {
    
    let couponCode: String = "FLAT20"
   
    static let turntable: Turntable = {
        return Turntable(vinylName: "Order Placement API Responses")
    }()
    
    var turntable: Turntable {
        return F_OrderPlacementTests.turntable
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
        turntable.stopRecording()
    }
    
    func testPlaceOrder() {
        guard let item: Item = B_GeneralCatalogueAPITests.categoryItems.objects.filter ({ $0.currentStock > 0 }).last else {
            XCTAssert(false, "No items available")
            return
        }
        
        let cartItem = CartItem(item: item)
        
        try! upSDK.addItemToCart(cartItem: cartItem, quantity: 2)
        
        let checkoutBuilder: CheckoutBuilder = upSDK.startCheckout()
        
        var expectation = XCTestExpectation(description: "Validate the cart items")

        checkoutBuilder.validateCart(store: A_GeneralAPITests.nearestStoreResponse.store!,
                                     useWalletCredits: false,
                                     deliveryOption: .delivery,
                                     cartItems: upSDK.getCartItems(),
                                     orderTotal: upSDK.getCartValue(),
                                     completion:
            { (response) in
                XCTAssert(response?.order != nil, "Validate cart failed")
                expectation.fulfill()
        }, failure: { (_) in
            XCTAssert(false, "Validate cart failed")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)

        
        expectation = XCTestExpectation(description: "Validate coupon code")
        
        checkoutBuilder.validateCoupon(code: couponCode, completion: { (response) in
            XCTAssert(response != nil, "Validate coupon code failed")
            expectation.fulfill()
        }, failure: { (_) in
            XCTAssert(false, "Validate coupon code failed")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)

        
//        expectation = XCTestExpectation(description: "Init payment method")
//
//        let paymentOption = PaymentOption.paymentGateway
//        
//        checkoutBuilder.initPayment(paymentOption: paymentOption, completion: { (response) in
//            XCTAssert(response != nil, "Payment init failed")
//            expectation.fulfill()
//        }, failure: { (_) in
//            XCTAssert(false, "Payment init failed")
//            expectation.fulfill()
//        })
//
//        wait(for: [expectation], timeout: 10.0)

        
        expectation = XCTestExpectation(description: "Place order with items")
        
        let deliverableAddresses = D_UserAPITests.deliverableAddresses.addresses.filter { $0.deliverable ?? false }
        let address = deliverableAddresses.first
        
        let deliveryTime = Date().addingTimeInterval(TimeInterval(120))
        
        checkoutBuilder.placeOrder(address: address, deliveryDate: Date(), deliveryTime: deliveryTime, timeSlot: nil,
                                   paymentOption: .cash, instructions: "", phone: "+918903464104", completion:
            { (response) in
                XCTAssert(response?.status != nil && response!.status == "success", "Order placement failed")
                expectation.fulfill()
        }, failure: { (_) in
            XCTAssert(false, "Order placement failed")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
