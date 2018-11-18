//
//  Authorization.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/01.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public struct Authorization {
    public enum Kind: String {
        case yelp = "yelp"
    }
    
    public struct Data {
        public let accessToken: String
        public let tokenType: String
        public let expires: Date
        
        public func toHttpHeader() -> Header {
            return Header(fields: [.authorization("\(tokenType) \(accessToken)")])
        }
        
        public var isExpires: Bool {
            let now = Date()
            return now >= expires
        }
    }
}

extension Authorization {
    class DataStore {
        static let shared = DataStore(
            strategy: AuthorizationDataMemoryCacheStrategy()
        )
        
        private var strategy: AuthorizationDataCacheStrategy
        
        private init(strategy: AuthorizationDataCacheStrategy) {
            self.strategy = strategy
        }
        
        func getValidData(for kind: Authorization.Kind) -> Authorization.Data? {
            return strategy.getValidData(for: kind)
        }
        
        func store(authorizationData: Authorization.Data, kind: Authorization.Kind) {
            strategy.store(authorizationData: authorizationData, kind: kind)
        }
    }
}

