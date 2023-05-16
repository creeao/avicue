//
//  JobOffersInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol JobOffersLogic {
    func getContent(_ request: JobOffers.Content.Request)
}

struct JobOffersInteractor {
    // MARK: External properties
    var presenter: JobOffersPresentable?
    var dataStore: JobOffers.DataStore
}

// MARK: JobOffersLogic
extension JobOffersInteractor: JobOffersLogic {
    func getContent(_ request: JobOffers.Content.Request) {
        let all = Endpoints.JobOffers.offers
        let category = (Endpoints.JobOffers.category + (request.category?.id).orZero.toString)
        let url = request.category.isNotNil ? category : all
        
        Networker.sendRequest(
            response: JobOffers.Network.GetContent.Response.self,
            url: url) { result in
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
private extension JobOffersInteractor {
    func showContent(_ response: JobOffers.Network.GetContent.Response?) {
        dataStore.offers = response as? [JobOfferModel] ?? []
        presenter?.presentContent(.init(offers: dataStore.offers))
    }
}
