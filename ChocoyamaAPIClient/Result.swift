//
//  Result.swift
//  YahooAPIClient
//
//  Created by takyokoy on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public enum Result<T: APIResultType> {
    case success(T)
    case failure(Error)
}

public protocol APIResultType {
    static func decode(data: Data) -> Self?
}

public protocol AuthorizationAPIResultType {
    var authorizationData: Authorization.Data { get }
}

public enum APIError: Error {
    case nodata
    case authenticationFailed
}
