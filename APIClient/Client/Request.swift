//
//  Request.swift
//  YahooAPIClient
//
//  Created by takyokoy on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Request<T: ParameterType> {
    public let endpoint: APIEndpoint
    public let parameter: Parameter<T>
    public let method: Method
    public var header = Header()
    public let configuration: APIConfiguration
    
    public let url: URL
    public let body: String?
    public let bodyData: Data?
    
    public init(endpoint: APIEndpoint, parameter: Parameter<T>) {
        self.endpoint = endpoint
        self.parameter = parameter
        self.method = endpoint.method
        self.configuration = type(of: endpoint.self).configuration
        
        switch method {
        case .get:
            let urlString = endpoint.urlString + parameter.add(configuration.requiredParameter).buildParameter(by: .get, encode: true)
            self.url = URL(string: urlString)!
            
            self.body = nil
            self.bodyData = nil
            
            self.header = header.add(field: .contentType("application/x-www-form-urlencoded"))
            configuration.requiredHeaderFields.forEach {
                self.header = self.header.add(field: $0)
            }
            
        case .post:
            let urlString = endpoint.urlString
            self.url = URL(string: urlString)!
            
            self.body = parameter.add(configuration.requiredParameter).buildParameter(by: .post, encode: true)
            self.bodyData = body?.data(using: .utf8)
            
            self.header = header
                .add(field: .contentType("application/x-www-form-urlencoded"))
                .add(field: .contentLength(bodyData?.count ?? 0))
            configuration.requiredHeaderFields.forEach {
                self.header = self.header.add(field: $0)
            }
        }
    }
}

extension Request {
    public func create() -> URLRequest {
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: type(of: configuration.self).timeout
        )
        request.httpMethod = method.rawValue
        
        switch method {
        case .get: break
        case .post: request.httpBody = bodyData
        }
        
        header.fields.map{ $0.tuple }.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return request
    }
}

public enum Method: String {
    case get  = "GET"
    case post = "POST"
}
