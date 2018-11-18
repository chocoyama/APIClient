//
//  Area.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Area {
    public struct Prefecture {
        public let code: PrefectureCode
        public let name: String?
    }
    
    public let code: AreaCode
    public let name: String?
    public let prefectures: [Prefecture]
    public let deadline: Int
    public let condition: String?
}
