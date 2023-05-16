//
//  GroupsPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/01/2023.
//  Copyright © 2023 ACC. All rights reserved.
//

import Foundation

protocol GroupsPresentable {
    func presentContent(_ response: Groups.Content.Response)
}

struct GroupsPresenter {
    // MARK: External properties
    var viewController: GroupsDisplayable?
}

// MARK: GroupsPresentable
extension GroupsPresenter: GroupsPresentable {
    func presentContent(_ response: Groups.Content.Response) {
        viewController?.displayContent(.init(groups: response.groups))
    }
}
