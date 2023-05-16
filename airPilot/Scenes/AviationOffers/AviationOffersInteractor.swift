//
//  AviationOffersInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol AviationOffersLogic {
    func getContent(_ request: AviationOffers.Content.Request)
}

struct AviationOffersInteractor {
    // MARK: External properties
    var presenter: AviationOffersPresentable?
    var dataStore: AviationOffers.DataStore
}

// MARK: AviationOffersLogic
extension AviationOffersInteractor: AviationOffersLogic {
    func getContent(_ request: AviationOffers.Content.Request) {
        Networker.sendRequest(
            response: AviationOffers.Network.GetContent.Response.self,
            url: Endpoints.AviationOffers.offers) { result in
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
private extension AviationOffersInteractor {
    func showContent(_ response: AviationOffers.Network.GetContent.Response?) {
        presenter?.presentContent(.init())
    }
}
