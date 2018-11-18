//
//  Hour.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/02.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public struct Hour {
    public let type: String?
    public let opens: [Open]
    public let isOpenNow: Bool
    
    public struct Open {
        public let isOvernight: Bool
        public let end: String?
        public let day: Day?
        public let start: String?
        
        public enum Day: Int {
            case monday    = 0
            case tuesday   = 1
            case wednesday = 2
            case thursday  = 3
            case friday    = 4
            case saturday  = 5
            case sunday    = 6
        }
    }
}
