//
//  Users.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Users {
    struct Input {
        let userUuid: String
        let type: ListType
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let users: [UserModel]
        }
        
        struct ViewModel {
            let users: [UserModel]
        }
    }
    
    enum ListType {
        case friends
        case followers
    }
}

// MARK: Network
extension Users {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [UserModel]?
        }
    }
}

// MARK: DataStore
extension Users {
    class DataStore {
        var userUuid: String
        var type: ListType
        var users: [UserModel] = []
        
        init(userUuid: String, type: ListType) {
            self.userUuid = userUuid
            self.type = type
        }
    }
}

// MARK: Scene maker
extension Users {
    static func createScene(_ input: Users.Input) -> ViewController {
        let viewController = UsersViewController()
        let presenter = UsersPresenter(viewController: viewController)
        let dataStore = Users.DataStore(userUuid: input.userUuid, type: input.type)
        let interactor = UsersInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
