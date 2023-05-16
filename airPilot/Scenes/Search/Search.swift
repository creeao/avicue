//
//  Search.swift
//  airPilot
//
//  Created by Eryk Chrustek on 20/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Search {
    enum Categories: String, CaseIterable {
        case users = "USERS"
        case companies = "COMPANIES"
        case groups = "GROUPS"
        
        func getName() -> String {
            switch self {
            case .users:
                return "Users"
            case .companies:
                return "Companies"
            case .groups:
                return "Groups"
            }
        }
    }
    
    enum Users {
        struct Request {}
        
        struct Response {
            let users: [UserModel]
        }
        
        struct ViewModel {
            let users: [UserModel]
        }
    }
    
    enum Companies {
        struct Request {}
        
        struct Response {
            let companies: [CompanyModel]
        }
        
        struct ViewModel {
            let companies: [CompanyModel]
        }
    }
    
    enum Groups {
        struct Request {}
        
        struct Response {
            let groups: [GroupModel]
        }
        
        struct ViewModel {
            let groups: [GroupModel]
        }
    }
}

//// MARK: Scene maker
//extension Search {
//    static func createScene() -> ViewController {
//        let viewController = SearchViewController()
//        let presenter = SearchPresenter(viewController: viewController)
//        let interactor = SearchInteractor(presenter: presenter)
//        viewController.interactor = interactor
//        return viewController
//    }
//}

// MARK: Network
extension Search {
    enum Network {
        enum GetUsers {
            struct Request: Encodable {}
            
            typealias Response = [UserModel]?
        }
        
        enum GetCompanies {
            struct Request: Encodable {}
            
            typealias Response = [CompanyModel]?
        }
        
        enum GetGroups {
            struct Request: Encodable {}
            
            typealias Response = [GroupModel]?
        }
    }
}

// MARK: DataStore
extension Search {
    class DataStore {
        var users: [UserModel] = []
        var companies: [CompanyModel] = []
        var groups: [GroupModel] = []
    }
}

// MARK: Scene maker
extension Search {
    static func createScene() -> ViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter(viewController: viewController)
        let dataStore = Search.DataStore()
        let interactor = SearchInteractor(
            presenter: presenter,
            dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
