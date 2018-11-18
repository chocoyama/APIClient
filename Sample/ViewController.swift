//
//  ViewController.swift
//  Sample
//
//  Created by takyokoy on 2017/01/04.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import UIKit
import ChocoyamaAPIClient

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.configure()
        yshoppingItemLookup()
    }
    
    private func yshoppingItemSearch(with parameter: Parameter<API.YahooShopping.Parameter.ItemSearch>) {
        let request = Request(endpoint: API.YahooShopping.Endpoint.itemSearch,
                              parameter: parameter)
        
        Client.send(request) { (result) in
            switch result {
            case .success(let result): print(result)
            case .failure(let error): print(error)
            }
        }
    }
    
    private func yshoppingItemLookup() {
        // 1. set parameters
        let parameter = Parameter<API.YahooShopping.Parameter.ItemLookup>().add([
            .itemId("yamatorice_008023-2")
        ])
        
        // 2. create request
        let request = Request(endpoint: API.YahooShopping.Endpoint.itemLookup,
                              parameter: parameter)
        
        // 3. execute request
        Client.send(request) { (result) in
            switch result {
            case .success(let result): print(result)
            case .failure(let error): print(error)
            }
        }
    }
    
    private func rakutenBookSearch(with parameter: Parameter<API.RakutenBooks.Parameter.Search>) {
        let request = Request(endpoint: API.RakutenBooks.Endpoint.bookSearch,
                              parameter: parameter)
        
        Client.send(request) { (result) in
            switch result {
            case .success(let result): print(result)
            case .failure(let error): print(error)
            }
        }
    }
    
    private func yelpSearch() {
        // 1. set parameters
        let parameter = Parameter<API.Yelp.Parameter.Search>().add([
            .location("新宿"),
            .locale(.japan),
            .term(.food),
            .radius(meter: 500)
        ])
        
        // 2. create request
        let request = Request(endpoint: API.Yelp.Endpoint.search,
                              parameter: parameter)
        
        // 3. execute reqeuest
        Client.send(request) { (result) in
            switch result {
            case .success(let result): print(result)
            case .failure(let error): print(error)
            }
        }
    }
    
    private func yelpBusiness(with businessId: String) {
        let request = Request(endpoint: API.Yelp.Endpoint.business(id: businessId),
                              parameter: Parameter<API.Yelp.Parameter.Business>())
        
        Client.send(request) { (result) in
            switch result {
            case .success(let result): print(result)
            case .failure(let error): print(error)
            }
        }
    }
    
}
