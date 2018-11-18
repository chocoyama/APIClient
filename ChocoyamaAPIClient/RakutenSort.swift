//
//  Sort.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public enum RakutenSort: String {
    case standard = "standard"
    case sales = "sales"
    case old = "+releaseDate"
    case new = "-releaseDate"
    case cheap = "+itemPrice"
    case expensive = "-itemPrice"
    case reviewCount = "reviewCount"
    case reviewAverage = "reviewAverage"
    
    var japaneseTitle: String {
        switch self {
        case .standard: return "標準"
        case .sales: return "売れている順"
        case .old: return "発売日が古い順"
        case .new: return "発売日が新しい順"
        case .cheap: return "価格が安い順"
        case .expensive: return "価格が高い順"
        case .reviewCount: return "レビューの件数が多い順"
        case .reviewAverage: return "レビューの平均評価が高い順"
        }
    }
}
