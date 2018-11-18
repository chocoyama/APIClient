//
//  HeaderField.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/01.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public struct Header {
    public enum Field: Equatable {
        case contentType(String)
        case contentLength(Int)
        case authorization(String)
        
        var tuple: (key: String, value: String) {
            switch self {
            case .contentType(let type): return (key: "Content-Type", value: type)
            case .contentLength(let length): return (key: "Content-Length", value: "\(length)")
            case .authorization(let token): return (key: "Authorization", value: token)
            }
        }
        
        /// key名が同じ場合は同一とみなす
        public static func ==(lhs: Header.Field, rhs: Header.Field) -> Bool {
            return lhs.tuple.key == rhs.tuple.key
        }
    }
    
    let fields: [Field]
    
    public init(fields: [Field] = []) {
        self.fields = fields
    }
    
    public func add(field: Field) -> Header {
        var next = self.fields
        next.append(field)
        return Header(fields: next)
    }
    
    /// 同一keyのフィールドが存在した場合は、引数に渡した方を優先させる 
    public func merge(header: Header) -> Header {
        var next = self.fields.filter{ !header.fields.contains($0) }
        header.fields.forEach{ next.append($0) }
        return Header(fields: next)
    }
}
