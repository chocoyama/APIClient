//
//  YahooAPIConfiguration.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

extension API.YahooShopping {
    public struct Configuration: APIConfiguration {
        public static func set(appId: String) {
            self.appId = appId
        }
        internal static var appId: String!
        
        public static var timeout: Double = 10.0
        
        public let requiredParameter: [DataSet] = [(key: "appid", value: appId)]
        public var requiredHeaderFields: [Header.Field] = []
        
        internal init() {}
    }
}

extension API.RakutenBooks {
    public struct Configuration: APIConfiguration {
        public static func set(applicationId: String, affiliateId: String) {
            self.applicationId = applicationId
            self.affiliateId = affiliateId
        }
        internal static var applicationId: String!
        internal static var affiliateId: String!
        
        public static var timeout: Double = 10.0
        
        public let requiredParameter: [DataSet] = [
            (key: "applicationId", value: applicationId),
            (key: "affiliateId", value: affiliateId)
        ]
        public var requiredHeaderFields: [Header.Field] = []
        
        internal init() {}
    }
}

extension API.Yelp {
    public struct Configuration: APIConfiguration {
        public static func set(apiKey: String) {
            self.apiKey = apiKey
        }
        internal static var apiKey: String!
        
        public static var timeout: Double = 10.0
        
        public var requiredParameter: [DataSet] = []
        public var requiredHeaderFields: [Header.Field] = [
            .authorization("Bearer \(Configuration.apiKey!)")
        ]
        
        internal init() {}
    }
}
