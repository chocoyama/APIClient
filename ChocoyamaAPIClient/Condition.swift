//
//  Condition.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public enum Condition: String {
    case new
    case old
    
    public init?(string: String) {
        switch string {
        case "new": self = .new
        case "old": self = .old
        default: return nil
        }
    }
}
