//
//  Store.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Store {
    public let id: String
    public let name: String
    public let url: URL
    public let sellerType: SellerType?
    public let toolType: ToolType?
    public let isBestStore: Bool?
    public let review: Review
    public let image: Image?
    public let point: Point
    public let inventoryMessage: String?
    public let sameDayDelivery: Area?
    public let expressDelivery: Area?
    public let paymentMethods: [PaymentMethod]
}
