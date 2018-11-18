//
//  YahooAPIClientTests.swift
//  YahooAPIClientTests
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import XCTest
@testable import APIClient

class YahooAPIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        API.configure(plistName: "API", bundle: Bundle(for: type(of: self)))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testItemSearchRequest() {
        let parameter = Parameter<API.YahooShopping.Parameter.ItemSearch>()
            .add(.module(.priceRanges))
            .add(.module(.subcategories))
            .add(.module(.brands))
            .add(.module(.specs))
            .add(.categoryId(9999))
            .add(.brandId(9999))
        
        let request = Request.init(
            endpoint: API.YahooShopping.Endpoint.itemSearch,
            parameter: parameter
        )
        
        let expectation = self.expectation(description: "itemSearch")
        Client.send(request) { (result) in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testItemLookupRequest() {
        let parameter = Parameter<API.YahooShopping.Parameter.ItemLookup>()
            .add(.itemId("storeId_itemCode"))
            .add(.responseGroup(.large))
        
        let request = Request.init(
            endpoint: API.YahooShopping.Endpoint.itemLookup,
            parameter: parameter
        )
        
        let expectation = self.expectation(description: "itemLookup")
        Client.send(request) { (result) in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
