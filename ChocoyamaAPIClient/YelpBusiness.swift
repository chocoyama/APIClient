//
//  YelpBusiness.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/02.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

// https://www.yelp.com/developers/documentation/v3/business

import Foundation
import SwiftyJSON

extension API.Yelp.Parameter {
    public enum Business: ParameterType {
        case locale(Locale)
        
        public typealias ResultType = API.Yelp.Result.BusinessList
        
        public var dataSet: DataSet {
            switch self {
            case .locale(let value): return (key: "locale", value: value.rawValue)
            }
        }
    }
}

extension API.Yelp.Result {
    public struct BusinessList: APIResultType {
        public let business: Business
        
        public static func decode(data: Data) -> BusinessList? {
            guard let json = try? JSON(data: data),
                let id = json["id"].string,
                let name = json["name"].string else { return nil }
            
            var hours = [Hour]()
            for (_, hourJSON) in json["hours"] {
                let opens = hourJSON["open"].map{
                    return Hour.Open(
                        isOvernight: $0.1["is_overnight"].bool ?? false,
                        end:         $0.1["end"].string,
                        day:         $0.1["day"].int != nil ? Hour.Open.Day(rawValue: $0.1["day"].int!) : nil,
                        start:       $0.1["start"].string
                    )
                }
                
                let hour = Hour(
                    type: hourJSON["hours_type"].string,
                    opens: opens,
                    isOpenNow: hourJSON["is_open_now"].bool ?? false
                )
                hours.append(hour)
            }
            
            var categories: [Business.Category] = []
            for (_, category) in json["categories"] {
                if let alias = category["alias"].string,
                    let title = category["title"].string {
                    let category = Business.Category(alias: alias, title: title)
                    categories.append(category)
                }
            }
            
            let coordinate: Coordinate?
            if let latitude = json["coordinates"]["latitude"].double,
                let longitude = json["coordinates"]["longitude"].double {
                coordinate = Coordinate(latitude: latitude, longitude: longitude)
            } else {
                coordinate = nil
            }
            
            let locationJson = json["location"]
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
                imageUrl: json["image_url"].string.flatMap{ $0 }.flatMap{ URL(string: $0) },
                isClaimed: json["is_claimed"].bool,
                isClosed: json["is_closed"].bool,
                url: json["url"].string.flatMap{ $0 }.flatMap{ URL(string: $0) },
                price: json["price"].string,
                rating: json["rating"].double,
                reviewCount: json["review_count"].int,
                phone: json["phone"].string,
                displayPhone: json["display_phone"].string,
                photos: json["photos"].compactMap{ $0.1.string }.compactMap{ URL(string: $0) },
                hours: hours,
                categories: categories,
                coordinate: coordinate,
                location: location,
                distance: nil,
                transactions: json["transactions"].compactMap{ $0.1.string }
            )
            
            return BusinessList(business: business)
        }

    }

}
