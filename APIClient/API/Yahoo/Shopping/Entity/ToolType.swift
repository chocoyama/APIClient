//
//  ToolType.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public enum ToolType {
    case fullB
    case lightB
    case lightC
    
    public init?(string: String) {
        switch string {
        case "1": self = .fullB
        case "2": self = .lightB
        case "3": self = .lightC
        default: return nil
        }
    }
}
