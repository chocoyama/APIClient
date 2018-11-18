//
//  Logger.swift
//  ChocoyamaAPIClient
//
//  Created by Takuya Yokoyama on 2018/11/18.
//  Copyright © 2018 chocoyama. All rights reserved.
//

import Foundation

class Logger {}

// MARK: Request
extension Logger {
    class func printSummary(from request: URLRequest?) {
        guard let request = request else {
            print("[DEBUG] [URLRequest] URLRequest is empty")
            return
        }
        
        printUrl(from: request)
        printHeader(from: request)
        printBody(from: request)
    }
    
    class func printUrl(from request: URLRequest) {
        if let url = request.url {
            print("[DEBUG] [URLRequest] request url is \(url)")
        } else {
            print("[DEBUG] [URLRequest] request url is empty")
        }
    }
    
    class func printHeader(from request: URLRequest) {
        if let headerFields = request.allHTTPHeaderFields, !headerFields.isEmpty {
            print("[DEBUG] request header is")
            headerFields.forEach { (key, value) in
                print("[DEBUG] [URLRequest] key = \(key), value = \(value)")
            }
        } else {
            print("[DEBUG] [URLRequest] request header is empty")
        }
    }
    
    class func printBody(from request: URLRequest) {
        if let body = request.httpBody, let bodyString = String(bytes: body, encoding: .utf8) {
            print("[DEBUG] [URLRequest] request body is \(bodyString)")
        } else {
            print("[DEBUG] [URLRequest] request body is empty")
        }
    }
}

// MARK: Response
extension Logger {
    class func printSummary(from response: URLResponse?) {
        guard let response = response else {
            print("[DEBUG] [URLRequest] URLResponse is empty")
            return
        }
        
        printUrl(from: response)
        printHeader(from: response)
        printStatusCode(from: response)
    }
    
    class func printUrl(from response: URLResponse) {
        if let url = response.url {
            print("[DEBUG] [URLResponse] request url is \(url)")
        } else {
            print("[DEBUG] [URLResponse] request url is empty")
        }
    }
    
    class func printHeader(from response: URLResponse) {
        if let urlResponse = response as? HTTPURLResponse, !urlResponse.allHeaderFields.isEmpty {
            print("[DEBUG] [URLResponse] request header is")
            urlResponse.allHeaderFields.forEach { (key, value) in
                print("[DEBUG] [URLResponse] key = \(key), value = \(value)")
            }
        } else {
            print("[DEBUG] [URLResponse] request header is empty")
        }
    }
    
    class func printStatusCode(from response: URLResponse) {
        if let urlResponse = response as? HTTPURLResponse {
            print("[DEBUG] [URLResponse] response status code is \(urlResponse.statusCode)")
        } else {
            print("[DEBUG] [URLResponse] response status code is empty")
        }
    }
}
