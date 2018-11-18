//
//  SellerType.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public enum SellerType {
    case b
    case c
    
    public init?(string: String) {
        switch string {
        case "B": self = .b
        case "C": self = .c
        default: return nil
        }
    }
}
