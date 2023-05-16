//
//  JobOffers.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum JobOffers {
    enum Content {
        struct Request {
            let category: Category?
        }
        
        struct Response {
            let offers: [JobOfferModel]
        }
        
        struct ViewModel {
            let offers: [JobOfferModel]
        }
    }
    
    enum SelectCategory {
        struct Request {
            let category: Category
        }
    }
}

// MARK: Network
extension JobOffers {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [JobOfferModel]?
        }
    }
}

// MARK: DataStore
extension JobOffers {
    class DataStore {
        var selectedCategory: Category? = nil
        var offers: [JobOfferModel] = []
    }
}

// MARK: Scene maker
extension JobOffers {
    static func createScene() -> ViewController {
        let viewController = JobOffersViewController()
        let presenter = JobOffersPresenter(viewController: viewController)
        let dataStore = JobOffers.DataStore()
        let interactor = JobOffersInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
