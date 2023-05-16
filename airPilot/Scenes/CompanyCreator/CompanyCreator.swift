//
//  CompanyCreator.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum CompanyCreator {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum CreateCompany {
        struct Request {
            let name: String
            let headline: String?
            let website: String?
        }
    }
    
    enum Result {
        struct Response {
            let type: ResultViewType
        }
        
        struct ViewModel {
            let result: ResultModel
        }
    }
    
    enum PickerType {
        case avatar
        case background
    }
}

// MARK: Network
extension CompanyCreator {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
        
        enum CreateCompany {
            struct Request: Encodable {
                let name: String
                let headline: String?
                let website: String?
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension CompanyCreator {
    class DataStore {}
}

// MARK: Scene maker
extension CompanyCreator {
    static func createScene() -> ViewController {
        let viewController = CompanyCreatorViewController()
        let presenter = CompanyCreatorPresenter(viewController: viewController)
        let dataStore = CompanyCreator.DataStore()
        let interactor = CompanyCreatorInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
