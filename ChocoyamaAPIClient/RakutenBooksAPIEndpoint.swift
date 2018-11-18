//
//  RakutenAPIEndpoint.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

extension API.RakutenBooks {
    public enum Endpoint: APIEndpoint {
        case bookSearch
        
        private static let host = "app.rakuten.co.jp"
        private static let apiPath = "https://\(host)/services/api"
        
        public static let configuration: APIConfiguration = API.RakutenBooks.Configuration()
        
        public var urlString: String {
            switch self {
            case .bookSearch: return API.RakutenBooks.Endpoint.apiPath + "/BooksBook/Search/20130522"
            }
        }
        
        public var method: Method {
            switch self {
            case .bookSearch: return .get
            }
        }
        
        public var authorization: Authorization.Kind? {
            switch self {
            case .bookSearch: return nil
            }
        }
    }

}
