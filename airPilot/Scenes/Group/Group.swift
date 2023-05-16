//
//  Group.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Group {
    struct Input {
        let id: Int
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let group: GroupModel
        }
        
        struct ViewModel {
            let group: GroupModel
            let posts: [PostModel]
        }
    }
    
    enum CreatePost {
        struct Request {
            let text: String
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
}

// MARK: Network
extension Group {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = GroupModel?
        }
        
        enum CreatePost {
            struct Request: Encodable {
                let text: String
                let assignedToGroup: Int
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension Group {
    class DataStore {
        var groupId: Int
        
        init(groupId: Int) {
            self.groupId = groupId
        }
    }
}

// MARK: Scene maker
extension Group {
    static func createScene(_ input: Group.Input) -> ViewController {
        let viewController = GroupViewController()
        let presenter = GroupPresenter(viewController: viewController)
        let dataStore = Group.DataStore(groupId: input.id)
        let interactor = GroupInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
