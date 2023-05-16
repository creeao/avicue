//
//  JobOfferCreator.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum JobOfferCreator {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum CreateOffer {
        struct Request {
            let position: String
            let category: Int
            let minSalary: String?
            let maxSalary: String?
            let currency: Currency?
            let text: String
            let assignedTo: Int?
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
extension JobOfferCreator {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
        
        enum CreateOffer {
            struct Request: Encodable {
                let position: String
                let category: Int
                let minSalary: Double?
                let maxSalary: Double?
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
extension JobOfferCreator {
    class DataStore {
        var createOfferRequest: Network.CreateOffer.Request? = nil
    }
}

// MARK: Scene maker
extension JobOfferCreator {
    static func createScene() -> ViewController {
        let viewController = JobOfferCreatorViewController()
        let presenter = JobOfferCreatorPresenter(viewController: viewController)
        let dataStore = JobOfferCreator.DataStore()
        let interactor = JobOfferCreatorInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
