    //
//  YelpAPIClientTest.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/01.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import APIClient

class YelpAPIClientTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        API.configure(plistName: "API", bundle: Bundle(for: type(of: self)))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test検索実行() {
        let expectation = self.expectation(description: "search")
        
        let endpoint = API.Yelp.Endpoint.search
        let parameter = Parameter<API.Yelp.Parameter.Search>()
                            .add(.location("新宿"))
                            .add(.locale(.japan))
                            .add(.term(.food))
                            .add(.radius(meter: 500))
        
        let request = Request(endpoint: endpoint, parameter: parameter)
        
        Client.send(request) { (result) in
            switch result {
            case .success(_): break
            case .failure(let error): XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func test詳細情報取得実行() {
        let expectation = self.expectation(description: "business")
        
        let request = Request(endpoint: API.Yelp.Endpoint.business(id: "BVK5atBBbYeY5PmAiCuLwQ"),
                              parameter: Parameter<API.Yelp.Parameter.Business>())
        
        Client.send(request) { (result) in
            switch result {
            case .success(_): break
            case .failure(let error): XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
