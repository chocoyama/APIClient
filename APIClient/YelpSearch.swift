//
//  YelpSearch.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/01.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation
import SwiftyJSON

// https://www.yelp.com/developers/documentation/v3/business_search

extension API.Yelp.Parameter {
    public enum Search: ParameterType {
        // Required
        // location or (latitude & longitude)
        case location(String)
        case latitude(Double)
        case longitude(Double)
        
        // Optional
        case term(Term)
        case radius(meter: Int)
        case categories([YelpCategory])
        case locale(Locale)
        case limit(Int)
        case offset(Int)
        case sortBy(YelpSort)
        case price([PriceLevel])
        case openNow(Bool)
        case openAt(unixtime: Int)
        case attributes([Attributes])
        
        public typealias ResultType = API.Yelp.Result.Search
        
        public var dataSet: DataSet {
            switch self {
            case .term(let value):        return (key: "term",       value: value.rawValue)
            case .location(let value):    return (key: "location",   value: value)
            case .latitude(let value):    return (key: "latitude",   value: "\(value)")
            case .longitude(let value):   return (key: "longitude",  value: "\(value)")
            case .radius(let meter):      return (key: "radius",     value: "\(min(meter, 40000))")
            case .categories(let value):  return (key: "categories", value: value.map{ $0.rawValue }.joined(separator: ","))
            case .locale(let value):      return (key: "locale",     value: value.rawValue)
            case .limit(let value):       return (key: "limit",      value: "\(value)")
            case .offset(let value):      return (key: "offset",     value: "\(value)")
            case .sortBy(let value):      return (key: "sort_by",    value: value.rawValue)
            case .price(let level):       return (key: "price",      value: level.map{ $0.rawValue }.joined(separator: ","))
            case .openNow(let value):     return (key: "open_now",   value: value ? "true": "false")
            case .openAt(let value):      return (key: "open_at",    value: "\(value)")
            case .attributes(let values): return (key: "attributes", value: values.map{ $0.rawValue }.joined(separator: ","))
            }
        }
    }

}

extension API.Yelp.Result {
    public struct Search: APIResultType {
        public let total: Int
        public let businesses: [Business]
        public let region: Region
        
        public static func decode(data: Data) -> Search? {
            guard let json = try? JSON(data: data),
                let total = json["total"].int,
                let latitude = json["region"]["center"]["latitude"].double,
                let longitude = json["region"]["center"]["longitude"].double
                else {
                    return nil
            }
            let businesses = createBusiness(from: json)
            let region = Region(center: Coordinate(latitude: latitude, longitude: longitude))
            return Search(total: total, businesses: businesses, region: region)
        }
        
        private static func createBusiness(from json: JSON) -> [Business] {
            var businesses = [Business]()
            for (_, businessJson) in json["businesses"] {
                guard let id = businessJson["id"].string,
                    let name = businessJson["name"].string else { continue }
                
                var categories: [Business.Category] = []
                for (_, category) in businessJson["categories"] {
                    if let alias = category["alias"].string,
                        let title = category["title"].string {
                        let category = Business.Category(alias: alias, title: title)
                        categories.append(category)
                    }
                }
                
                let coordinate: Coordinate?
                if let latitude = businessJson["coordinates"]["latitude"].double,
                    let longitude = businessJson["coordinates"]["longitude"].double {
                    coordinate = Coordinate(latitude: latitude, longitude: longitude)
                } else {
                    coordinate = nil
                }
                
                
                let locationJson = businessJson["location"]
                let location = Business.Location(
                    city: locationJson["city"].string ?? "",
                    country: locationJson["country"].string ?? "",
                    address1: locationJson["address1"].string ?? "",
                    address2: locationJson["address2"].string ?? "",
                    address3: locationJson["address3"].string ?? "",
                    displayAddress: locationJson["display_address"].compactMap{ $0.1.string },
                    state: locationJson["state"].string ?? "",
                    zipCode: locationJson["zip_code"].string ?? "",
                    crossStreet: locationJson["cross_streets"].string ?? ""
                )
                
                let business = Business(
                    id: id,
                    name: name,
                    imageUrl: businessJson["image_url"].string.flatMap{ $0 }.flatMap{ URL(string: $0) },
                    isClaimed: nil,
                    isClosed: businessJson["is_closed"].bool,
                    url: businessJson["url"].string.flatMap{ $0 }.flatMap{ URL(string: $0) },
                    price: businessJson["price"].string,
                    rating: businessJson["rating"].double,
                    reviewCount: businessJson["review_count"].int,
                    phone: businessJson["phone"].string,
                    displayPhone: businessJson["display_phone"].string,
                    photos: [],
                    hours: [],
                    categories: categories,
                    coordinate: coordinate,
                    location: location,
                    distance: businessJson["distance"].double,
                    transactions: businessJson["transactions"].compactMap{ $0.1.string }
                )
                businesses.append(business)
            }
            return businesses
        }
    }

}
