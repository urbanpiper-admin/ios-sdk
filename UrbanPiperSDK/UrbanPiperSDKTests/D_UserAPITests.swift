//
//  D_UserAPITests.swift
//  UrbanPiperSDKTests
//
//  Created by Vid on 12/03/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import XCTest
import UrbanPiperSDK
import Vinyl

class D_UserAPITests: XCTestCase {
    
    static var deliverableAddresses: UserAddressesResponse!

    let storeId: Int = 2070
    
    let itemId: Int = 55221
    let pastOrderId: Int = 8200
    
    let rewardId: Int = 32423

    static var turntable: Turntable = {
        let configuration = TurntableConfiguration(recordingMode: .missingTracks(recordingPath: nil))
        return Turntable(vinylName: "User API Responses", turntableConfiguration: configuration)
//        return Turntable(vinylName: "User API Responses")
    }()
    
    var turntable: Turntable {
        return D_UserAPITests.turntable
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
    
    func testUserInfoRefresh() {
        let expectation = XCTestExpectation(description: "Retrive user info from server")
        
        upSDK.refreshUserInfo(completion: { (userInfoResponse) in
            XCTAssert(userInfoResponse?.phone != nil, "User info fetch api call failure")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "User info fetch api call failure")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRefreshUserBizInfo() {
        let expectation = XCTestExpectation(description: "Retrive user biz info from server")
        
        upSDK.refreshUserBizInfo(completion: { (userBizInfoResponse) in
            XCTAssert(userBizInfoResponse?.userBizInfos?.last?.cardNumbers?.first != nil, "User biz info fetch api call failure")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "User biz info fetch api call failure")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateUserInfo() {
        let expectation = XCTestExpectation(description: "Update the users name in server")
        
        upSDK.updateUserInfo(name: "Vidhyadharan", completion: { (userInfoUpdateResponse) in
            XCTAssert(userInfoUpdateResponse != nil && userInfoUpdateResponse!.success, "User info update failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "User info update failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testChangePassword() {
        let expectation = XCTestExpectation(description: "Change the user's password in server")
        
        upSDK.changePassword(phone: "+918903464104", oldPassword: "qwerty", newPassword: "qwerty", completion: { (genericResponse) in
            XCTAssert(genericResponse?.status != nil && genericResponse?.status == "success", "User's password change failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "User's password change failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetDeliverableAddresses() {
        let expectation = XCTestExpectation(description: "Get the user's deliverable addresses")
        
        upSDK.getDeliverableAddresses(storeId: storeId, completion: { (response) in
            XCTAssert(response?.addresses != nil, "Deliverable addressess fetch failed")
            D_UserAPITests.deliverableAddresses = response
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Deliverable addressess fetch failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAddUpdateDeleteAddress() {
        var expectation = XCTestExpectation(description: "Add new address to saved address")
        
        var address = Address(address1: "address 1", landmark: "landmark", city: "city", lat: 12.970150, lng: 77.731070, pin: "560066", subLocality: "sublocality", tag: "home")
        var newAddressId: Int!
        upSDK.addAddress(address: address, completion: { (response) in
            XCTAssert(response?.addressId != nil, "Add new address failed")
            newAddressId = response?.addressId
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Add new address failed")
        })
        
        wait(for: [expectation], timeout: 10.0)

        expectation = XCTestExpectation(description: "Update user's address in server")
        
        address = Address(id: newAddressId, address1: "address 1", landmark: "landmark 1", city: "city", lat: 12.970150, lng: 77.731070, pin: "560066", subLocality: "sublocality", tag: "home")
        upSDK.updateAddress(address: address, completion: { (response) in
            XCTAssert(response?.addressId != nil && response!.addressId == newAddressId, "Update address failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Update address failed")
        })
        
        wait(for: [expectation], timeout: 10.0)

        expectation = XCTestExpectation(description: "Delete the user's address from server")
        
        upSDK.deleteAddress(addressId: newAddressId, completion: { (response) in
            XCTAssert(response?.status != nil && response?.status == "success", "Delete address failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Delete address failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetWalletTransactions() {
        let expectation = XCTestExpectation(description: "Retrive user's wallet transactions from server")
        
        upSDK.getWalletTransactions(completion: { (response) in
            XCTAssert(response?.transactions != nil, "Wallet transaction fetch failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Wallet transaction fetch failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetPastOrders() {
        let expectation = XCTestExpectation(description: "Get user's past order's from server")
        
        upSDK.getPastOrders(completion: { (response) in
            XCTAssert(response?.orders?.count ?? 0 > 0, "Past order retrival failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Past order retrival failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetPastOrderDetails() {
        let expectation = XCTestExpectation(description: "Retrive past order details")
        
        upSDK.getPastOrderDetails(orderId: pastOrderId, completion: { (response) in
            XCTAssert(response?.order != nil, "Past order detail retrival failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Past order detail retrival failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetRewards() {
        let expectation = XCTestExpectation(description: "Get rewards")
        
        upSDK.getRewards(completion: { (response) in
            XCTAssert(response != nil, "Rewards retrival failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Rewards retrival failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRedeemReward() {
        let expectation = XCTestExpectation(description: "Redeem reward")

        upSDK.redeemReward(rewardId: rewardId, completion: { (response) in
            XCTAssert(response?.status != nil && response?.status == "success", "Redeem reward failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Redeem reward failed")
        })

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetNotifications() {
        let expectation = XCTestExpectation(description: "Retrive user's notifications")
        
        upSDK.getNotifications(completion: { (response) in
            XCTAssert(response?.messages?.count ?? 0 > 0, "Notification retrival failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Notification retrival failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSubmitFeedback() {
        let expectation = XCTestExpectation(description: "Submit feedback for an order placed")

        upSDK.submitFeedback(name: "Vid", rating: 4.0, orderId: pastOrderId, choiceText: nil, comments: "unit testing", completion: { (response) in
            XCTAssert(response?.status != nil && response?.status == "success", "User's feedback submit failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "User's feedback submit failed")
        })

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetItemLikes() {
        let expectation = XCTestExpectation(description: "Retrive user's item likes list")
        
        upSDK.getItemLikes(completion: { (response) in
            XCTAssert(response?.likes != nil, "User's item like retrival failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "User's item like retrival failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLikeUnlikeItem() {
        var expectation = XCTestExpectation(description: "Like an item")
        
        upSDK.likeItem(itemId: itemId, completion: { (response) in
            XCTAssert(response?.status != nil && response?.status == "success", "Item like failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Item like failed")
        })
        
        wait(for: [expectation], timeout: 10.0)

        expectation = XCTestExpectation(description: "Unlike an item")
        
        upSDK.unlikeItem(itemId: itemId, completion: { (response) in
            XCTAssert(response?.status != nil && response?.status == "success", "Item unlike failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Item unlike failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
