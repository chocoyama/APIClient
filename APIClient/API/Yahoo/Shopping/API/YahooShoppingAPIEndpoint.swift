//
//  YahooAPIEndpoint.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

extension API.YahooShopping {
    public enum Endpoint: APIEndpoint {
        case itemSearch
        case itemLookup
        
        private static let host = "shopping.yahooapis.jp"
        private static let shopping = "ShoppingWebService"
        private static let shoppingV1 = "https://\(host)/\(shopping)/V1"
        private static let shoppingV2 = "https://\(host)/\(shopping)/V2"
        
        public static let configuration: APIConfiguration = API.YahooShopping.Configuration()
        
        public var urlString: String {
            switch self {
            case .itemSearch: return API.YahooShopping.Endpoint.shoppingV1 + "/itemSearch"
            case .itemLookup: return API.YahooShopping.Endpoint.shoppingV1 + "/itemLookup"
            }
        }
        
        public var method: Method {
            switch self {
            case .itemSearch: return .get
            case .itemLookup: return .get
            }
        }
        
        public var authorization: Authorization.Kind? {
            switch self {
            case .itemSearch: return nil
            case .itemLookup: return nil
            }
        }
        
    }

}
