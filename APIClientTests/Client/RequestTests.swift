//
//  RequestTests.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import APIClient

class RequestTests: XCTestCase {
    
    func testCreateShoppingRequest() {
        API.YahooShopping.Configuration.appId = "appId"
        let request = Request.init(
            endpoint: API.YahooShopping.Endpoint.itemSearch,
            parameter: Parameter<API.YahooShopping.Parameter.ItemSearch>().add(.query("test"))
        )
        XCTAssertEqual(request.create().url?.absoluteString, "https://shopping.yahooapis.jp/ShoppingWebService/V1/itemSearch?query=test&appid=appId")
    }
    
}
