//
//  ProfileInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol ProfileLogic {
    func getContent(_ request: Profile.Content.Request)
    func actionOnUser(_ request: Profile.ActionOnUser.Request)
    func getPosts(_ request: Profile.Posts.Request)
    func likePost(_ request: Profile.LikePost.Request)
}

struct ProfileInteractor {
    // MARK: External properties
    var presenter: ProfilePresentable?
    var dataStore: Profile.DataStore
}

// MARK: ProfileLogic
extension ProfileInteractor: ProfileLogic {
    func getContent(_ request: Profile.Content.Request) {
        Networker.sendRequest(
            response: Profile.Network.GetProfile.Response.self,
            url: Endpoints.Users.userProfile + dataStore.userUuid) { result in
            switch result {
            case .success(let response):
                guard let response = response as? ProfileModel else {
                    Logger.log("Missing response")
                    return
                }
                dataStore.profile = response
                showContent()
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func actionOnUser(_ request: Profile.ActionOnUser.Request) {
        Networker.sendRequest(
            request: setupActionOnUserRequest(request),
            response: Profile.Network.ActionOnUser.Response.self,
            url: Endpoints.Users.Profile.actionOnUser) { result in
            switch result {
            case .success(let response):
                Logger.log(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func getPosts(_ request: Profile.Posts.Request) {
        
    }
    
    func likePost(_ request: Profile.LikePost.Request) {
        
    }
}

// MARK: Private
private extension ProfileInteractor {
    func showContent() {
        guard let profile = dataStore.profile else { return }
        presenter?.presentContent(.init(profile: profile))
    }
    
    func setupCheckStatusWithUserRequest() -> Profile.Network.StatusWithUser.Request {
        return Profile.Network.StatusWithUser.Request(
            anotherUserUuid: dataStore.userUuid
        )
    }
    
    func setupActionOnUserRequest(_ request: Profile.ActionOnUser.Request) -> Profile.Network.ActionOnUser.Request {
        return Profile.Network.ActionOnUser.Request(
            anotherUserUuid: dataStore.userUuid,
            actionOnUser: request.actionOnUser
        )
    }
}
