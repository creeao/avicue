//
//  DiscountOfferInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol DiscountOfferLogic {
    func getContent(_ request: DiscountOffer.Content.Request)
}

struct DiscountOfferInteractor {
    // MARK: External properties
    var presenter: DiscountOfferPresentable?
    var dataStore: DiscountOffer.DataStore
}

// MARK: DiscountOfferLogic
extension DiscountOfferInteractor: DiscountOfferLogic {
    func getContent(_ request: DiscountOffer.Content.Request) {
        Networker.sendRequest(
            request: DiscountOffer.Network.GetContent.Request(),
            response: DiscountOffer.Network.GetContent.Response.self,
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
private extension DiscountOfferInteractor {
    func showContent(_ response: DiscountOffer.Network.GetContent.Response?) {
        guard let offerModel = response as? DiscountOfferModel else { return }
        presenter?.presentContent(.init(offer: offerModel))
    }
}
