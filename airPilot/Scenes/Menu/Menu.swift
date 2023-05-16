//
//  Menu.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Menu {
    enum Content {
        struct Request {}
        
        struct Response {
            let companiesAdministrator: [CompanyModel]
            let groupsAdministrator: [GroupModel]
            let groupsMember: [GroupModel]
        }
        
        struct ViewModel {
            let companiesAdministrator: [CompanyModel]
            let groupsAdministrator: [GroupModel]
            let groupsMember: [GroupModel]
        }
    }
}

// MARK: Network
extension Menu {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {
                let companiesAdministrator: [CompanyModel]?
                let groupsAdministrator: [GroupModel]?
                let groupsMember: [GroupModel]?
            }
        }
    }
}

// MARK: DataStore
extension Menu {
    class DataStore {}
}

// MARK: Scene maker
extension Menu {
    static func createScene() -> ViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter(viewController: viewController)
        let dataStore = Menu.DataStore()
        let interactor = MenuInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
