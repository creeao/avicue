//
//  Groups.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/01/2023.
//  Copyright © 2023 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Groups {
    enum Content {
        struct Request {}
        
        struct Response {
            let groups: [GroupModel]
        }
        
        struct ViewModel {
            let groups: [GroupModel]
        }
    }
}

// MARK: Network
extension Groups {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {
                let administrator: [GroupModel]?
                let member: [GroupModel]?
            }
        }
    }
}

// MARK: DataStore
extension Groups {
    class DataStore {
        var groups: [GroupModel] = []
    }
}

// MARK: Scene maker
extension Groups {
    static func createScene() -> ViewController {
        let viewController = GroupsViewController()
        let presenter = GroupsPresenter(viewController: viewController)
        let dataStore = Groups.DataStore()
        let interactor = GroupsInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
