//
//  AviationOffers.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum AviationOffers {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
}

// MARK: Network
extension AviationOffers {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension AviationOffers {
    class DataStore {}
}

// MARK: Scene maker
extension AviationOffers {
    static func createScene() -> ViewController {
        let viewController = AviationOffersViewController()
        let presenter = AviationOffersPresenter(viewController: viewController)
        let dataStore = AviationOffers.DataStore()
        let interactor = AviationOffersInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
