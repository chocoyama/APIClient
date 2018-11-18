//
//  Item.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Item {
    public let code: String
    public let name: String
    public let url: URL
    public let condition: Condition
    public let headline: String?
    public let caption: String?
    public let abstract: String?
    public let additionals: [String]
    public let spAdditional: String?
    public let personId: Int?
    public let productCategoryIds: [Int]
    public let genreCategory: GenreCategory?
    public let isBargain: Bool?
    public let originalPriceEvidence: URL?
    public let description: String?
    public let releaseDate: Date?
    public let janCode: String?
    public let model: String?
    public let isbnCode: String?
    public let image: Image?
    public let relatedImages: [Image]
    public let exImage: ExImage?
    public let review: Review
    public let affiliateRate: Double?
    public let price: Price
    public let shipWeight: Double?
    public let saleLimit: Int?
    public let inventories: [Inventory]
    public let point: Point
    public let shipping: Shipping
    public let store: Store?
    public let order: Order?
    public let isAdult: Bool
    public let isCarbodySeller: Bool?
    public let availability: Availability
    public let brand: Brand?
}
