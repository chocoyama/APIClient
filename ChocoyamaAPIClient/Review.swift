//
//  Review.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public extension Item {
    public struct Review {
        public let rate: Double
        public let count: Int
        public let url: URL?
    }
}

public extension Store {
    public struct Review {
        public let rate: Double
        public let count: Int
        public let total: Int
        public let detailRate: Double
    }
}
