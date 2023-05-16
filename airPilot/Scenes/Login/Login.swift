//
//  Login.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Login {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Login {
        struct Request {
            let type: Authorization
        }
    }
    
    enum Success {
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Failure {
        struct Response {}
        
        struct ViewModel {}
    }
}

// MARK: Scene maker
extension Login {
    static func createScene() -> ViewController {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(viewController: viewController)
        let interactor = LoginInteractor(presenter: presenter)
        viewController.interactor = interactor
        return viewController
    }
}
