//
//  PostDetailsInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol PostDetailsLogic {
    func getContent(_ request: PostDetails.Content.Request)
    func commentPost(_ request: PostDetails.CommentPost.Request)
    func tapLikeButton(_ request: PostDetails.LikeButton.Request)
}

struct PostDetailsInteractor {
    // MARK: External properties
    var presenter: PostDetailsPresentable?
    var dataStore: PostDetails.DataStore
}

// MARK: PostDetailsLogic
extension PostDetailsInteractor: PostDetailsLogic {
    func getContent(_ request: PostDetails.Content.Request) {
        Networker.sendRequest(
            response: PostDetails.Network.GetContent.Response.self,
            url: Endpoints.Posts.post + dataStore.postId.toString) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func tapLikeButton(_ request: PostDetails.LikeButton.Request) {
        if let postId = request.postId {
            Networker.sendRequest(
                request: setupLikePostRequest(postId, request.isLike),
                response: PostDetails.Network.LikePost.Response.self,
                url: Endpoints.Posts.likePost) { result in
                switch result {
                case .success(let response):
                    Logger.log(response)
                case .failure(let error):
                    Logger.log(error)
                }
            }
        } else if let commentId = request.commentId {
            Networker.sendRequest(
                request: setupLikeCommentRequest(commentId, request.isLike),
                response: PostDetails.Network.LikeComment.Response.self,
                url: Endpoints.Comments.likeComment) { result in
                switch result {
                case .success(let response):
                    Logger.log(response)
                case .failure(let error):
                    Logger.log(error)
                }
            }
        }
    }
    
    func commentPost(_ request: PostDetails.CommentPost.Request) {
        Networker.sendRequest(
            request: setupCommentPostRequest(request),
            response: PostDetails.Network.CommentPost.Response.self,
            url: Endpoints.Comments.createComment) { result in
            switch result {
            case .success(let response):
                getContent(.init())
                Logger.log(response)
//                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension PostDetailsInteractor {
    func showContent(_ response: PostDetails.Network.GetContent.Response?) {
        guard let post = response as? PostModel else { return }
        presenter?.presentContent(.init(post: post))
    }
    
    func setupCommentPostRequest(_ request: PostDetails.CommentPost.Request) -> PostDetails.Network.CommentPost.Request {
        return PostDetails.Network.CommentPost.Request(
            assignedTo: dataStore.postId,
            text: request.text)
    }
    
    func setupLikePostRequest(_ postId: Int, _ isLike: Bool) -> PostDetails.Network.LikePost.Request {
        return PostDetails.Network.LikePost.Request(
            postId: postId,
            isLike: isLike
        )
    }
    
    func setupLikeCommentRequest(_ commentId: Int, _ isLike: Bool) -> PostDetails.Network.LikeComment.Request {
        return PostDetails.Network.LikeComment.Request(
            commentId: commentId,
            isLike: isLike
        )
    }
}
