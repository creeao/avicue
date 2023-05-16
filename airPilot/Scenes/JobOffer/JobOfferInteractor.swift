//
//  JobOfferInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol JobOfferLogic {
    func getContent(_ request: JobOffer.Content.Request)
}

struct JobOfferInteractor {
    // MARK: External properties
    var presenter: JobOfferPresentable?
    var dataStore: JobOffer.DataStore
}

// MARK: JobOfferLogic
extension JobOfferInteractor: JobOfferLogic {
    func getContent(_ request: JobOffer.Content.Request) {
        Networker.sendRequest(
            response: JobOffer.Network.GetContent.Response.self,
            url: Endpoints.JobOffers.offer + dataStore.id.toString) { result in
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
private extension JobOfferInteractor {
    func showContent(_ response: JobOffer.Network.GetContent.Response?) {
        guard let offerModel = response as? JobOfferModel else { return }
        let response = JobOffer.Content.Response(
            offer: offerModel,
            informations: Mocks.jobInformations,
            description: Mocks.loremIpsum)
        presenter?.presentContent(response)
    }
}
