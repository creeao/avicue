//
//  CurrencyListInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol CurrencyListLogic {
    func getContent(_ request: CurrencyList.Content.Request)
}

struct CurrencyListInteractor {
    // MARK: External properties
    var presenter: CurrencyListPresentable?
    var dataStore: CurrencyList.DataStore
}

// MARK: CurrencyListLogic
extension CurrencyListInteractor: CurrencyListLogic {
    func getContent(_ request: CurrencyList.Content.Request) {
        Networker.sendRequest(
            request: CurrencyList.Network.GetContent.Request(),
            response: CurrencyList.Network.GetContent.Response.self,
            url: Endpoints.Default.url) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension CurrencyListInteractor {
    func showContent(_ response: CurrencyList.Network.GetContent.Response?) {
        presenter?.presentContent(.init())
    }
}
