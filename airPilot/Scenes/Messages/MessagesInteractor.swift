//
//  MessagesInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol MessagesLogic {
    func getContent(_ request: Messages.Content.Request)
    func sendMessage(_ request: Messages.SendMessage.Request)
}

struct MessagesInteractor {
    // MARK: External properties
    var presenter: MessagesPresentable?
    var dataStore: Messages.DataStore
}

// MARK: MessagesLogic
extension MessagesInteractor: MessagesLogic {
    func getContent(_ request: Messages.Content.Request) {
        if let conversationId = dataStore.conversationId {
            Networker.sendRequest(
                response: Messages.Network.GetContent.Response.self,
                url: Endpoints.Conversations.conversation + conversationId.toString) { result in
                switch result {
                case .success(let response):
                    showContent(response as? ConversationModel)
                case .failure(let error):
                    Logger.log(error)
                }
            }
        } else if let userUuid = dataStore.userUuid {
            Networker.sendRequest(
                request: setupFindConversationRequest(userUuid),
                response: Messages.Network.FindConversation.Response.self,
                url: Endpoints.Conversations.findConversation) { result in
                switch result {
                case .success(let response):
                    dataStore.conversationId = response?.conversation?.id
                    showContent(response?.conversation)
                case .failure(let error):
                    Logger.log(error)
                }
            }
        }
    }
    
    func sendMessage(_ request: Messages.SendMessage.Request) {
        guard dataStore.conversationId.isNotNil else {
            createConversationAndSendMessage(request)
            return
        }
        
        Networker.sendRequest(
            request: setupSendMessageRequest(request),
            response: Messages.Network.SendMessage.Response.self,
            url: Endpoints.Conversations.sendMessage) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    getContent(.init())
                }
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension MessagesInteractor {
    func showContent(_ response: ConversationModel?) {
        guard var messages = response?.messages else { return }
        messages.removeAll { message in
            dataStore.messages.contains { $0.id == message.id }
        }
        
        messages.forEach { dataStore.messages.append($0) }
        
        presenter?.presentContent(.init(messages: dataStore.messages))
    }
    
    func setupFindConversationRequest(_ anotherUserUuid: String) -> Messages.Network.FindConversation.Request {
        return Messages.Network.FindConversation.Request(
            anotherUserUuid: anotherUserUuid,
            isGroup: false
        )
    }
    
    func setupSendMessageRequest(_ request: Messages.SendMessage.Request) -> Messages.Network.SendMessage.Request {
        return Messages.Network.SendMessage.Request(
            assignedTo: dataStore.conversationId.orZero,
            text: request.text)
    }
    
    func createConversationAndSendMessage(_ request: Messages.SendMessage.Request) {
        Networker.sendRequest(
            request: setupCreateConversationRequest(),
            response: Messages.Network.CreateConversation.Response.self,
            url: Endpoints.Conversations.createConversation) { result in
            switch result {
            case .success(let response):
                dataStore.conversationId = response?.conversationId
                sendMessage(request)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func setupCreateConversationRequest() -> Messages.Network.CreateConversation.Request {
        return Messages.Network.CreateConversation.Request(
            users: [Globals.userUuid, dataStore.userUuid.orEmpty],
            isGroup: false)
    }
}
