//
//  UsersPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol UsersPresentable {
    func presentContent(_ response: Users.Content.Response)
}

struct UsersPresenter {
    // MARK: External properties
    var viewController: UsersDisplayable?
}

// MARK: UsersPresentable
extension UsersPresenter: UsersPresentable {
    func presentContent(_ response: Users.Content.Response) {
        viewController?.displayContent(.init(users: response.users))
    }
}
