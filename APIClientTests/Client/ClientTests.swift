//
//  ClientTests.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/03.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ChocoyamaAPIClient

class ClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        API.configure(plistName: "API", bundle: Bundle(for: type(of: self)))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test連続してリクエスト() {
        let expectation = self.expectation(description: "search")
        
        let request = Request(
            endpoint: API.Yelp.Endpoint.search,
            parameter: Parameter<API.Yelp.Parameter.Search>().add([
                .location("新宿"),
                .locale(.japan),
                .term(.food),
                .radius(meter: 500)
            ])
        )
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "test", attributes: .concurrent)
        
        (0..<2).forEach { _ in
            group.enter()
            queue.async(group: group) {
                Client.send(request) { (result) in
                    switch result {
                    case .success(_): break
                    case .failure(let error): XCTFail(error.localizedDescription)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { 
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func test開始したリクエストをキャンセル() {
        let expectation = self.expectation(description: "search")
        
        let request = Request(
            endpoint: API.Yelp.Endpoint.search,
            parameter: Parameter<API.Yelp.Parameter.Search>().add([
                .location("新宿"),
                .locale(.japan),
                .term(.food),
                .radius(meter: 500)
            ])
        )
        
        let transactionId = Client.send(request) { (result) in
            defer { expectation.fulfill() }
            switch result {
            case .success(_): XCTFail("キャンセル失敗")
            case .failure(_): break
            }
        }
        
        Client.cancel(transactionId)
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
