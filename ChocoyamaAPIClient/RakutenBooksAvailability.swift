//
//  RakutenBooksAvailability.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public enum RakutenBooksAvailability: String {
    case all = "0"
    case instock = "1"
    case threeToSeven = "2"
    case threeToNine = "3"
    case backOrder = "4"
    case inReservation = "5"
    case checkStock = "6"
    
    var japaneseTitle: String {
        switch self {
        case .all: return "すべての商品"
        case .instock: return "在庫あり"
        case .threeToSeven: return "通常3~7日程度で発送"
        case .threeToNine: return "通常3~9日程度で発送"
        case .backOrder: return "メーカーお取り寄せ"
        case .inReservation: return "予約受付中"
        case .checkStock: return "メーカに在庫確認"
        }
    }
}
