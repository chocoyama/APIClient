//
//  PaymentType.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public enum PaymentType: String {
    case yahooWallet = "yahoowallet"
    case credit = "creditcard"
    case cashOnDelivery = "cod"
    case bankTransfer = "banktransfer"
    case postalTransfer = "pmo"
    case mobileSuica = "mobilesuica"
    case payeasy = "payeasy"
    case yahooMoney = "yahoomoney"
    case convenience = "convenience"
}
