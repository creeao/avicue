//
//  MessagesPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol MessagesPresentable {
    func presentContent(_ response: Messages.Content.Response)
}

struct MessagesPresenter {
    // MARK: External properties
    var viewController: MessagesDisplayable?
}

// MARK: MessagesPresentable
extension MessagesPresenter: MessagesPresentable {
    func presentContent(_ response: Messages.Content.Response) {
        viewController?.displayContent(.init(messages: response.messages))
    }
}
