//
//  EditCompanyProfile.swift
//  airPilot
//
//  Created by Eryk Chrustek on 13/02/2023.
//  Copyright © 2023 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum EditCompanyProfile {
    struct Input {
        let companyId: Int
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
    
    enum SaveChanges {
        struct Request {
            let name: String
            let headline: String?
            let website: String?
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum ChangeLogo {
        struct Request {
            let image: UIImage
        }
    }
    
    enum ChangeBackground {
        struct Request {
            let image: UIImage
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
extension EditCompanyProfile {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = CompanyProfileModel?
        }
        
        enum SaveChanges {
            struct Request: Encodable {
                let companyId: Int
                let name: String
                let headline: String?
                let website: String?
            }
            
            struct Response: Decodable {}
        }
        
        enum ChangeLogo {
            struct Request: Encodable {
                let companyId: Int
            }
            
            struct Response: Decodable {}
        }
        
        
        enum ChangeBackground {
            struct Request: Encodable {
                let companyId: Int
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension EditCompanyProfile {
    class DataStore {
        let companyId: Int
        
        init(companyId: Int) {
            self.companyId = companyId
        }
    }
}

// MARK: Scene maker
extension EditCompanyProfile {
    static func createScene(_ input: EditCompanyProfile.Input) -> ViewController {
        let viewController = EditCompanyProfileViewController()
        let presenter = EditCompanyProfilePresenter(viewController: viewController)
        let dataStore = EditCompanyProfile.DataStore(companyId: input.companyId)
        let interactor = EditCompanyProfileInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
