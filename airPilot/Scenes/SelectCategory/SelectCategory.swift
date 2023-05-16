//
//  SelectCategory.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum SelectCategory {
    struct Input {
        let type: CategoryType
        let category: Category?
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let type: CategoryType
            let categories: [Category]
        }
        
        struct ViewModel {
            let type: CategoryType
            let categories: [Category]
        }
    }
    
    enum CategoryType {
        case job
        case shop
    }
}

// MARK: Network
extension SelectCategory {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [Category]?
        }
    }
}

// MARK: DataStore
extension SelectCategory {
    class DataStore {
        var type: CategoryType
        let category: Category?
        var categories: [Category] = []
        var request: Network.GetContent.Request? = nil
        
        init(type: CategoryType, category: Category?) {
            self.type = type
            self.category = category
        }
    }
}

// MARK: Scene maker
extension SelectCategory {
    static func createScene(_ input: SelectCategory.Input) -> ViewController {
        let viewController = SelectCategoryViewController()
        let presenter = SelectCategoryPresenter(viewController: viewController)
        let dataStore = SelectCategory.DataStore(type: input.type, category: input.category)
        let interactor = SelectCategoryInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
