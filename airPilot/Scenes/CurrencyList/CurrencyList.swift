//
//  CurrencyList.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum CurrencyList {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
}

// MARK: Network
extension CurrencyList {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension CurrencyList {
    class DataStore {}
}

// MARK: Scene maker
extension CurrencyList {
    static func createScene() -> ViewController {
        let viewController = CurrencyListViewController()
        let presenter = CurrencyListPresenter(viewController: viewController)
        let dataStore = CurrencyList.DataStore()
        let interactor = CurrencyListInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
