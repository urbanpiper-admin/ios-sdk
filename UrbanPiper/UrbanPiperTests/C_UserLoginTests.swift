//
//  C_UserLoginTests.swift
//  UrbanPiperTests
//
//  Created by Vid on 13/03/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import XCTest
import UrbanPiper
import Vinyl

class C_UserLoginTests: XCTestCase {
    
    static let turntable: Turntable = {
        return Turntable(vinylName: "User Login Responses")
    }()
    
    var turntable: Turntable {
        return C_UserLoginTests.turntable
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
    }
        
    override func setUp() {
        
    }
    
    override func tearDown() {
        turntable.stopRecording()
    }
    
    func testValidUserLogin() {
        let expectation = XCTestExpectation(description: "Login an user with valid credentials")
        
        upSDK.login(phone: "+918903464104", password: "qwerty", completion: { (loginResponse) in
            XCTAssert(loginResponse != nil && loginResponse!.status == "success", "Valid user login failed")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                XCTAssert(self.upSDK.getUser()?.userBizInfoResponse != nil, "User biz info update failed")
                expectation.fulfill()
            })
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Valid user login failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
}
