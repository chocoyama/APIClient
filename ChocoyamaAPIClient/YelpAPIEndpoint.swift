//
//  YelpAPIEndpoint.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/01.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

extension API.Yelp {
    public enum Endpoint: APIEndpoint {
        case search
        case business(id: String)
        
        private static let host = "api.yelp.com"
        private static let v3 = "https://\(host)/v3"
        
        public static let configuration: APIConfiguration = API.Yelp.Configuration()
        
        public var urlString: String {
            switch self {
            case .search:           return "\(API.Yelp.Endpoint.v3)/businesses/search"
            case .business(let id): return "\(API.Yelp.Endpoint.v3)/businesses/\(id.rfc3986Encode() ?? id)"
            }
        }
        
        public var method: Method {
            return .get
        }
        
        public var authorization: Authorization.Kind? {
            return nil
        }
    }

}
