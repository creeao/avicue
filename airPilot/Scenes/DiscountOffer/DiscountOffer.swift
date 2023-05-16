//
//  DiscountOffer.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum DiscountOffer {
    struct Input {
        let id: Int
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let offer: DiscountOfferModel
        }
        
        struct ViewModel {
            let offer: DiscountOfferModel
        }
    }
}

// MARK: Network
extension DiscountOffer {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = DiscountOfferModel?
        }
    }
}

// MARK: DataStore
extension DiscountOffer {
    struct DataStore {
        let id: Int
    }
}

// MARK: Scene maker
extension DiscountOffer {
    static func createScene(_ input: DiscountOffer.Input) -> ViewController {
        let viewController = DiscountOfferViewController()
        let presenter = DiscountOfferPresenter(viewController: viewController)
        let dataStore = DiscountOffer.DataStore(id: input.id)
        let interactor = DiscountOfferInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
