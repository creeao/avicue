//
//  Registration.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Registration {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Register {
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
extension Registration {
    static func createScene() -> ViewController {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter(viewController: viewController)
        let interactor = RegistrationInteractor(presenter: presenter)
        viewController.interactor = interactor
        return viewController
    }
}
