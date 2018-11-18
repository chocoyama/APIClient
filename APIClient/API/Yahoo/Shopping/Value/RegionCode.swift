//
//  RegionCode.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public enum AreaCode: String {
    case hokkaido_tohoku = "1"
    case kanto = "2"
    case sinetsu_hokuriku = "3"
    case tokai = "4"
    case kinki = "5"
    case chugoku = "6"
    case shikoku = "7"
    case kyushu_okinawa = "8"
    
    public init?(string: String) {
        switch string {
        case AreaCode.hokkaido_tohoku.rawValue: self = .hokkaido_tohoku
        case AreaCode.kanto.rawValue: self = .kanto
        case AreaCode.sinetsu_hokuriku.rawValue: self = .sinetsu_hokuriku
        case AreaCode.tokai.rawValue: self = .tokai
        case AreaCode.kinki.rawValue: self = .kinki
        case AreaCode.chugoku.rawValue: self = .chugoku
        case AreaCode.shikoku.rawValue: self = .shikoku
        case AreaCode.kyushu_okinawa.rawValue: self = .kyushu_okinawa
        default: return nil
        }
    }
}

public enum PrefectureCode: String {
    case hokkaido  = "01"
    case aomori    = "02"
    case iwate     = "03"
    case miyagi    = "04"
    case akita     = "05"
    case yamagata  = "06"
    case fukushima = "07"
    case tokyo     = "13"
    case kanagawa  = "14"
    case saitama   = "11"
    case chiba     = "12"
    case ibaraki   = "08"
    case tochigi   = "09"
    case gunma     = "10"
    case yamanashi = "19"
    case niigata   = "15"
    case nagano    = "20"
    case toyama    = "16"
    case ishikawa  = "17"
    case fukui     = "18"
    case aichi     = "23"
    case gihu      = "21"
    case shizuoka  = "22"
    case mie       = "24"
    case osaka     = "27"
    case hyogo     = "28"
    case kyoto     = "26"
    case shiga     = "25"
    case nara      = "29"
    case wakayama  = "30"
    case tottori   = "31"
    case shimane   = "32"
    case okayama   = "33"
    case hiroshima = "34"
    case yamaguchi = "35"
    case tokushima = "36"
    case kagawa    = "37"
    case ehime     = "38"
    case kouchi    = "39"
    case fukuoka   = "40"
    case saga      = "41"
    case nagasaki  = "42"
    case kumamoto  = "43"
    case oita      = "44"
    case miyazaki  = "45"
    case kagoshima = "46"
    case okinawa   = "47"
    
    public init?(string: String) {
        switch string {
        case PrefectureCode.hokkaido.rawValue: self = .hokkaido
        case PrefectureCode.aomori.rawValue: self = .aomori
        case PrefectureCode.iwate.rawValue: self = .iwate
        case PrefectureCode.miyagi.rawValue: self = .miyagi
        case PrefectureCode.akita.rawValue: self = .akita
        case PrefectureCode.yamagata.rawValue: self = .yamagata
        case PrefectureCode.fukushima.rawValue: self = .fukushima
        case PrefectureCode.tokyo.rawValue: self = .tokyo
        case PrefectureCode.kanagawa.rawValue: self = .kanagawa
        case PrefectureCode.saitama.rawValue: self = .saitama
        case PrefectureCode.chiba.rawValue: self = .chiba
        case PrefectureCode.ibaraki.rawValue: self = .ibaraki
        case PrefectureCode.tochigi.rawValue: self = .tochigi
        case PrefectureCode.gunma.rawValue: self = .gunma
        case PrefectureCode.yamanashi.rawValue: self = .yamanashi
        case PrefectureCode.niigata.rawValue: self = .niigata
        case PrefectureCode.nagano.rawValue: self = .nagano
        case PrefectureCode.toyama.rawValue: self = .toyama
        case PrefectureCode.ishikawa.rawValue: self = .ishikawa
        case PrefectureCode.fukui.rawValue: self = .fukui
        case PrefectureCode.aichi.rawValue: self = .aichi
        case PrefectureCode.gihu.rawValue: self = .gihu
        case PrefectureCode.shizuoka.rawValue: self = .shizuoka
        case PrefectureCode.mie.rawValue: self = .mie
        case PrefectureCode.osaka.rawValue: self = .osaka
        case PrefectureCode.hyogo.rawValue: self = .hyogo
        case PrefectureCode.kyoto.rawValue: self = .kyoto
        case PrefectureCode.shiga.rawValue: self = .shiga
        case PrefectureCode.nara.rawValue: self = .nara
        case PrefectureCode.wakayama.rawValue: self = .wakayama
        case PrefectureCode.tottori.rawValue: self = .tottori
        case PrefectureCode.shimane.rawValue: self = .shimane
        case PrefectureCode.okayama.rawValue: self = .okayama
        case PrefectureCode.hiroshima.rawValue: self = .hiroshima
        case PrefectureCode.yamaguchi.rawValue: self = .yamaguchi
        case PrefectureCode.tokushima.rawValue: self = .tokushima
        case PrefectureCode.kagawa.rawValue: self = .kagawa
        case PrefectureCode.ehime.rawValue: self = .ehime
        case PrefectureCode.kouchi.rawValue: self = .kouchi
        case PrefectureCode.fukuoka.rawValue: self = .fukuoka
        case PrefectureCode.saga.rawValue: self = .saga
        case PrefectureCode.nagasaki.rawValue: self = .nagasaki
        case PrefectureCode.kumamoto.rawValue: self = .kumamoto
        case PrefectureCode.oita.rawValue: self = .oita
        case PrefectureCode.miyazaki.rawValue: self = .miyazaki
        case PrefectureCode.kagoshima.rawValue: self = .kagoshima
        case PrefectureCode.okinawa.rawValue: self = .okinawa
        default: return nil
        }
    }
}
