//
//  Inventory.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Inventory {
    public let subcode: String
    public let options: [Option]
    public let quantity: Int? // 空の時は無制限
    public let allowOverdraft: Bool
    public let availability: Availability
    
    public struct Option {
        public let name: String
        public let value: String
    }
    
    public enum Availability {
        case instock
        case outofstock
        
        public init?(string: String) {
            switch string {
            case "instock": self = .instock
            case "outofstock": self = .outofstock
            default: return nil
            }
        }
    }
}
