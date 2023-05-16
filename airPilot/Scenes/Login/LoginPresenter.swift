//
//  LoginPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol LoginPresentable {
    func presentContent(_ response: Login.Content.Response)
    func presentDashboard(_ response: Login.Success.Response)
    func presentFailure(_ response: Login.Failure.Response)
}

struct LoginPresenter {
    // MARK: External properties
    var viewController: LoginDisplayable?
}

// MARK: LoginPresentable
extension LoginPresenter: LoginPresentable {
    func presentContent(_ response: Login.Content.Response) {
        viewController?.displayContent(.init())
    }
    
    func presentDashboard(_ response: Login.Success.Response) {
        viewController?.displayDashboard(.init())
    }
    
    func presentFailure(_ response: Login.Failure.Response) {
        viewController?.displayFailure(.init())
    }
}
