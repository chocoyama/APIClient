//
//  Availability.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

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
