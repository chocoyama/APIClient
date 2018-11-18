//
//  API.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2018/11/17.
//  Copyright © 2018 chocoyama. All rights reserved.
//

import Foundation

public struct API {
    public struct YahooShopping {
        public struct Parameter {}
        public struct Result {}
    }
    public struct RakutenBooks {
        public struct Parameter {}
        public struct Result {}
    }
    public struct Yelp {
        public struct Parameter {}
        public struct Result {}
    }
}

extension API {
    public static func configure(plistName: String = "API", bundle: Bundle = .main) {
        guard let path = bundle.path(forResource: plistName, ofType: "plist"),
            let dic = NSDictionary(contentsOfFile: path) else { return }
        configureYahooShopping(with: dic)
        configureRakutenBooks(with: dic)
        configureYelp(with: dic)
    }
    
    private static func configureYahooShopping(with dic: NSDictionary) {
        guard let yshopping = dic["YahooShopping"] as? [String: Any] else { return }
        (yshopping["appId"] as? String).flatMap { API.YahooShopping.Configuration.appId = $0 }
    }
    
    private static func configureRakutenBooks(with dic: NSDictionary) {
        guard let rakutenBooks = dic["RakutenBooks"] as? [String: Any] else { return }
        (rakutenBooks["affiliateId"] as? String).flatMap { API.RakutenBooks.Configuration.affiliateId = $0 }
        (rakutenBooks["applicationId"] as? String).flatMap { API.RakutenBooks.Configuration.applicationId = $0 }
    }
    
    private static func configureYelp(with dic: NSDictionary) {
        guard let yelp = dic["Yelp"] as? [String: Any] else { return }
        (yelp["apiKey"] as? String).flatMap { API.Yelp.Configuration.apiKey = $0 }
    }
}
