//
//  JobOffer.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum JobOffer {
    struct Input {
        let id: Int
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let offer: JobOfferModel
            let informations: [InformationModel]
            let description: String
        }
        
        struct ViewModel {
            let offer: JobOfferModel
            let informations: [InformationModel]
            let description: String
        }
    }
}

// MARK: Network
extension JobOffer {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = JobOfferModel?
        }
    }
}

// MARK: DataStore
extension JobOffer {
    struct DataStore {
        let id: Int
    }
}

// MARK: Scene maker
extension JobOffer {
    static func createScene(_ input: JobOffer.Input) -> ViewController {
        let viewController = JobOfferViewController()
        let presenter = JobOfferPresenter(viewController: viewController)
        let dataStore = JobOffer.DataStore(id: input.id)
        let interactor = JobOfferInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
