//
//  Module.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation

public struct Module {
    public let priceRanges: [PriceRange]
    public let subCategories: SubCategories
    public let brands: Brands
    public let Spec: [Spec]
    
    public struct PriceRange {
        public let from: Int
        public let to: Int
        public let hits: Int
    }
    
    public struct SubCategories {
        public let path: [Category]
        public let children: [(category: Category, hits: Int)]
        
        public struct Category {
            public let id: Int
            public let name: String
        }
    }
    
    public struct Brands {
        public let path: [Brand]
        public let children: [Brand]
        
        public struct Brand {
            public let id: Int
            public let name: String
            public let hits: Int
        }
    }
    
    public struct Spec {
        public let id: Int
        public let type: String
        public let name: String
        public let options: [Option]
        
        public struct Option {
            public let id: Int
            public let name: String
            public let hits: Int
        }
    }
}
