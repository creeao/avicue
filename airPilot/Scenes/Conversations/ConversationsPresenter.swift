//
//  ConversationsPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol ConversationsPresentable {
    func presentContent(_ response: Conversations.Content.Response)
}

struct ConversationsPresenter {
    // MARK: External properties
    var viewController: ConversationsDisplayable?
}

// MARK: ConversationsPresentable
extension ConversationsPresenter: ConversationsPresentable {
    func presentContent(_ response: Conversations.Content.Response) {
        viewController?.displayContent(.init(conversations: response.conversations))
    }
}
