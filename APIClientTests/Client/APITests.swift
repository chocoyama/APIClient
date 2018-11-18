//
//  API.swift
//  ChocoyamaAPIClientTests
//
//  Created by Takuya Yokoyama on 2018/11/18.
//  Copyright © 2018 chocoyama. All rights reserved.
//

import XCTest
@testable import APIClient

class APITests: XCTestCase {

    func testPlistから初期化することができるか() {
        API.configure(plistName: "API", bundle: Bundle(for: type(of: self)))
        XCTAssertNotNil(API.YahooShopping.Configuration.appId)
        XCTAssertNotNil(API.RakutenBooks.Configuration.affiliateId)
        XCTAssertNotNil(API.RakutenBooks.Configuration.applicationId)
        XCTAssertNotNil(API.Yelp.Configuration.apiKey)
    }

}
