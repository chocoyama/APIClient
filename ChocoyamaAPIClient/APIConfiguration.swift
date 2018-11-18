//
//  Configuration.swift
//  YahooAPIClient
//
//  Created by takyokoy on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public protocol APIConfiguration {
    static var timeout: Double { get set }
    var requiredParameter: [DataSet] { get }
    var requiredHeaderFields: [Header.Field] { get }
}

