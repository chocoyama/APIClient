//
//  AuthorizationDataCacheStrategy.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/03.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

protocol AuthorizationDataCacheStrategy {
    func getValidData(for kind: Authorization.Kind) -> Authorization.Data?
    mutating func store(authorizationData: Authorization.Data, kind: Authorization.Kind)
}

struct AuthorizationDataMemoryCacheStrategy: AuthorizationDataCacheStrategy {
    private var cachedData: [Authorization.Kind: Authorization.Data] = [:]
    
    func getValidData(for kind: Authorization.Kind) -> Authorization.Data? {
        if let authorizationData = cachedData[kind], authorizationData.isExpires == false {
            return authorizationData
        } else {
            return nil
        }
    }
    
    mutating func store(authorizationData: Authorization.Data, kind: Authorization.Kind) {
        cachedData[kind] = authorizationData
    }
}

struct AuthorizationDataUserDefaultsCacheStrategy: AuthorizationDataCacheStrategy {
    enum KeyType: String {
        case accessToken = "accessToken"
        case tokenType   = "tokenType"
        case expires     = "expires"
        
        static let prefix = "jp.co.chocoyama.apiClient.authorization"
    }
    
    private func createKey(by kind: Authorization.Kind, type: KeyType) -> String {
        return "\(KeyType.prefix).\(kind.rawValue).\(type.rawValue)"
    }
    
    func getValidData(for kind: Authorization.Kind) -> Authorization.Data? {
        let unixTime = UserDefaults.standard.double(forKey: createKey(by: kind, type: .expires))
        guard let accessToken = UserDefaults.standard.string(forKey: createKey(by: kind, type: .accessToken)),
            let tokenType = UserDefaults.standard.string(forKey: createKey(by: kind, type: .tokenType)),
            unixTime != 0
            else {
                return nil
        }
        let expires = Date(timeIntervalSince1970: unixTime)
        
        let authorizationData = Authorization.Data(accessToken: accessToken, tokenType: tokenType, expires: expires)
        if authorizationData.isExpires {
            return nil
        } else {
            return authorizationData
        }
    }
    
    func store(authorizationData: Authorization.Data, kind: Authorization.Kind) {
        UserDefaults.standard.set(authorizationData.accessToken,                   forKey: createKey(by: kind, type: .accessToken))
        UserDefaults.standard.set(authorizationData.tokenType,                     forKey: createKey(by: kind, type: .tokenType))
        UserDefaults.standard.set(authorizationData.expires.timeIntervalSince1970, forKey: createKey(by: kind, type: .expires))
        UserDefaults.standard.synchronize()
    }
}
