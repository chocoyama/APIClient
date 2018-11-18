//
//  RakutenBooksSearch.swift
//  ChocoyamaAPICIients
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 * 楽天
 * 楽天ブックス書籍検索API
 * https://webservice.rakuten.co.jp/api/booksbooksearch/
 */

extension API.RakutenBooks.Parameter {
    public enum Search: ParameterType {
        case title(String)
        case author(String)
        case publisherName(String)
        case booksize(BookSize)
        case isbn(String)
        case booksGenreId(String)
        case hits(Int)
        case page(Int)
        case availability(RakutenBooksAvailability)
        case outOfStockFlag(OutOfStockFlag)
        case chirayomiFlag(ChirayomiFlag)
        case sort(RakutenSort)
        case limitedFlag(LimitedFlag)
        case carrier(Carrier)
        case genreInfoFlag(GenreInfoFlag)
        
        public typealias ResultType = API.RakutenBooks.Result.Search
        
        public var dataSet: DataSet {
            switch self {
            case .title(let title):               return (key: "title",                value: title)
            case .author(let author):             return (key: "author",               value: author)
            case .publisherName(let name):        return (key: "publisherName",        value: name)
            case .booksize(let size):             return (key: "size",                 value: size.rawValue)
            case .isbn(let isbn):                 return (key: "isbn",                 value: isbn)
            case .booksGenreId(let id):           return (key: "booksGenreId",         value: id)
            case .hits(let hits):                 return (key: "hits",                 value: "\(hits)")
            case .page(let page):                 return (key: "page",                 value: "\(page)")
            case .availability(let availability): return (key: "availability",         value: availability.rawValue)
            case .outOfStockFlag(let flag):       return (key: "outOfStockFlag",       value: flag.rawValue)
            case .chirayomiFlag(let flag):        return (key: "chirayomiFlag",        value: flag.rawValue)
            case .sort(let sort):                 return (key: "sort",                 value: sort.rawValue)
            case .limitedFlag(let flag):          return (key: "limitedFlag",          value: flag.rawValue)
            case .carrier(let carrier):           return (key: "carrier",              value: carrier.rawValue)
            case .genreInfoFlag(let flag):        return (key: "genreInformationFlag", value: flag.rawValue)
            }
        }
    }
}

extension API.RakutenBooks.Result {
    public struct Search: APIResultType {
        let metaData: RakutenBookSearchMetaData
        let items: [RakutenBookSearchItem]
        
        public static func decode(data: Data) -> Search? {
            guard let json = try? JSON(data: data) else { return nil }
            
            let metaData = RakutenBookSearchMetaData(
                count: json["count"].intValue,
                page: json["page"].intValue,
                first: json["first"].intValue,
                last: json["last"].intValue,
                hits: json["hits"].intValue,
                carrier: json["carrier"].intValue,
                pageCount: json["pageCount"].intValue
            )
            
            var items = [RakutenBookSearchItem]()
            for (_, subJson):(String, JSON) in json["Items"] {
                let item = subJson["Item"]
                items.append(
                    RakutenBookSearchItem(
                        title: item["title"].stringValue,
                        titleKana: item["titleKana"].stringValue,
                        subTitle: item["subTitle"].stringValue,
                        subTitleKana: item["subTitleKana"].stringValue,
                        seriesName: item["seriesName"].stringValue,
                        seriesNameKana: item["seriesNameKana"].stringValue,
                        contents: item["contents"].stringValue,
                        author: item["author"].stringValue,
                        authorKana: item["authorKana"].stringValue,
                        publisherName: item["publisherName"].stringValue,
                        size: item["size"].stringValue,
                        isbn: item["isbn"].stringValue,
                        itemCaption: item["itemCaption"].stringValue,
                        salesDate: item["salesDate"].stringValue,
                        itemPrice: item["itemPrice"].intValue,
                        listPrice: item["listPrice"].intValue,
                        discountRate: item["discountRate"].intValue,
                        discountPrice: item["discountPrice"].intValue,
                        itemUrl: item["itemUrl"].stringValue,
                        affiliateUrl: item["affiliateUrl"].stringValue,
                        smallImageUrl: item["smallImageUrl"].stringValue,
                        mediumImageUrl: item["mediumImageUrl"].stringValue,
                        largeImageUrl: item["largeImageUrl"].stringValue,
                        anyImageUrl: item["largeImageUrl"].stringValue,
                        chirayomiUrl: item["chirayomiUrl"].stringValue,
                        availability: item["availability"].stringValue,
                        postageFlag: item["postageFlag"].intValue,
                        limitedFlag: item["limitedFlag"].intValue,
                        reviewCount: item["reviewCount"].intValue,
                        reviewAverage: item["reviewAverage"].stringValue,
                        booksGenreId: item["BooksGenreId"].stringValue
                    )
                )
            }
            
            
            return Search(
                metaData: metaData,
                items: items
            )
        }

    }

}
