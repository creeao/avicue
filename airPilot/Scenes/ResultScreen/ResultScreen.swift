//
//  ResultScreen.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum ResultScreen {
    struct Input {
        let result: ResultModel
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let result: ResultModel
        }
        
        struct ViewModel {
            let result: ResultModel
        }
    }
}

// MARK: Network
extension ResultScreen {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension ResultScreen {
    class DataStore {
        let result: ResultModel
        
        init(result: ResultModel) {
            self.result = result
        }
    }
}

// MARK: Scene maker
extension ResultScreen {
    static func createScene(_ input: ResultScreen.Input) -> ViewController {
        let viewController = ResultScreenViewController()
        let presenter = ResultScreenPresenter(viewController: viewController)
        let dataStore = ResultScreen.DataStore(result: input.result)
        let interactor = ResultScreenInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
