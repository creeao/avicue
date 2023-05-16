//
//  Favourites.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Favourites {
    struct Input {
        let type: Favourites.FavoruitesType
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let shopOffers: [ShopOfferModel]
        }
        
        struct ViewModel {
            let shopOffers: [ShopOfferModel]
        }
    }
    
    enum FavouriteAction {
        struct Request {
            let offerId: Int
            let isFavourite: Bool
        }
    }
    
    enum FavoruitesType {
        case shopOffers
    }
}

// MARK: Network
extension Favourites {
    enum Network {
        enum GetShopOffers {
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
extension Favourites {
    class DataStore {
        let type: Favourites.FavoruitesType
        
        init(type: Favourites.FavoruitesType) {
            self.type = type
        }
    }
}

// MARK: Scene maker
extension Favourites {
    static func createScene(_ input: Favourites.Input) -> ViewController {
        let viewController = FavouritesViewController()
        let presenter = FavouritesPresenter(viewController: viewController)
        let dataStore = Favourites.DataStore(type: input.type)
        let interactor = FavouritesInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
