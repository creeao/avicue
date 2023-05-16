//
//  ShopOffers.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum ShopOffers {
    enum Content {
        struct Request {
            let category: Category?
        }
        
        struct Response {
            let offers: [ShopOfferModel]
        }
        
        struct ViewModel {
            let offers: [ShopOfferModel]
        }
    }
    
    enum SelectCategory {
        struct Request {
            let category: Category
        }
    }
    
    enum FavouriteAction {
        struct Request {
            let offerId: Int
            let isFavourite: Bool
        }
    }
}

// MARK: Network
extension ShopOffers {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [ShopOfferModel]?
        }
        
        enum FavouriteAction {
            struct Request: Encodable {
                let offerId: Int
                let isFavourite: Bool
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension ShopOffers {
    class DataStore {
        var selectedCategory: Category? = nil
        var offers: [ShopOfferModel] = []
    }
}

// MARK: Scene maker
extension ShopOffers {
    static func createScene() -> ViewController {
        let viewController = ShopOffersViewController()
        let presenter = ShopOffersPresenter(viewController: viewController)
        let dataStore = ShopOffers.DataStore()
        let interactor = ShopOffersInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
