//
//  GroupPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol GroupPresentable {
    func presentContent(_ response: Group.Content.Response)
}

struct GroupPresenter {
    // MARK: External properties
    var viewController: GroupDisplayable?
}

// MARK: GroupPresentable
extension GroupPresenter: GroupPresentable {
    func presentContent(_ response: Group.Content.Response) {
        viewController?.displayContent(.init(
            group: response.group,
            posts: response.group.posts ?? []))
    }
}
