//
//  EditProfile.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum EditProfile {
    enum Content {
        struct Request {}
        
        struct Response {
            let currentInformations: ProfileModel
        }
        
        struct ViewModel {
            let currentInformations: ProfileModel
        }
    }
    
    enum Headline {
        struct Request {}
        
        struct Response {
            let headline: String?
        }
        
        struct ViewModel {
            let headline: String?
        }
    }
    
    enum SaveChanges {
        struct Request {
            let firstName: String?
            let lastName: String?
            let headline: String?
            let email: String?
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum ChangeAvatar {
        struct Request {
            let image: UIImage
        }
    }
    
    enum ChangeBackground {
        struct Request {
            let image: UIImage
        }
    }
    
    enum RemoveJobHistory {
        struct Request {
            let id: Int
        }
    }
    
    enum Result {
        struct Response {
            let type: ResultViewType
        }
        
        struct ViewModel {
            let result: ResultModel
        }
    }
    
    enum PickerType {
        case avatar
        case background
    }
}

// MARK: Network
extension EditProfile {
    enum Network {
        enum GetContent {
            typealias Response = ProfileModel?
        }
        
        enum GetHeadline {
            struct Response: Decodable {
                let headline: String
            }
        }
        
        enum SaveChanges {
            struct Request: Encodable {
                let firstName: String?
                let lastName: String?
                let headline: String?
                let email: String?
            }
            
            struct Response: Decodable {}
        }
        
        enum RemoveJobHistory {
            struct Request: Encodable {
                let jobHistoryId: Int
            }
            
            struct Response: Decodable {}
        }
        
        enum ChangeAvatar {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
        
        
        enum ChangeBackground {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension EditProfile {
    class DataStore {}
}

// MARK: Scene maker
extension EditProfile {
    static func createScene() -> ViewController {
        let viewController = EditProfileViewController()
        let presenter = EditProfilePresenter(viewController: viewController)
        let dataStore = EditProfile.DataStore()
        let interactor = EditProfileInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
