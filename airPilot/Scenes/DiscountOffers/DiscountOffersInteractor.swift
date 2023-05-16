//
//  DiscountOffersInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol DiscountOffersLogic {
    func getContent(_ request: DiscountOffers.Content.Request)
}

struct DiscountOffersInteractor {
    // MARK: External properties
    var presenter: DiscountOffersPresentable?
    var dataStore: DiscountOffers.DataStore
}

// MARK: DiscountOffersLogic
extension DiscountOffersInteractor: DiscountOffersLogic {
    func getContent(_ request: DiscountOffers.Content.Request) {
        Networker.sendRequest(
            response: DiscountOffers.Network.GetContent.Response.self,
            url: Endpoints.DiscountOffers.offers) { result in
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
private extension DiscountOffersInteractor {
    func showContent(_ response: DiscountOffers.Network.GetContent.Response?) {
        dataStore.offers = response as? [DiscountOfferModel] ?? []
        presenter?.presentContent(.init(offers: dataStore.offers))
    }
}
