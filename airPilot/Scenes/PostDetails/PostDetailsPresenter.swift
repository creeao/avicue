//
//  PostDetailsPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol PostDetailsPresentable {
    func presentContent(_ response: PostDetails.Content.Response)
}

struct PostDetailsPresenter {
    // MARK: External properties
    var viewController: PostDetailsDisplayable?
}

// MARK: PostDetailsPresentable
extension PostDetailsPresenter: PostDetailsPresentable {
    func presentContent(_ response: PostDetails.Content.Response) {
        let post = ActivityModel(
            id: response.post.id,
            type: .post,
            activityDate: response.post.createdDate,
            friendsActivity: nil,
            post: response.post)

        let comments = response.post.comments?.map { ActivityModel(id: $0.id, type: .comment, comment: $0) }
        viewController?.displayContent(.init(post: post, comments: comments ?? []))
    }
}
