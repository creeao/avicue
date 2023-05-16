//
//  GroupCreator.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum GroupCreator {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum CreateGroup {
        struct Request {
            let name: String
            let headline: String?
            let assignedTo: Int?
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
extension GroupCreator {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
        
        enum CreateGroup {
            struct Request: Encodable {
                let name: String
                let headline: String?
                let assignedTo: Int?
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension GroupCreator {
    class DataStore {}
}

// MARK: Scene maker
extension GroupCreator {
    static func createScene() -> ViewController {
        let viewController = GroupCreatorViewController()
        let presenter = GroupCreatorPresenter(viewController: viewController)
        let dataStore = GroupCreator.DataStore()
        let interactor = GroupCreatorInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
