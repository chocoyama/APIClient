//
//  Image.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import UIKit

public extension Item {
    public struct Image {
        public let id: String
        public let small: URL?
        public let medium: URL?
    }
    
    public struct ExImage {
        public let url: URL
        public let width: CGFloat
        public let height: CGFloat
    }
}

public extension Store {
    public struct Image {
        public let id: String
        public let medium: URL?
    }
}
