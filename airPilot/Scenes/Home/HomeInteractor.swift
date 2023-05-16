//
//  HomeInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol HomeLogic {
    func getContent(_ request: Home.Content.Request)
    func tapLikeButton(_ request: Home.LikeButton.Request)
    func createPost(_ request: Home.CreatePost.Request)
}

struct HomeInteractor {
    // MARK: External properties
    var presenter: HomePresentable?
    var dataStore: Home.DataStore
}

// MARK: HomeLogic
extension HomeInteractor: HomeLogic {
    func getContent(_ request: Home.Content.Request) {
        Networker.sendRequest(
            response: Home.Network.GetContent.Response.self,
            url: Endpoints.Activities.activity) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
        
        Networker.sendRequest(
            response: Home.Network.GetUser.Response.self,
            url: Endpoints.Users.user + Globals.userUuid) { result in
            switch result {
            case .success(let response):
                guard let user = response as? UserModel else { return }
                Globals.userModel = user
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func tapLikeButton(_ request: Home.LikeButton.Request) {
        Networker.sendRequest(
            request: setupLikePostRequest(request),
            response: Home.Network.LikePost.Response.self,
            url: Endpoints.Posts.likePost) { result in
            switch result {
            case .success(let response):
                Logger.log(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func createPost(_ request: Home.CreatePost.Request) {
        Networker.sendRequest(
            request: setupCreatePostRequest(request),
            response: Home.Network.CreatePost.Response.self,
            url: Endpoints.Posts.createPost) { result in
            switch result {
            case .success(let response):
                Logger.log(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension HomeInteractor {
    func showContent(_ response: Home.Network.GetContent.Response?) {
//        response.orEmpty.forEach { activity in
//            dataStore.activities.append(ac)
//        }
        guard let activities = (response as? [ActivityModel]) else { return }
        dataStore.activities = activities
//        dataStore.friends = friends
//        dataStore.friends.forEach { friend in
//            friend.posts?.forEach { post in
//                var activity = ActivityModel(type: .ownPost)
//                activity.ownPost = post
//                dataStore.activities.append(activity)
//            }
//
//            friend.likedPostsActivity?.forEach { post in
//                var activity =  type: .likedPost)
//                activity.likedPost = post
//                activity.user = friend
//                if dataStore.activities.first(where: { $0.ownPost?.id == post.id }).isNil {
//                    dataStore.activities.append(activity)
//                }
//            }
//
//            friend.sharedPostsActivity?.forEach { post in
//                var activity = ActivityModel(type: .sharedPost)
//                activity.sharedPost = post
//                activity.user = friend
//                dataStore.activities.append(activity)
//            }
//
//            friend.sharedShopOffersActivity?.forEach { shopOffer in
//                var activity = ActivityModel(type: .sharedShopOffer)
//                activity.sharedShopOffer = shopOffer
//                activity.user = friend
//                dataStore.activities.append(activity)
//            }
//
//            friend.sharedJobOffersActivity?.forEach { jobOffer in
//                var activity = ActivityModel(type: .sharedJobOffer)
//                activity.sharedJobOffer = jobOffer
//                activity.user = friend
//                dataStore.activities.append(activity)
//            }
//        }
        
        let response = Home.Content.Response(activities: dataStore.activities)
        presenter?.presentContent(response)
    }
    
    func setupLikePostRequest(_ request: Home.LikeButton.Request) -> Home.Network.LikePost.Request {
        return Home.Network.LikePost.Request(
            postId: request.postId,
            isLike: request.isLike
        )
    }
    
    func setupCreatePostRequest(_ request: Home.CreatePost.Request) -> Home.Network.CreatePost.Request {
        return Home.Network.CreatePost.Request(
            text: request.text
        )
    }
}
