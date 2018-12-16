//
//  ShoppingItemSearch.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

/**
 * Yahoo!ショッピング
 * 商品検索API
 * http://developer.yahoo.co.jp/webapi/shopping/shopping/v1/itemsearch.html
 */

extension API.YahooShopping.Parameter {
    public enum ItemSearch: ParameterType {
        // MARK:- either required
        case query(String)
        case jan(Int)
        case isbn(Int)
        case categoryId(Int)
        case productId(Int)
        case personId(Int)
        case brandId(Int)
        case storeId(String)
        
        // Mark:- optional
        case affiliateType
        case callback(String) // utf8
        case type(SearchType)
        case imageSize(ImageSize)
        case priceFrom(Int)
        case priceTo(Int)
        case affiliateFrom(Int)
        case affiliateTo(Int)
        case preOrder
        case hits(Int) // max: 50
        case offset(Int)
        case module(ModuleType)
        case availability
        case discount
        case shipping(ShippingType)
        case payment(PaymentType)
        case license(StamprallyRank)
        case saleStartFrom(String) // YYYYMMDDhhmmss
        case saleStartTo(String)
        case saleEndFrom(String)
        case saleEndTo(String)
        case expArea(AreaCode)
        case expDeadlineFrom(Int) // 1 ~ 24
        case expDeadlineTo(Int) // 1 ~ 24
        case sameDayArea(AreaCode)
        case sameDayDeadlineFrom(Int) // 1 ~ 24
        case sameDayDeadlineTo(Int) // 1 ~ 24
        case seller(SellerFilterType)
        
        public typealias ResultType = API.YahooShopping.Result.ItemSearch
        
        public var dataSet: DataSet {
            switch self {
            case .query(let query):               return (key: "query",                  value: query)
            case .jan(let code):                  return (key: "jan",                    value: "\(code)")
            case .isbn(let code):                 return (key: "isbn",                   value: "\(code)")
            case .categoryId(let id):             return (key: "category_id",            value: "\(id)")
            case .productId(let id):              return (key: "product_id",             value: "\(id)")
            case .personId(let id):               return (key: "person_id",              value: "\(id)")
            case .brandId(let id):                return (key: "brand_id",               value: "\(id)")
            case .storeId(let id):                return (key: "store_id",               value: id)
            case .affiliateType:                  return (key: "affiliate_type",         value: "vc")
            case .callback(let utf8EncodedStr):   return (key: "callback",               value: utf8EncodedStr)
            case .type(let type):                 return (key: "type",                   value: type.rawValue)
            case .imageSize(let size):            return (key: "image_size",             value: "\(size.rawValue)")
            case .priceFrom(let value):           return (key: "price_from",             value: "\(value)")
            case .priceTo(let value):             return (key: "price_to",               value: "\(value)")
            case .affiliateFrom(let value):       return (key: "affiliate_from",         value: "\(value)")
            case .affiliateTo(let value):         return (key: "affiliate_to",           value: "\(value)")
            case .preOrder:                       return (key: "preorder",               value: "1")
            case .hits(let count):                return (key: "hits",                   value: "\(count)")
            case .offset(let value):              return (key: "offset",                 value: "\(value)")
            case .module(let type):               return (key: "module",                 value: type.rawValue)
            case .availability:                   return (key: "availability",           value: "1")
            case .discount:                       return (key: "discount",               value: "1")
            case .shipping(let type):             return (key: "shipping",               value: type.rawValue)
            case .payment(let type):              return (key: "payment",                value: type.rawValue)
            case .license(let rank):              return (key: "license",                value: rank.rawValue)
            case .saleStartFrom(let dateStr):     return (key: "salestart_from",         value: dateStr)
            case .saleStartTo(let dateStr):       return (key: "salestart_to",           value: dateStr)
            case .saleEndFrom(let dateStr):       return (key: "saleend_from",           value: dateStr)
            case .saleEndTo(let dateStr):         return (key: "saleend_to",             value: dateStr)
            case .expArea(let code):              return (key: "exp_area",               value: code.rawValue)
            case .expDeadlineFrom(let value):     return (key: "exp_deadline_from",      value: "\(value)")
            case .expDeadlineTo(let value):       return (key: "exp_deadline_to",        value: "\(value)")
            case .sameDayArea(let code):          return (key: "same_day_area",          value: code.rawValue)
            case .sameDayDeadlineFrom(let value): return (key: "same_day_deadline_from", value: "\(value)")
            case .sameDayDeadlineTo(let value):   return (key: "same_day_deadline_to",   value: "\(value)")
            case .seller(let type):               return (key: "seller",                 value: type.rawValue)
            }
        }
    }
}

extension API.YahooShopping.Result {
    public struct ItemSearch: APIResultType {
        public let totalResultAvailable: Int
        public let totalResultsReturned: Int
        public let firstResultPosition: Int
        public let query: String
        public let module: Module
        public let items: [Item]
        
        public static func decode(data: Data) -> ItemSearch? {
            let xml = XML.parse(data)
            return ItemSearch(
                totalResultAvailable: xml["ResultSet"].attributes["totalResultsAvailable"].flatMap{ Int($0) } ?? 0,
                totalResultsReturned: xml["ResultSet"].attributes["totalResultsReturned"].flatMap{ Int($0) } ?? 0,
                firstResultPosition: xml["ResultSet"].attributes["firstResultPosition"].flatMap{ Int($0) } ?? 0,
                query: xml[["ResultSet", "Result", "Request", "Query"]].text ?? "",
                module: ModuleFactory().create(from: xml[["ResultSet", "Result", "Modules"]]),
                items: ItemFactory().createFrom(itemSearchXml: xml)
            )
        }
    }
}
