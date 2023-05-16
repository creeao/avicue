//
//  ShopOfferCreator.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum ShopOfferCreator {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum CreateOffer {
        struct Request {
            let name: String?
            let category: Int
            let type: ShopOfferType
            let price: String?
            let currency: Currency?
            let text: String
            let assignedTo: Int?
            let images: [UIImage]?
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Result {
        struct Response {
            let type: ResultViewType
        }
        
        struct ViewModel {
            let result: ResultModel
        }
    }
}

// MARK: Network
extension ShopOfferCreator {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
        
        enum CreateOffer {
            struct Request: Encodable {
                let name: String?
                let category: Int
                let type: ShopOfferType
                let price: Decimal?
                let currency: Currency?
                let startDate: String?
                let endDate: String?
                let text: String
                let assignedTo: Int?
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension ShopOfferCreator {
    class DataStore {
        var request: Network.CreateOffer.Request? = nil
    }
}

// MARK: Scene maker
extension ShopOfferCreator {
    static func createScene() -> ViewController {
        let viewController = ShopOfferCreatorViewController()
        let presenter = ShopOfferCreatorPresenter(viewController: viewController)
        let dataStore = ShopOfferCreator.DataStore()
        let interactor = ShopOfferCreatorInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
