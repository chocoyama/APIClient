//
//  Point.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public extension Item {
    public struct Point {
        public let amount: Int
        public let times: Int
        public let premiumAmount: Int
        public let premiumTimes: Int
        public let premiumCpAmount: Int?
        public let premiumCpTimes: Int?
        public let appCpAmount: Int?
        public let appCpTimes: Int?
        public let preAppCpAmount: Int?
        public let preAppCpTimes: Int?
    }

}

public extension Store {
    public struct Point {
        public let grant: Bool
        public let accept: Bool
    }
}
