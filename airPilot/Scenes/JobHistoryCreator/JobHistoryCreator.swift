//
//  JobHistoryCreator.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum JobHistoryCreator {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum AddJobHistory {
        struct Request {
            let assignedTo: Int?
            let position: String?
            let startDate: String?
            let endDate: String?
        }
        
        struct Response {
            let type: ResultViewType
        }
        
        struct ViewModel {
            let result: ResultModel
        }
    }
}

// MARK: Network
extension JobHistoryCreator {
    enum Network {
        enum AddJobHistory {
            struct Request: Encodable {
                let assignedTo: Int?
                let position: String?
                let startDate: String?
                let endDate: String?
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension JobHistoryCreator {
    class DataStore {}
}

// MARK: Scene maker
extension JobHistoryCreator {
    static func createScene() -> ViewController {
        let viewController = JobHistoryCreatorViewController()
        let presenter = JobHistoryCreatorPresenter(viewController: viewController)
        let dataStore = JobHistoryCreator.DataStore()
        let interactor = JobHistoryCreatorInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
