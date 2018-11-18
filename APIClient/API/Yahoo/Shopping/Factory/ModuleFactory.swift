//
//  ModuleFactory.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/27.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation
import SwiftyXMLParser

open class ModuleFactory {
    open func create(from moduleXml: XML.Accessor) -> Module {
        return Module(
            priceRanges: createPriceRanges(from: moduleXml),
            subCategories: createSubCategories(from: moduleXml),
            brands: createBrands(from: moduleXml),
            Spec: createSpecs(from: moduleXml)
        )
    }
    
    private func createPriceRanges(from moduleXml: XML.Accessor) -> [Module.PriceRange] {
        return moduleXml[["PriceRanges", "Price", "Range"]].compactMap {
            if let from = $0["From"].int, let to = $0["To"].int, let hits = $0["Hits"].int {
                return Module.PriceRange(from: from, to: to, hits: hits)
            } else {
                return nil
            }
        }
    }
    
    private func createSubCategories(from moduleXml: XML.Accessor) -> Module.SubCategories {
        let path = moduleXml[["Subcategories", "Path", "Category"]].compactMap { (xml) -> Module.SubCategories.Category? in
            if let id = xml["Id"].int, let name = xml["Name"].text {
                return Module.SubCategories.Category(id: id, name: name)
            } else {
                return nil
            }
        }
        
        let children = moduleXml[["Subcategories", "Children", "Child"]].compactMap { (xml) -> (Module.SubCategories.Category, Int)? in
            if let id = xml["Id"].int, let name = xml["Name"].text, let hits = xml["Hits"].int {
                return (Module.SubCategories.Category(id: id, name: name), hits)
            } else {
                return nil
            }
        }
        
        return Module.SubCategories(path: path, children: children)
    }
    
    private func createBrands(from moduleXml: XML.Accessor) -> Module.Brands {
        let map = { (xml: XML.Accessor) -> Module.Brands.Brand? in
            if let id = xml["Id"].int, let name = xml["Name"].text, let hits = xml["Hits"].int {
                return Module.Brands.Brand(id: id, name: name, hits: hits)
            } else {
                return nil
            }
        }
        
        return Module.Brands(
            path: moduleXml[["Brands", "Path", "Brand"]].compactMap(map),
            children: moduleXml[["Brands", "Children", "Child"]].compactMap(map)
        )
    }
    
    private func createSpecs(from moduleXml: XML.Accessor) -> [Module.Spec] {
        let optionsMap = { (xml: XML.Accessor) -> Module.Spec.Option? in
            if let id = xml["Id"].int, let name = xml["Name"].text, let hits = xml["Hits"].int {
                return Module.Spec.Option(id: id, name: name, hits: hits)
            } else {
                return nil
            }
        }
        
        let specs = moduleXml[["Specs", "Spec"]].compactMap { (xml) -> Module.Spec? in
            if let id = xml["Id"].int, let type = xml["Type"].text, let name = xml["Name"].text {
                let options = xml[["Options", "Option"]].compactMap(optionsMap)
                return Module.Spec(id: id, type: type, name: name, options: options)
            } else {
                return nil
            }
        }
        return specs
    }
}
