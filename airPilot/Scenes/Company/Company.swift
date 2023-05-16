//
//  Company.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Company {
    struct Input {
        let id: Int
    }

    enum Categories: String, CaseIterable {
        case posts = "POSTS"
        case jobOffers = "JOB_OFFERS"
        case shopOffers = "SHOP_OFFERS"
        case services = "SERVICES"
        case gallery = "GALLERY"
        case aboutUs = "ABOUT_US"
        
        func getName() -> String {
            switch self {
            case .posts:
                return "Posts"
            case .jobOffers:
                return "Job offers"
            case .shopOffers:
                return "Shop offers"
            case .services:
                return "Services"
            case .gallery:
                return "Gallery"
            case .aboutUs:
                return "About us"
            }
        }
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let profile: CompanyProfileModel
        }
        
        struct ViewModel {
            let profile: CompanyProfileModel
        }
    }
    
    enum ActionOnCompany {
        struct Request {
            let actionOnCompany: ActionOnCompanyType
        }
    }
    
    enum FavouriteAction {
        struct Request {
            let offerId: Int
            let isFavourite: Bool
        }
    }
}

// MARK: Network
extension Company {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = CompanyProfileModel?
        }
        
        enum ActionOnCompany {
            struct Request: Encodable {
                let companyId: Int
                let type: ActionOnCompanyType
            }
            
            struct Response: Decodable {}
        }
        
        enum FavouriteAction {
            struct Request: Encodable {
                let offerId: Int
                let isFavourite: Bool
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension Company {
    class DataStore {
        var companyId: Int
        
        init(companyId: Int) {
            self.companyId = companyId
        }
    }
}

// MARK: Scene maker
extension Company {
    static func createScene(_ input: Company.Input) -> ViewController {
        let viewController = CompanyViewController()
        let presenter = CompanyPresenter(viewController: viewController)
        let dataStore = Company.DataStore(companyId: input.id)
        let interactor = CompanyInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
