//
//  URLSessionManager.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2017/05/03.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

open class URLSessionManager {
    
    public typealias TransactionId = String
    
    class Transaction {
        let id: TransactionId
        var taskIdentifiers: [Int]
        
        init(id: TransactionId, taskIdentifiers: [Int]) {
            self.id = id
            self.taskIdentifiers = taskIdentifiers
        }
    }
    
    public static let shared = URLSessionManager()
    private init() {}
    
    fileprivate let session = URLSession(configuration: .default)
    fileprivate var transactions = [Transaction]()
    
    internal func createTask(with request: URLRequest,
                             transactionId: TransactionId,
                             completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        // Logger.printSummary(from: request)
        let task = session.dataTask(with: request) { (data, response, error) in
            // Logger.printSummary(from: response)
            completionHandler(data, response, error)
        }
        
        let taskId = task.taskIdentifier
        setTransaction(transactionId: transactionId, taskId: taskId)
        
        return task
    }
    
    internal func cancel(_ transactionId: String, completion: @escaping () -> Void) {
        let transaction = transactions.filter { $0.id == transactionId }.first
        guard let targetTransaction = transaction else { completion(); return }
        getTasks { (allTasks) in
            allTasks
                .filter{ targetTransaction.taskIdentifiers.contains($0.taskIdentifier) }
                .forEach{ $0.cancel() }
            completion()
        }
    }
    
    internal func publishTransactionId() -> String {
        let randInt = Int(arc4random_uniform(1000))
        let timestamp = Date().timeIntervalSince1970
        return "\(timestamp)\(randInt)"
    }
}


extension URLSessionManager {
    fileprivate func setTransaction(transactionId: TransactionId, taskId: Int) {
        synchronized(obj: self) { [weak self] in
            let runningTransaction = self?.transactions.filter { $0.id == transactionId }.first
            if let transaction = runningTransaction {
                transaction.taskIdentifiers.append(taskId)
            } else {
                let task = Transaction(id: transactionId, taskIdentifiers: [taskId])
                self?.transactions.append(task)
            }
        }
    }
    
    fileprivate func getTasks(completion: @escaping ([URLSessionTask]) -> Void) {
        session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            var allTasks = [URLSessionTask]()
            allTasks.append(contentsOf: dataTasks as [URLSessionTask])
            allTasks.append(contentsOf: uploadTasks as [URLSessionTask])
            allTasks.append(contentsOf: downloadTasks as [URLSessionTask])
            completion(allTasks)
        }
    }
}

extension URLSessionManager {
    private func synchronized(obj: AnyObject, closure: () -> Void) {
        objc_sync_enter(obj)
        closure()
        objc_sync_exit(obj)
    }
}
