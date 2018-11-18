//
//  ItemFactory.swift
//  YahooAPIClient
//
//  Created by chocoyama on 2016/11/26.
//  Copyright © 2016年 chocoyama. All rights reserved.
//

import Foundation
import SwiftyXMLParser

open class ItemFactory {
    
    open func createFrom(itemSearchXml: XML.Accessor) -> [Item] {
        return itemSearchXml[["ResultSet", "Result", "Hit"]].compactMap {
            let wrappedUrl = $0["Url"].text.flatMap{ URL.init(string: $0) }
            guard let code = $0["Code"].text,
                let name = $0["Name"].text,
                let url = wrappedUrl,
                let price = createPrice(from: $0) else {
                    return nil
            }
            
            return Item(
                code: code,
                name: name,
                url: url,
                condition: $0["Condition"].text.flatMap{ Condition.init(string: $0) } ?? Condition.new,
                headline: $0["Headline"].text,
                caption: nil, // mark
                abstract: nil, // mark
                additionals: [], // mark
                spAdditional: nil, // mark
                personId: $0["PersonId"].int, // mark
                productCategoryIds: $0["ProductId"].compactMap{ $0.int }, // mark
                genreCategory: createGenreCategory(from: $0), // mark
                isBargain: nil, // mark
                originalPriceEvidence: nil, // mark
                description: $0["Description"].text,
                releaseDate: $0["ReleaseDate"].text?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ"),
                janCode: $0["JanCode"].text,
                model: $0["Model"].text, // mark
                isbnCode: $0["IsbnCode"].text, // mark
                image: createImage(from: $0["Image"]),
                relatedImages: [], // mark
                exImage: nil, // mark
                review: Item.Review(
                    rate: $0[["Review", "Rate"]].double ?? 0.0,
                    count: $0[["Review", "Count"]].int ?? 0,
                    url: $0[["Review", "Url"]].text.flatMap{ URL.init(string: $0) }
                ),
                affiliateRate: $0[["Affiliate", "Rate"]].double, // mark
                price: price,
                shipWeight: nil, // mark
                saleLimit: nil, // mark
                inventories: [], // mark
                point: Item.Point(
                    amount: $0[["Point", "Amount"]].int ?? 0,
                    times: $0[["Point", "Times"]].int ?? 0,
                    premiumAmount: $0[["Point", "PremiumAmount"]].int ?? 0,
                    premiumTimes: $0[["Point", "PremiumTimes"]].int ?? 0,
                    premiumCpAmount: nil, // mark
                    premiumCpTimes: nil, // mark
                    appCpAmount: nil, // mark
                    appCpTimes: nil, // mark
                    preAppCpAmount: nil, // mark
                    preAppCpTimes: nil // mark
                ),
                shipping: Shipping(
                    code: $0[["Shipping", "Code"]].text.flatMap{ Shipping.Code.init(string: $0) } ?? .none,
                    name: $0[["Shipping", "Name"]].text ?? ""
                ),
                store: createItemSearchStore(from: $0["Store"]), // mark
                order: nil, // mark
                isAdult: $0["IsAdult"].int == 1,
                isCarbodySeller: nil,
                availability: $0["Availability"].text.flatMap{ Availability.init(string: $0) } ?? .outofstock,
                brand: createBrand(from: $0)
            )

        }
    }
    
    open func createFrom(itemLookupXml: XML.Accessor, itemIds: [String]) -> [Item] {
        
        return itemLookupXml[["ResultSet", "Result", "Hit"]].compactMap {
            let index = $0.attributes["index"].flatMap{ Int($0) }.flatMap{ $0 - 1 } ?? 0
            let code = $0["Code"].text ?? itemIds[index]
            let wrappedUrl = $0["Url"].text.flatMap{ URL.init(string: $0) }
            guard let name = $0["Name"].text,
                let url = wrappedUrl,
                let price = createPrice(from: $0) else {
                    return nil
            }
            
            return Item(
                code: code,
                name: name,
                url: url,
                condition: $0["Condition"].text.flatMap{ Condition.init(string: $0) } ?? Condition.new,
                headline: $0["Headline"].text,
                caption: $0["Caption"].text,
                abstract: $0["Abstract"].text,
                additionals: [
                    $0["Additional1"].text,
                    $0["Additional2"].text,
                    $0["Additional3"].text
                    ].compactMap{ $0 },
                spAdditional: $0["SpAdditional"].text,
                personId: nil,
                productCategoryIds: $0[["ProductCategory", "ID"]].compactMap{ $0.text }.compactMap{ Int($0) },
                genreCategory: nil,
                isBargain: $0["IsBargain"].bool,
                originalPriceEvidence: $0["OriginalPriceEvidence"].text.flatMap{ URL.init(string: $0) },
                description: $0["Description"].text,
                releaseDate: $0["ReleaseDate"].text?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ"),
                janCode: $0["JanCode"].text,
                model: nil,
                isbnCode: nil,
                image: createImage(from: $0["Image"]),
                relatedImages: $0["RelatedImages", "Image"].compactMap{ createImage(from: $0) },
                exImage: createExImage(from: $0["ExImage"]),
                review: Item.Review(
                    rate: $0[["Review", "Rate"]].double ?? 0.0,
                    count: $0[["Review", "Count"]].int ?? 0,
                    url: $0[["Review", "Url"]].text.flatMap{ URL.init(string: $0) }
                ),
                affiliateRate: nil,
                price: price,
                shipWeight: $0["ShipWeight"].double,
                saleLimit: $0["SaleLimit"].int,
                inventories: $0["Inventories", "Inventory"].compactMap{ createInventory(from: $0) },
                point: Item.Point(
                    amount: $0[["Point", "Amount"]].int ?? 0,
                    times: $0[["Point", "Times"]].int ?? 0,
                    premiumAmount: $0[["Point", "PremiumAmount"]].int ?? 0,
                    premiumTimes: $0[["Point", "PremiumTimes"]].int ?? 0,
                    premiumCpAmount: $0[["Point", "PremiumCpAmount"]].int,
                    premiumCpTimes: $0[["Point", "PremiumCpTimes"]].int,
                    appCpAmount: $0[["Point", "AppCpAmount"]].int,
                    appCpTimes: $0[["Point", "AppCpTimes"]].int,
                    preAppCpAmount: $0[["Point", "PreAppCpAmount"]].int,
                    preAppCpTimes: $0[["Point", "PreAppCpTimes"]].int
                ),
                shipping: Shipping(
                    code: $0[["Shipping", "Code"]].text.flatMap{ Shipping.Code.init(string: $0) } ?? .none,
                    name: $0[["Shipping", "Name"]].text ?? ""
                ),
                store: createItemLookupStore(from: $0),
                order: createOrder(from: $0["Order"]),
                isAdult: $0["IsAdult"].int == 1,
                isCarbodySeller: $0["IsCarBodySeller"].int == 1,
                availability: $0["Availability"].text.flatMap{ Availability.init(string: $0) } ?? .outofstock,
                brand: nil
            )
        }
    }
    
    private func createImage(from imageXml: XML.Accessor) -> Item.Image? {
        guard let imageId = imageXml["Id"].text else { return nil }
        return Item.Image(
            id: imageId,
            small: imageXml["Small"].text.flatMap{ URL.init(string: $0) },
            medium: imageXml["Medium"].text.flatMap{ URL.init(string: $0) }
        )
    }
    
    private func createExImage(from exImageXml: XML.Accessor) -> Item.ExImage? {
        let url = exImageXml["Url"].text.flatMap{ URL.init(string: $0) }
        let width = exImageXml["Width"].double
        let height = exImageXml["Height"].double
        if let unwrappedUrl = url, let unwrappedWidth = width, let unwrappedHeight = height {
            return Item.ExImage(url: unwrappedUrl, width: CGFloat(unwrappedWidth), height: CGFloat(unwrappedHeight))
        } else {
            return nil
        }
    }
    
    private func createPrice(from hitXml: XML.Accessor) -> Price? {
        let wrappedPrice = hitXml["Price"].text.flatMap{ Int($0) }
        guard let price = wrappedPrice else { return nil }
        return Price(
            price: price,
            currency: hitXml["Price"].attributes["currency"].flatMap{ $0 },
            label: Price.Label(
                taxIncluded: hitXml["PriceLabel"].attributes["taxIncluded"].flatMap{ $0 }.map{ $0 == "true" },
                fixed: hitXml[["PriceLabel", "FixedPrice"]].int,
                default: hitXml[["PriceLabel", "DefaultPrice"]].int,
                sale: hitXml[["PriceLabel", "SalePrice"]].int,
                baseFixed: hitXml[["PriceLabel", "BaseFixedPrice"]].int,
                baseDefault: hitXml[["PriceLabel", "BaseDefaultPrice"]].int,
                baseSale: hitXml[["PriceLabel", "BaseSalePrice"]].int,
                periodStart: hitXml[["PriceLabel", "PeriodStart"]].text?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ"),
                periodEnd: hitXml[["PriceLabel", "PeriodEnd"]].text?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ")
            )
        )
    }
    
    private func createInventory(from inventoryXml: XML.Accessor) -> Inventory? {
        let subcode = inventoryXml["SubCode"].text
        let availability = inventoryXml["Availability"].text.flatMap{ Inventory.Availability.init(string: $0) }
        guard let unwrappedSubcode = subcode, let unwrappedAvailability = availability else { return nil }
        
        let options = inventoryXml[["Order", "Option"]].reduce(Array<Inventory.Option>()) { (total, xml) -> [Inventory.Option] in
            var options = total
            if let name = xml["Name"].text, let value = xml["Value"].text {
                options.append(Inventory.Option(name: name, value: value))
            }
            return options
        }
        
        return Inventory(
            subcode: unwrappedSubcode,
            options: options,
            quantity: inventoryXml["Quantity"].int,
            allowOverdraft: inventoryXml["AllowOverdraft"].bool ?? false,
            availability: unwrappedAvailability
        )
    }
    
    private func createItemSearchStore(from storeXml: XML.Accessor) -> Store? {
        let id = storeXml["Id"].text
        let name = storeXml["Name"].text
        let url = storeXml["Url"].text.flatMap{ URL.init(string: $0) }
        guard let unwrappedId = id, let unwrappedName = name, let unwrappedUrl = url else {
            return nil
        }
        
        let review = Store.Review(
            rate: storeXml[["Ratings", "Rate"]].double ?? 0.0,
            count: storeXml[["Ratings", "Count"]].int ?? 0,
            total: storeXml[["Ratings", "Total"]].int ?? 0,
            detailRate: storeXml[["Ratings", "DetailRate"]].double ?? 0.0
        )
        let image = storeXml[["Image", "Id"]].text.flatMap {
            return Store.Image(
                id: $0,
                medium: storeXml[["Image", "Medium"]].text.flatMap{ URL.init(string: $0) }
            )
        }
        let point = Store.Point(
            grant: storeXml[["Point", "Grant"]].bool ?? false,
            accept: storeXml[["Point", "Accept"]].bool ?? false
        )
        
        let paymentMethods = storeXml[["Payment", "Method"]].compactMap { (xml) -> PaymentMethod? in
            if let code = xml["Code"].int, let name = xml["Name"].text {
                return PaymentMethod(code: code, name: name)
            } else {
                return nil
            }
        }
        
        return Store(
            id: unwrappedId,
            name: unwrappedName,
            url: unwrappedUrl,
            sellerType: storeXml["SellerType"].text.flatMap{ SellerType.init(string: $0) },
            toolType: storeXml["ToolType"].text.flatMap{ ToolType.init(string: $0) },
            isBestStore: storeXml["IsBestStore"].bool,
            review: review,
            image: image,
            point: point,
            inventoryMessage: storeXml["InventoryMessage"].text,
            sameDayDelivery: createArea(from: storeXml["SameDayDelivery"]),
            expressDelivery: createArea(from: storeXml["ExpressDelivery"]),
            paymentMethods: paymentMethods
        )
    }
    
    private func createItemLookupStore(from hitXml: XML.Accessor) -> Store? {
        let id = hitXml[["Store", "Id"]].text
        let name = hitXml[["Store", "Name"]].text
        let url = hitXml[["Store", "Url"]].text.flatMap{ URL.init(string: $0) }
        guard let unwrappedId = id, let unwrappedName = name, let unwrappedUrl = url else {
            return nil
        }
        
        let review = Store.Review(
            rate: hitXml[["Store", "Ratings", "Rate"]].double ?? 0.0,
            count: hitXml[["Store", "Ratings", "Count"]].int ?? 0,
            total: hitXml[["Store", "Ratings", "Total"]].int ?? 0,
            detailRate: hitXml[["Store", "Ratings", "DetailRate"]].double ?? 0.0
        )
        let image = hitXml[["Store", "Image", "Id"]].text.flatMap {
            return Store.Image(
                id: $0,
                medium: hitXml[["Store", "Image", "Medium"]].text.flatMap{ URL.init(string: $0) }
            )
        }
        let point = Store.Point(
            grant: hitXml[["Store", "Point", "Grant"]].bool ?? false,
            accept: hitXml[["Store", "Point", "Accept"]].bool ?? false
        )
        
        let paymentMethods = hitXml[["Payment", "Method"]].compactMap({ (xml) -> PaymentMethod? in
            guard let code = xml["Code"].int, let name = xml["Name"].text else { return nil }
            return PaymentMethod(code: code, name: name)
        })
        
        return Store(
            id: unwrappedId,
            name: unwrappedName,
            url: unwrappedUrl,
            sellerType: hitXml[["Store", "SellerType"]].text.flatMap{ SellerType.init(string: $0) },
            toolType: hitXml[["Store", "ToolType"]].text.flatMap{ ToolType.init(string: $0) },
            isBestStore: nil,
            review: review,
            image: image,
            point: point,
            inventoryMessage: hitXml[["Store", "InventoryMessage"]].text,
            sameDayDelivery: createArea(from: hitXml[["Store", "SameDayDelivery"]]),
            expressDelivery: createArea(from: hitXml[["Store", "ExpressDelivery"]]),
            paymentMethods: paymentMethods
        )
    }
    
    private func createArea(from deliveryXml: XML.Accessor) -> Area? {
        let code = deliveryXml[["Areas", "Area", "Code"]].text.flatMap{ AreaCode.init(string: $0) }
        let deadline = deliveryXml["Deadline"].int
        guard let unwrappedCode = code, let unwrappedDeadline = deadline else {
            return nil
        }
        
        let prefectures = deliveryXml[["Areas", "Area", "Prefectures", "Prefecture"]].reduce(Array<Area.Prefecture>()) { (total, xml) -> [Area.Prefecture] in
            var prefectures = total
            
            let code = xml["Code"].text.flatMap{ PrefectureCode.init(string: $0) }
            let name = xml["Name"].text
            if let unwrappedCode = code {
                prefectures.append(Area.Prefecture(code: unwrappedCode, name: name))
            }
            return prefectures
        }
        
        return Area(
            code: unwrappedCode,
            name: deliveryXml[["Areas", "Area", "Name"]].text,
            prefectures: prefectures,
            deadline: unwrappedDeadline,
            condition: deliveryXml["Conditions"].text
        )
    }
    
    private func createOrder(from orderXml: XML.Accessor) -> Order {
        func createSelectOption(from optionXml: XML.Accessor) -> Order.SelectOption? {
            guard let name = optionXml["Name"].text else { return nil }
            let values = optionXml[["Values", "Select"]].compactMap{ $0["Value"].text }
            return Order.SelectOption(name: name, values: values)
        }
        
        func createInputOption(from optionXml: XML.Accessor) -> Order.InputOption? {
            guard let name = optionXml["Name"].text else { return nil }
            let length = optionXml.attributes["length"].flatMap{ Int($0) }
            return Order.InputOption(name: name, length: length)
        }
        
        var selectOptions: [Order.SelectOption] = []
        var inputOptions: [Order.InputOption] = []
        for option in orderXml["Option"] {
            guard let optionType = option.attributes["type"] else { continue }
            if let selectOption = createSelectOption(from: option), optionType == "select" {
                selectOptions.append(selectOption)
            }
            if let inputOption = createInputOption(from: option), optionType == "input" {
                inputOptions.append(inputOption)
            }
        }
        return Order(selectOption: selectOptions, inputOption: inputOptions)
    }
    
    private func createGenreCategory(from hitXml: XML.Accessor) -> GenreCategory? {
        if let id = hitXml[["Category", "Current", "Id"]].int, let name = hitXml[["Category", "Current", "Name"]].text {
            return GenreCategory(
                id: id,
                name: name,
                path: hitXml[["CategoryIdPath", "Category"]].compactMap{ $0["Id"].int }
            )
        } else {
            return nil
        }
    }
    
    private func createBrand(from hitXml: XML.Accessor) -> Brand? {
        if let name = hitXml[["Brands", "Name"]].text {
            return Brand(
                name: name,
                idPath: hitXml[["Brands", "Path", "Brand"]].compactMap{ $0["Id"].int }
            )
        } else {
            return nil
        }
    }
}


