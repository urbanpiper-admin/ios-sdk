//
//  GeneralCatalogueAPITests.swift
//  UrbanPiperTests
//
//  Created by Vid on 13/03/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import XCTest
import UrbanPiper
import Vinyl


class B_GeneralCatalogueAPITests: XCTestCase {
    
    static var itemCategories: CategoriesResponse!
    static var categoryItems: CategoryItemsResponse!

    private struct CustomQueryMatcher: RequestMatcher {
        func match(lhs: Request, rhs: Request) -> Bool {
            let queryItems: (Request) -> Set<URLQueryItem> = { request in
                let components = URLComponents(string: request.url?.absoluteString ?? "")
                return Set(components?.queryItems?.filter { $0.name != "cx" } ?? [])
            }
            
            let lhsItems = queryItems(lhs)
            let rhsItems = queryItems(rhs)
            
            return lhsItems == rhsItems
        }
    }
    
    lazy var storeId: Int = {
        return A_GeneralAPITests.nearestStoreResponse.store!.bizLocationId
    }()
    
    let categoryId: Int = 2757
    let itemId: Int = 55221
    
    static let turntable: Turntable = {
        let customRequestMatcher: RequestMatcher = CustomQueryMatcher()
        let customRequestMatcherType: RequestMatcherType = .custom(customRequestMatcher)
        let configuration = TurntableConfiguration(matchingStrategy: MatchingStrategy.requestAttributes(types: [.body, customRequestMatcherType], playTracksUniquely: true))
        return Turntable(vinylName: "General Catalogue API Responses", turntableConfiguration: configuration)
    }()
    
    var turntable: Turntable {
        return B_GeneralCatalogueAPITests.turntable
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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        turntable.stopRecording()
    }

    func testGetCategories() {
        let expectation = XCTestExpectation(description: "Retrive the businesses categories from the server")
        
        upSDK.getCategories(storeId: storeId, completion: { (categoriesResponse) in
            XCTAssert(categoriesResponse?.objects?.count ?? 0 > 0, "Business categories retrival failed")
            B_GeneralCatalogueAPITests.itemCategories = categoriesResponse
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Business categories retrival failed")
        })
            
        wait(for: [expectation], timeout: 10.0)

    }
    
    func testGetCategoryItems() {
        let expectation = XCTestExpectation(description: "Retrive the category item from the server")
        
        upSDK.getCategoryItems(categoryId: categoryId, storeId: storeId, completion: { (categoryItemsResponse) in
            XCTAssert(categoryItemsResponse?.objects?.count ?? 0 > 0, "Category items retrival failed")
            B_GeneralCatalogueAPITests.categoryItems = categoryItemsResponse
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Category items retrival failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSearchItems() {
        let expectation = XCTestExpectation(description: "Search items for keyword")
        
        upSDK.searchItems(query: "chick", storeId: storeId, completion: { (itemSearchResponse) in
            XCTAssert(itemSearchResponse?.items?.count ?? 0 > 0, "Item search failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Item search failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetFilterAndSortOptions() {
        let expectation = XCTestExpectation(description: "Retrive category filter & sort option")
        
        upSDK.getFilterAndSortOptions(categoryId: categoryId, completion: { (categoryOptionsResponse) in
            XCTAssert(categoryOptionsResponse != nil, "Category options fetch failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Category options fetch failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testGetItemDetails() {
        let expectation = XCTestExpectation(description: "Get item details")
        
        upSDK.getItemDetails(itemId: itemId, storeId: storeId, completion: { (item) in
            XCTAssert(item != nil, "Item details fetch failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Item details fetch failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetFeaturedItems() {
        let expectation = XCTestExpectation(description: "Get featured items")
        
        upSDK.getFeaturedItems(storeId: storeId, completion: { (categoryItemsResponse) in
            XCTAssert(categoryItemsResponse != nil, "Featured items fetch failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Featured items fetch failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetAssociatedItems() {
        let expectation = XCTestExpectation(description: "Get associated items")
        
        upSDK.getAssociatedItems(itemId: itemId, storeId: storeId, completion: { (categoryItemsResponse) in
            XCTAssert(categoryItemsResponse != nil, "Associated items fetch failed")
            expectation.fulfill()
        }, failure: { (_) in
            expectation.fulfill()
            XCTAssert(false, "Associated items fetch failed")
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

}
