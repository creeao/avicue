//
//  DiscountOffers.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum DiscountOffers {
    enum Content {
        struct Request {}
        
        struct Response {
            let offers: [DiscountOfferModel]
        }
        
        struct ViewModel {
            let offers: [DiscountOfferModel]
        }
    }
}

// MARK: Network
extension DiscountOffers {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [DiscountOfferModel]?
        }
    }
}

// MARK: DataStore
extension DiscountOffers {
    class DataStore {
        var offers: [DiscountOfferModel] = []
    }
}

// MARK: Scene maker
extension DiscountOffers {
    static func createScene() -> ViewController {
        let viewController = DiscountOffersViewController()
        let presenter = DiscountOffersPresenter(viewController: viewController)
        let dataStore = DiscountOffers.DataStore()
        let interactor = DiscountOffersInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
