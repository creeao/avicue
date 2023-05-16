//
//  RegistrationInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol RegistrationLogic {
    func getContent(_ request: Registration.Content.Request)
    func register(_ request: Registration.Register.Request)
}

struct RegistrationInteractor {
    // MARK: External properties
    var presenter: RegistrationPresentable?
}

// MARK: RegistrationLogic
extension RegistrationInteractor: RegistrationLogic {
    func getContent(_ request: Registration.Content.Request) {
        presenter?.presentContent(.init())
    }
    
    func register(_ request: Registration.Register.Request) {
        switch request.type {
        case .email(let email, let password):
            print(email)
            print(password)
//            Firebase.register(email: email, password: password) { response in
//                switch response {
//                case .success(let response):
//                    print(response)
//                    presenter?.presentLogin(.init())
//                case .failure(let error):
//                    print(error)
//                    presenter?.presentFailure(.init())
//                }
//            }
        case .apple:
            Logger.log("TODO")
        case .google:
            Logger.log("TODO")
        case .facebook:
            Logger.log("TODO")
        }
    }
}
