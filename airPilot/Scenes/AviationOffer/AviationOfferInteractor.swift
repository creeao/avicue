//
//  AviationOfferInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol AviationOfferLogic {
    func getContent(_ request: AviationOffer.Content.Request)
}

struct AviationOfferInteractor {
    // MARK: External properties
    var presenter: AviationOfferPresentable?
    var dataStore: AviationOffer.DataStore
}

// MARK: AviationOfferLogic
extension AviationOfferInteractor: AviationOfferLogic {
    func getContent(_ request: AviationOffer.Content.Request) {
        Networker.sendRequest(
            response: AviationOffer.Network.GetContent.Response.self,
            url: Endpoints.AviationOffers.offer + dataStore.id.toString) { result in
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
private extension AviationOfferInteractor {
    func showContent(_ response: AviationOffer.Network.GetContent.Response?) {
        guard let offerModel = response as? AviationOfferModel else { return }
        presenter?.presentContent(.init(offer: offerModel))
    }
}
