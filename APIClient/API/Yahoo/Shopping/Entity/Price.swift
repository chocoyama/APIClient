//
//  Price.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Price {
    public let price: Int
    public let currency: String?
    public let label: Label
    
    public struct Label {
        public let taxIncluded: Bool?
        public let fixed: Int?
        public let `default`: Int?
        public let sale: Int?
        public let baseFixed: Int?
        public let baseDefault: Int?
        public let baseSale: Int?
        public let periodStart: Date?
        public let periodEnd: Date?
    }
}
