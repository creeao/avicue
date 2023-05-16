//
//  ResultScreenInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol ResultScreenLogic {
    func getContent(_ request: ResultScreen.Content.Request)
}

struct ResultScreenInteractor {
    // MARK: External properties
    var presenter: ResultScreenPresentable?
    var dataStore: ResultScreen.DataStore
}

// MARK: ResultScreenLogic
extension ResultScreenInteractor: ResultScreenLogic {
    func getContent(_ request: ResultScreen.Content.Request) {
        presenter?.presentContent(.init(result: dataStore.result))
    }
}
