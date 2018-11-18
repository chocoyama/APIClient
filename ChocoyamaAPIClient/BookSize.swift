//
//  BookSize.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public enum BookSize: String {
    case all = "0"
    case book = "1"
    case paperBack = "2"
    case shinsho = "3"
    case completeWorks = "4"
    case dictionary = "5"
    case pictureBook = "6"
    case illustratedBook = "7"
    case cd = "8"
    case comic = "9"
    case mook = "10"
    
    var japaneseTitle: String {
        switch self {
        case .all: return "全て"
        case .book: return "単行本"
        case .paperBack: return "文庫"
        case .shinsho: return "新書"
        case . completeWorks: return "全集・双書"
        case .dictionary: return "事・辞典"
        case .pictureBook: return "図鑑"
        case .illustratedBook: return "絵本"
        case .cd: return "カセット・CD"
        case .comic: return "コミック"
        case .mook: return "ムックその他"
        }
    }
}
