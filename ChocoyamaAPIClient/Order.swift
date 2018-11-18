//
//  Order.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Order {
    public let selectOption: [SelectOption]
    public let inputOption: [InputOption]
    
    public struct SelectOption {
        public let name: String
        public let values: [String]
    }
    
    public struct InputOption {
        public let name: String
        public let length: Int?
    }
}
