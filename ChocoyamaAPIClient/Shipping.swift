//
//  Shipping.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Shipping {
    public let code: Code
    public let name: String
    
    public enum Code {
        case none
        case free
        case conditionalFree
        
        public init?(string: String) {
            switch string {
            case "1": self = .none
            case "2": self = .free
            case "3": self = .conditionalFree
            default: return nil
            }
        }
    }
}
