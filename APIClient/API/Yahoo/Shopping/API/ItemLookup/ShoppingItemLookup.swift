//
//  ShoppingItemLookup.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

/**
 * Yahoo!ショッピング
 * 商品詳細情報取得API
 * http://developer.yahoo.co.jp/webapi/shopping/shopping/v1/itemlookup.html
 */

extension API.YahooShopping.Parameter {
    public enum ItemLookup: ParameterType {
        // MARK:- required
        case itemId(String)
        
        // MARK:- optional
        case affiliateType
        case affiliateId(String)
        case callback(String) // utf8
        case responseGroup(ResponseGroup)
        case imageSize(ImageSize)
        case license(StamprallyRank)
        
        public typealias ResultType = API.YahooShopping.Result.ItemLookup
        
        public var dataSet: DataSet {
            switch self {
            case .itemId(let id): return (key: "itemcode", value: id)
            case .affiliateType: return (key: "affiliate_type", value: "vc")
            case .affiliateId(let id): return (key: "affiliate_id", value: id)
            case .callback(let utf8encodedStr): return (key: "callback", value: utf8encodedStr)
            case .responseGroup(let group): return (key: "responsegroup", value: group.rawValue)
            case .imageSize(let size): return (key: "image_size", value: "\(size.rawValue)")
            case .license(let rank): return (key: "license", value: rank.rawValue)
            }
        }
        
        public static func createItemCode(storeId: String, itemCode: String) -> String {
            return "\(storeId)_\(itemCode)"
        }
    }
}

extension API.YahooShopping.Result {
    public struct ItemLookup: APIResultType {
        public let totalResultReturned: Int
        public let firstResultPosition: Int
        public let itemids: [String]
        public let items: [Item]
        
        public static func decode(data: Data) -> ItemLookup? {
            let xml = XML.parse(data)
            let itemIds = xml[["ResultSet", "Result", "ItemCode", "Codes", "Code"]].compactMap{ $0.text }
            return ItemLookup(
                totalResultReturned: xml["ResultSet"].attributes["totalResultsReturned"].flatMap{ Int($0) } ?? 0,
                firstResultPosition: xml["ResultSet"].attributes["firstResultPosition"].flatMap{ Int($0) } ?? 0,
                itemids: itemIds,
                items: ItemFactory().createFrom(itemLookupXml: xml, itemIds: itemIds)
            )
        }
    }
}

