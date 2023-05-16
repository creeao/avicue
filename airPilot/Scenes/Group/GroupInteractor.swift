//
//  GroupInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol GroupLogic {
    func getContent(_ request: Group.Content.Request)
    func createPost(_ request: Group.CreatePost.Request)
}

struct GroupInteractor {
    // MARK: External properties
    var presenter: GroupPresentable?
    var dataStore: Group.DataStore
}

// MARK: GroupLogic
extension GroupInteractor: GroupLogic {
    func getContent(_ request: Group.Content.Request) {
        Networker.sendRequest(
            response: Group.Network.GetContent.Response.self,
            url: Endpoints.Groups.group + dataStore.groupId.toString) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func createPost(_ request: Group.CreatePost.Request) {
        Networker.sendRequest(
            request: setupCreatePostRequest(request),
            response: Group.Network.CreatePost.Response.self,
            url: Endpoints.Groups.createPost) { result in
            switch result {
            case .success(_):
                getContent(.init())
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension GroupInteractor {
    func showContent(_ response: Group.Network.GetContent.Response?) {
        guard let group = response as? GroupModel else { return }
        presenter?.presentContent(.init(group: group))
    }
    
    func setupCreatePostRequest(_ request: Group.CreatePost.Request) -> Group.Network.CreatePost.Request {
        return Group.Network.CreatePost.Request(
            text: request.text,
            assignedToGroup: dataStore.groupId)
    }
}
