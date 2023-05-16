//
//  MenuPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol MenuPresentable {
    func presentContent(_ response: Menu.Content.Response)
}

struct MenuPresenter {
    // MARK: External properties
    var viewController: MenuDisplayable?
}

// MARK: MenuPresentable
extension MenuPresenter: MenuPresentable {
    func presentContent(_ response: Menu.Content.Response) {
        viewController?.displayContent(.init(
            companiesAdministrator: response.companiesAdministrator,
            groupsAdministrator: response.groupsAdministrator,
            groupsMember: response.groupsMember))
    }
}
