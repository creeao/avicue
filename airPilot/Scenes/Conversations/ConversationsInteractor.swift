//
//  ConversationsInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol ConversationsLogic {
    func getContent(_ request: Conversations.Content.Request)
}

struct ConversationsInteractor {
    // MARK: External properties
    var presenter: ConversationsPresentable?
}

// MARK: ConversationsLogic
extension ConversationsInteractor: ConversationsLogic {
    func getContent(_ request: Conversations.Content.Request) {
        Networker.sendRequest(
            response: Conversations.Network.GetContent.Response.self,
            url: Endpoints.Conversations.userConversations + Globals.userUuid) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension ConversationsInteractor {
    func showContent(_ response: Conversations.Network.GetContent.Response?) {
        guard let conversations = response as? [ConversationModel] else { return }
        presenter?.presentContent(.init(conversations: conversations))
    }
}
