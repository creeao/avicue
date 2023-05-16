//
//  MenuInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol MenuLogic {
    func getContent(_ request: Menu.Content.Request)
}

struct MenuInteractor {
    // MARK: External properties
    var presenter: MenuPresentable?
    var dataStore: Menu.DataStore
}

// MARK: MenuLogic
extension MenuInteractor: MenuLogic {
    func getContent(_ request: Menu.Content.Request) {
        Networker.sendRequest(
            request: Menu.Network.GetContent.Request(),
            response: Menu.Network.GetContent.Response.self,
            url: Endpoints.Users.membershipInformation) { result in
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
private extension MenuInteractor {
    func showContent(_ response: Menu.Network.GetContent.Response?) {
        var groupsMember: [GroupModel] = []
        
        response?.groupsMember?.forEach { group in
            if (response?.groupsAdministrator ?? []).filter({ $0.id == group.id }).isEmpty {
                groupsMember.append(group)
            }
        }
        
        presenter?.presentContent(.init(
            companiesAdministrator: response?.companiesAdministrator ?? [],
            groupsAdministrator: response?.groupsAdministrator ?? [],
            groupsMember: groupsMember))
    }
}
