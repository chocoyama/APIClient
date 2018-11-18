//
//  Endpoint.swift
//  YahooAPIClient
//
//  Created by takyokoy on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public protocol APIEndpoint {
    static var configuration: APIConfiguration { get }
    var urlString: String { get }
    var method: Method { get }
    var authorization: Authorization.Kind? { get }
}


