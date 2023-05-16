//
//  GroupCreatorInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol GroupCreatorLogic {
    func getContent(_ request: GroupCreator.Content.Request)
    func createGroup(_ request: GroupCreator.CreateGroup.Request)
}

struct GroupCreatorInteractor {
    // MARK: External properties
    var presenter: GroupCreatorPresentable?
    var dataStore: GroupCreator.DataStore
}

// MARK: GroupCreatorLogic
extension GroupCreatorInteractor: GroupCreatorLogic {
    func getContent(_ request: GroupCreator.Content.Request) {
        Networker.sendRequest(
            request: GroupCreator.Network.GetContent.Request(),
            response: GroupCreator.Network.GetContent.Response.self,
            url: Endpoints.Default.url) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func createGroup(_ request: GroupCreator.CreateGroup.Request) {
        Networker.sendRequest(
            request: setupCreateGroupRequest(request),
            response: GroupCreator.Network.GetContent.Response.self,
            url: Endpoints.Groups.createGroup) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
}

// MARK: Private
private extension GroupCreatorInteractor {
    func showContent(_ response: GroupCreator.Network.GetContent.Response?) {
        presenter?.presentContent(.init())
    }
    
    func setupCreateGroupRequest(_ request: GroupCreator.CreateGroup.Request) -> GroupCreator.Network.CreateGroup.Request {
        return GroupCreator.Network.CreateGroup.Request(
            name: request.name,
            headline: request.headline,
            assignedTo: request.assignedTo
        )
    }
}
