//
//  RakutenAPIClientsTests.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import APIClient

class RakutenAPIClientsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        API.configure(plistName: "API", bundle: Bundle(for: type(of: self)))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBooksBookSearchRequest() {
        let parameter = Parameter<API.RakutenBooks.Parameter.Search>()
                            .add(.title("onepiece"))
        
        let request = Request(
            endpoint: API.RakutenBooks.Endpoint.bookSearch,
            parameter: parameter
        )
        
        let expectation = self.expectation(description: "bookSearch")
        Client.send(request) { (result) in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(_): break
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
