//
//  Parameter.swift
//  YahooAPIClient
//
//  Created by takyokoy on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Parameter<T: ParameterType> {
    private let dataSets: [DataSet]
    
    public init() {
        self.dataSets = []
    }
    
    public init(_ dataSets: [DataSet]) {
        self.dataSets = dataSets
    }
    
    public func add(_ parameterType: T) -> Parameter {
        var dataSets = self.dataSets.filter{ $0.key != parameterType.dataSet.key }
        dataSets.append(parameterType.dataSet)
        return Parameter(dataSets)
    }
    
    public func add(_ parameterTypes: [T]) -> Parameter {
        let keys = parameterTypes.map{ $0.dataSet.key }
        var dataSets = self.dataSets.filter{ !keys.contains($0.key) }
        dataSets.append(contentsOf: parameterTypes.map{ $0.dataSet })
        return Parameter(dataSets)
    }
    
    public func add(_ dataSets: [DataSet]) -> Parameter {
        let keys = dataSets.map{ $0.key }
        let baseDataSets = self.dataSets.filter{ !keys.contains($0.key) }
        return Parameter(baseDataSets + dataSets)
    }
    
    public func buildParameter(by method: Method, encode: Bool = false) -> String {
        let paramString = dataSets.map{
            if encode,
                let encodedKey = $0.key.rfc3986Encode(),
                let encodedValue = $0.value.rfc3986Encode() {
                return "\(encodedKey)=\(encodedValue)"
            } else {
                return "\($0.key)=\($0.value)"
            }
        }.joined(separator: "&")
        
        if paramString.isEmpty {
            return ""
        }
        
        switch method {
        case .get: return "?\(paramString)"
        case .post: return paramString
        }
    }
}

public protocol ParameterType {
    var dataSet: DataSet { get }
    associatedtype ResultType: APIResultType
}

public typealias DataSet = (key: String, value: String)
