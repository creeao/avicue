//
//  RegistrationPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol RegistrationPresentable {
    func presentContent(_ response: Registration.Content.Response)
    func presentLogin(_ response: Registration.Success.Response)
    func presentFailure(_ response: Registration.Failure.Response)
}

struct RegistrationPresenter {
    // MARK: External properties
    var viewController: RegistrationDisplayable?
}

// MARK: RegistrationPresentable
extension RegistrationPresenter: RegistrationPresentable {
    func presentContent(_ response: Registration.Content.Response) {
        viewController?.displayContent(.init())
    }
    
    func presentLogin(_ response: Registration.Success.Response) {
        viewController?.displayLogin(.init())
    }
    
    func presentFailure(_ response: Registration.Failure.Response) {
        viewController?.displayFailure(.init())
    }
}
