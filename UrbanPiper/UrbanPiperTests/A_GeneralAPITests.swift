//
//  GeneralAPITests.swift
//  UrbanPiperTests
//
//  Created by Vid on 13/03/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import XCTest
import UrbanPiper
import Vinyl

class A_GeneralAPITests: XCTestCase {
    
    static var nearestStoreResponse: StoreResponse!

    static let turntable: Turntable = {
        let configuration = TurntableConfiguration(recordingMode: .missingTracks(recordingPath: nil))
        return Turntable(vinylName: "General API Responses", turntableConfiguration: configuration)
//        return Turntable(vinylName: "General API Responses")
    }()
    
    var turntable: Turntable {
        return A_GeneralAPITests.turntable
    }
    
    lazy var upSDK: UrbanPiper = {
        return UrbanPiper.sharedInstance()
    }()
    
    override class func setUp() {
        let bizId: String = "76720224"
        let apiUsername: String = "biz_adm_clients_BTWNKmcbJCeb"
        let apiKey: String = "d8e16d812ebe53c7907fe1969210566a981c8962"
        
        UrbanPiper.intialize(bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, session: turntable, callback: { (sdkEvent) in
            print("sdk event \(sdkEvent)")
        })
        UrbanPiper.sharedInstance().logout()
    }
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        turntable.stopRecording()
    }

    func testRegisterFCMToken() {
        let expectation = XCTestExpectation(description: "Register the devices fcm token in the server")

        upSDK.registerFCMToken(token: "d2C4sf3bJyU:APA91bEL-olApHyoBd5ZhIyQmIN7ebaR4mNzSHhbKuRRcT7uRJzLOUOTG1TaD4W8MGEni7wZTPD228AX3daEpbmYUXSQnwHSuXGVAUeZ99xGA3YT76prJC-R76lPutpUsRpv5TxV9Wmi", completion: { (genericResponse) in
            XCTAssert(genericResponse != nil && genericResponse!.status == "success", "FCM token registration failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "FCM token registration failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCheckAppVersion() {
        let infoDictionary: [String: Any] = Bundle.main.infoDictionary!
        let appVersion: String = infoDictionary["CFBundleShortVersionString"] as! String
        
        let expectation = XCTestExpectation(description: "Check for app version update")

        upSDK.checkAppVersion(version: appVersion, completion: { (versionCheckResponse) in
            XCTAssert(versionCheckResponse != nil, "App Version check failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "App Version check failed")
        })

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetNearestStore() {
        let expectation = XCTestExpectation(description: "Get the nearest store to provided lat lng")
        
        upSDK.getNearestStore(lat: 12.970150, lng: 77.731070, completion: { (storeResponse) in
            XCTAssert(storeResponse?.store?.bizLocationId != nil, "Nearest store api call failed")
            A_GeneralAPITests.nearestStoreResponse = storeResponse
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Nearest store api call failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetAllStores() {
        let expectation = XCTestExpectation(description: "Get all stores for a business")
        
        upSDK.getAllStores(completion: { (storeListResponse) in
            XCTAssert(storeListResponse?.stores?.count ?? 0 > 1, "Get all stores api call failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Get all stores api call failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testGetOffers() {
        let expectation = XCTestExpectation(description: "Get offers for a business")
        
        upSDK.getOffers(completion: { (response) in
            XCTAssert(response?.coupons != nil, "Get offers api call failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Get offers api call failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetBanners() {
        let expectation = XCTestExpectation(description: "Get banners for a business")
        
        upSDK.getBanners(completion: { (response) in
            XCTAssert(response?.images != nil, "Get banners api call failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Get banners api call failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
}
