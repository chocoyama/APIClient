//
//  Client.swift
//  YahooAPIClient
//
//  Created by takyokoy on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

open class Client {
    @discardableResult
    public class func send<T>(_ request: Request<T>,
                              handler: @escaping (_ result: Result<T.ResultType>) -> Void) -> URLSessionManager.TransactionId {
        let transactionId = URLSessionManager.shared.publishTransactionId()
        
        if let kind = request.endpoint.authorization {
            Client.executeAfterAuthentication(kind: kind, request: request, transactionId: transactionId) { (result) in
                DispatchQueue.main.async { handler(result) }
            }
        } else {
            Client.execute(request, transactionId: transactionId) { (result) in
                DispatchQueue.main.async { handler(result) }
            }
        }
        
        return transactionId
    }
    
    public class func cancel(_ transactionId: URLSessionManager.TransactionId) {
        URLSessionManager.shared.cancel(transactionId) {}
    }
}

extension Client {
    fileprivate class func execute<T>(_ request: Request<T>,
                                      transactionId: URLSessionManager.TransactionId,
                                      handler: @escaping (_ result: Result<T.ResultType>) -> Void) {
        createTask(with: request, transactionId: transactionId, handler: handler).resume()
    }
    
    fileprivate class func executeAfterAuthentication<T>(kind: Authorization.Kind,
                                                         request: Request<T>,
                                                         transactionId: URLSessionManager.TransactionId,
                                                         handler: @escaping (_ result: Result<T.ResultType>) -> Void) {
        authorize (kind, request: request, transactionId: transactionId) { (authHeader) in
            guard let authHeader = authHeader else {
                handler(.failure(APIError.authenticationFailed))
                return
            }
            
            var authRequest = request
            authRequest.header = authRequest.header.merge(header: authHeader)
            self.execute(authRequest, transactionId: transactionId, handler: handler)
        }
    }
}

extension Client {
    internal class func authorize<T>(_ kind: Authorization.Kind,
                                     request: Request<T>,
                                     transactionId: URLSessionManager.TransactionId,
                                     completion: @escaping (_ authHeader: Header?) -> Void) {
        if let validAuthorizationData = Authorization.DataStore.shared.getValidData(for: kind) {
            let authHeader = validAuthorizationData.toHttpHeader()
            completion(authHeader)
            return
        }
        
        execute(request, transactionId: transactionId, handler: { (result) in
            switch result {
            case .success(let result):
                if let authResult = result as? AuthorizationAPIResultType {
                    Authorization.DataStore.shared.store(authorizationData: authResult.authorizationData, kind: kind)
                    let authHeader = authResult.authorizationData.toHttpHeader()
                    completion(authHeader)
                } else {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        })
    }
}


extension Client {
    fileprivate class func createTask<T>(with request: Request<T>,
                                         transactionId: URLSessionManager.TransactionId,
                                         handler: @escaping (_ result: Result<T.ResultType>) -> Void) -> URLSessionTask {
        return URLSessionManager.shared.createTask(with: request.create(), transactionId: transactionId) { (data, response, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            guard let data = data, let result = T.ResultType.decode(data: data) else {
                handler(.failure(APIError.nodata))
                return
            }
            
            handler(.success(result))
        }
    }
}

