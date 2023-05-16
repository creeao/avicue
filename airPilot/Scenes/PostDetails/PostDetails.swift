//
//  PostDetails.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum PostDetails {
    struct Input {
        let postId: Int
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let post: PostModel
        }
        
        struct ViewModel {
            let post: ActivityModel
            let comments: [ActivityModel]
        }
    }
    
    enum LikeButton {
        struct Request {
            let postId: Int?
            let commentId: Int?
            let isLike: Bool
        }
    }
    
    enum CommentPost {
        struct Request {
            let text: String
        }
    }
}

// MARK: Network
extension PostDetails {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = PostModel?
        }
        
        enum CommentPost {
            struct Request: Encodable {
                let assignedTo: Int
                let text: String
            }
            
            struct Response: Decodable {}
//            typealias Response = PostModel?
        }
        
        enum LikePost {
            struct Request: Encodable {
                let postId: Int
                let isLike: Bool
            }
            
            struct Response: Decodable {}
        }
        
        enum LikeComment {
            struct Request: Encodable {
                let commentId: Int
                let isLike: Bool
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension PostDetails {
    class DataStore {
        let postId: Int
        
        init(postId: Int) {
            self.postId = postId
        }
    }
}

// MARK: Scene maker
extension PostDetails {
    static func createScene(_ input: PostDetails.Input) -> ViewController {
        let viewController = PostDetailsViewController()
        let presenter = PostDetailsPresenter(viewController: viewController)
        let dataStore = PostDetails.DataStore(postId: input.postId)
        let interactor = PostDetailsInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
