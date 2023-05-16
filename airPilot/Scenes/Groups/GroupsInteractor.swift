//
//  GroupsInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/01/2023.
//  Copyright © 2023 airPilot. All rights reserved.
//

import Foundation

protocol GroupsLogic {
    func getContent(_ request: Groups.Content.Request)
}

struct GroupsInteractor {
    // MARK: External properties
    var presenter: GroupsPresentable?
    var dataStore: Groups.DataStore
}

// MARK: GroupsLogic
extension GroupsInteractor: GroupsLogic {
    func getContent(_ request: Groups.Content.Request) {
        Networker.sendRequest(
            request: Groups.Network.GetContent.Request(),
            response: Groups.Network.GetContent.Response.self,
            url: Endpoints.Groups.userGroups) { result in
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
private extension GroupsInteractor {
    func showContent(_ response: Groups.Network.GetContent.Response?) {
        response?.administrator?.forEach { group in
            dataStore.groups.append(group)
        }
        
        response?.member?.forEach { group in
            if dataStore.groups.filter({ $0.id == group.id }).isEmpty {
                dataStore.groups.append(group)
            }
        }
        
        presenter?.presentContent(.init(groups: dataStore.groups))
    }
}
