//
//  Filters.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Filters {
    enum Content {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
}

// MARK: Scene maker
extension Filters {
    static func createScene() -> ViewController {
        let viewController = FiltersViewController()
        let presenter = FiltersPresenter(viewController: viewController)
        let interactor = FiltersInteractor(presenter: presenter)
        viewController.interactor = interactor
        return viewController
    }
}
