//
//  Messages.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Messages {
    struct Input {
        let conversationId: Int?
        let userUuid: String?
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let messages: [MessageModel]
        }
        
        struct ViewModel {
            let messages: [MessageModel]
        }
    }
    
    enum SendMessage {
        struct Request {
            let text: String?
        }
        
        struct Response {
//            let conversation: ConversationModel
        }
        
        struct ViewModel {
//            let messages: [MessageModel]
        }
    }
}

// MARK: Network
extension Messages {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = ConversationModel?
        }
        
        enum SendMessage {
            struct Request: Encodable {
                let assignedTo: Int
                let text: String?
            }
            
            struct Response: Decodable {}
        }
        
        enum FindConversation {
            struct Request: Encodable {
                let anotherUserUuid: String
                let isGroup: Bool
            }
            
            struct Response: Decodable {
                let conversation: ConversationModel?
            }
        }
        
        enum CreateConversation {
            struct Request: Encodable {
                let users: [String]
                let isGroup: Bool
            }
            
            struct Response: Decodable {
                let conversationId: Int
            }
        }
    }
}

// MARK: DataStore
extension Messages {
    class DataStore {
        var conversationId: Int?
        var userUuid: String?
        var messages: [MessageModel] = []
        
        init(conversationId: Int?, userUuid: String?) {
            self.conversationId = conversationId
            self.userUuid = userUuid
        }
    }
}

// MARK: Scene maker
extension Messages {
    static func createScene(_ input: Messages.Input) -> ViewController {
        let viewController = MessagesViewController()
        let presenter = MessagesPresenter(viewController: viewController)
        let dataStore = Messages.DataStore(conversationId: input.conversationId, userUuid: input.userUuid)
        let interactor = MessagesInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
