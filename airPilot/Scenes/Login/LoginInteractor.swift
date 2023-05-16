//
//  LoginInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol LoginLogic {
    func getContent(_ request: Login.Content.Request)
    func login(_ request: Login.Login.Request)
}

struct LoginInteractor {
    // MARK: External properties
    var presenter: LoginPresentable?
}

// MARK: LoginLogic
extension LoginInteractor: LoginLogic {
    func getContent(_ request: Login.Content.Request) {
        presenter?.presentContent(.init())
    }
    
    func login(_ request: Login.Login.Request) {
        switch request.type {
        case .email(_, _):
            presenter?.presentDashboard(.init())
//            print(email)
//            print(paswword)
//            Firebase.auth.signIn(withEmail: email, password: password) { (result, error) in
//                if let result = result {
//                    Globals.userId = result.user.uid
//                    getUserData()
//                    presenter?.presentDashboard(.init())
//                } else if error != nil {
//                    presenter?.presentFailure(.init())
//                } else {
//                    Logger.log("Unknow error.")
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
    
    func getUserData() {
//        Firebase.users
//            .document(Globals.userId)
//            .getDocument(as: UserModel.self) { response in
//                Globals.userModel = try? response.get()
//        }
    }
}
