//
//  Business.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/01.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public struct Business {
    public let id: String
    public let name: String
    public let imageUrl: URL?
    public let isClaimed: Bool?
    public let isClosed: Bool?
    public let url: URL?
    public let price: String?
    public let rating: Double?
    public let reviewCount: Int?
    public let phone: String?
    public let displayPhone: String?
    public let photos: [URL]
    public let hours: [Hour]
    public let categories: [Category]
    public let coordinate: Coordinate?
    public let location: Location?
    public let distance: Double?
    public let transactions: [String]
    
    public struct Category {
        public let alias: String // 検索とかに使う場合はこちらを利用する
        public let title: String // ユーザーへの表示用途ではこちらを利用する
    }
    
    public struct Location {
        public let city: String
        public let country: String
        public let address1: String
        public let address2: String
        public let address3: String
        public let displayAddress: [String]
        public let state: String
        public let zipCode: String
        public let crossStreet: String
    }
}

extension Business: Equatable {
    public static func ==(lhs: Business, rhs: Business) -> Bool {
        return lhs.id == rhs.id
    }
}
