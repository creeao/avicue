//
//  Conversations.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Conversations {
    enum Content {
        struct Request {}
        
        struct Response {
            let conversations: [ConversationModel]
        }
        
        struct ViewModel {
            let conversations: [ConversationModel]
        }
    }
}

// MARK: Network
extension Conversations {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [ConversationModel]?
        }
    }
}

// MARK: DataStore
extension Conversations {
    class DataStore {
        var conversations: [ConversationModel] = []
    }
}

// MARK: Scene maker
extension Conversations {
    static func createScene() -> ViewController {
        let viewController = ConversationsViewController()
        let presenter = ConversationsPresenter(viewController: viewController)
        let interactor = ConversationsInteractor(presenter: presenter)
        viewController.interactor = interactor
        return viewController
    }
}
