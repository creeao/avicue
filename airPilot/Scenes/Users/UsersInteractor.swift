//
//  UsersInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol UsersLogic {
    func getContent(_ request: Users.Content.Request)
}

struct UsersInteractor {
    // MARK: External properties
    var presenter: UsersPresentable?
    var dataStore: Users.DataStore
}

// MARK: UsersLogic
extension UsersInteractor: UsersLogic {
    func getContent(_ request: Users.Content.Request) {
        switch dataStore.type {
        case .friends:
            getFriends()
        case .followers:
            getFollowers()
        }
    }
}

// MARK: Private
private extension UsersInteractor {
    func getFriends() {
        Networker.sendRequest(
            response: Users.Network.GetContent.Response.self,
            url: Endpoints.Users.friends + dataStore.userUuid) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func getFollowers() {
        Networker.sendRequest(
            response: Users.Network.GetContent.Response.self,
            url: Endpoints.Users.followers + dataStore.userUuid) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func showContent(_ response: Users.Network.GetContent.Response?) {
        dataStore.users = response as? [UserModel] ?? []
        presenter?.presentContent(.init(users: dataStore.users))
    }
}
