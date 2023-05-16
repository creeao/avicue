//
//  AviationOffer.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum AviationOffer {
    struct Input {
        let id: Int
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let offer: AviationOfferModel
        }
        
        struct ViewModel {
            let offer: AviationOfferModel
        }
    }
}

// MARK: Network
extension AviationOffer {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = AviationOfferModel?
        }
    }
}

// MARK: DataStore
extension AviationOffer {
    struct DataStore {
        let id: Int
    }
}

// MARK: Scene maker
extension AviationOffer {
    static func createScene(input: AviationOffer.Input) -> ViewController {
        let viewController = AviationOfferViewController()
        let presenter = AviationOfferPresenter(viewController: viewController)
        let dataStore = AviationOffer.DataStore(id: input.id)
        let interactor = AviationOfferInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
