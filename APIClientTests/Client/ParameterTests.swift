//
//  ParameterTests.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ChocoyamaAPIClient

class ParameterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBuildShoppingParameter() {
        let parameter = Parameter<API.YahooShopping.Parameter.ItemSearch>()
        XCTAssertEqual(parameter.buildParameter(by: .get), "")
        
        let parameterWithQuery = parameter
            .add(.query("test"))
            .buildParameter(by: .get)
        XCTAssertEqual(parameterWithQuery, "?query=test")
        
        let parameterWithQueryAndCategoryID
            = parameter
                .add(.query("test"))
                .add(.categoryId(9999))
                .buildParameter(by: .get)
        XCTAssertEqual(parameterWithQueryAndCategoryID, "?query=test&category_id=9999")
    }
    
    func testBuildRakutenParameter() {
        let parameter = Parameter<API.RakutenBooks.Parameter.Search>()
        XCTAssertEqual(parameter.buildParameter(by: .get), "")
        
        let parameterWithTitle = parameter
            .add(.title("onepiece"))
            .buildParameter(by: .get)
        XCTAssertEqual(parameterWithTitle, "?title=onepiece")
        
        let parameterWithTitleAndHits = parameter
            .add(.title("onepiece"))
            .add(.hits(20))
            .buildParameter(by: .get)
        XCTAssertEqual(parameterWithTitleAndHits, "?title=onepiece&hits=20")
    }
    
}
