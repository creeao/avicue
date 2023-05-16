//
//  Profile.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Profile {
    struct Input {
        let userUuid: String
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let profile: ProfileModel
        }
        
        struct ViewModel {
            let profile: ProfileModel
        }
    }
    
    enum StatusWithUser {
        struct Request {}
        
        struct Response {
            let profile: UserModel
        }
        
        struct ViewModel {
            let profile: UserModel
        }
    }
    
    enum ActionOnUser {
        struct Request {
            let actionOnUser: ActionOnUserType
        }
    }
    
    enum LikePost {
        struct Request {
            let postId: Int
        }
    }
    
    enum Posts {
        struct Request {}
    }
    
    // MARK: Network
    enum Network {
        enum GetProfile {
            typealias Response = ProfileModel?
        }
        
        enum StatusWithUser {
            struct Request: Encodable {
                let anotherUserUuid: String
            }
            
            struct Response: Decodable {
                let status: UsersRelationType?
            }
        }
        
        enum ActionOnUser {
            struct Request: Encodable {
                let anotherUserUuid: String
                let actionOnUser: ActionOnUserType
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension Profile {
    class DataStore {
        var userUuid: String
        var isUserProfile: Bool = false
        var profile: ProfileModel?
        var statusWithUser: UsersRelationType = .noRelations
        
        init(userUuid: String) {
            self.userUuid = userUuid
        }
    }
}

// MARK: Scene maker
extension Profile {
    static func createScene(_ input: Profile.Input) -> ViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(viewController: viewController)
        let dataStore = Profile.DataStore(userUuid: input.userUuid)
        let interactor = ProfileInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
