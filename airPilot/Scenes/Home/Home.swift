//
//  Home.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Home {
    enum Content {
        struct Request {}
        
        struct Response {
            var activities: [ActivityModel] = []
        }
        
        struct ViewModel {
            var activities: [ActivityModel] = []
        }
    }
    
    enum LikeButton {
        struct Request {
            let postId: Int
            let isLike: Bool
        }
    }
    
    enum CreatePost {
        struct Request {
            let text: String
        }
    }
}

// MARK: Network
extension Home {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [ActivityModel]?
        }
        
        enum GetUser {
            struct Request: Encodable {}
            
            typealias Response = UserModel?
        }
        
        enum LikePost {
            struct Request: Encodable {
                let postId: Int
                let isLike: Bool
            }
            
            struct Response: Decodable {}
        }
        
        enum CreatePost {
            struct Request: Encodable {
                let text: String
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension Home {
    class DataStore {
        var friends: [UserModel] = []
        var activities: [ActivityModel] = []
        
//        var posts: [PostModel] = []
//        var sharedPosts: [PostModel] = []
//        var likedPosts: [PostModel] = []
//        var sharedShopOffers: [ShopOfferModel] = []
//        var sharedJobOffers: [JobOfferModel] = []
    }
}

// MARK: Scene maker
extension Home {
    static func createScene() -> ViewController {
        let viewController = HomeViewController()
        let presenter = HomePresenter(viewController: viewController)
        let dataStore = Home.DataStore()
        let interactor = HomeInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
