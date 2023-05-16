//
//  Companies.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Companies {
    enum Content {
        struct Request {}
        
        struct Response {
            let companies: [CompanyModel]
        }
        
        struct ViewModel {
            let companies: [CompanyModel]
        }
    }
}

// MARK: Network
extension Companies {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [CompanyModel]?
        }
    }
}

// MARK: DataStore
extension Companies {
    class DataStore {
        var companies: [CompanyModel] = []
    }
}

// MARK: Scene maker
extension Companies {
    static func createScene() -> ViewController {
        let viewController = CompaniesViewController()
        let presenter = CompaniesPresenter(viewController: viewController)
        let dataStore = Companies.DataStore()
        let interactor = CompaniesInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
