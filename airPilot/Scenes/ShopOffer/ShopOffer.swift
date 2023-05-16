//
//  ShopOffer.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum ShopOffer {
    struct Input {
        let id: Int
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let offer: ShopOfferModel
        }
        
        struct ViewModel {
            let offer: ShopOfferModel
            let informations: [InformationModel]
        }
    }
    
    enum FavouriteAction {
        struct Request {
            let isFavourite: Bool
        }
    }
}

// MARK: Network
extension ShopOffer {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = ShopOfferModel?
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
extension ShopOffer {
    struct DataStore {
        let id: Int
    }
}

// MARK: Scene maker
extension ShopOffer {
    static func createScene(_ input: ShopOffer.Input) -> ViewController {
        let viewController = ShopOfferViewController()
        let presenter = ShopOfferPresenter(viewController: viewController)
        let dataStore = ShopOffer.DataStore(id: input.id)
        let interactor = ShopOfferInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
