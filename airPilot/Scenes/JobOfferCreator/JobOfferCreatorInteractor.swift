//
//  JobOfferCreatorInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol JobOfferCreatorLogic {
    func getContent(_ request: JobOfferCreator.Content.Request)
    func createOffer(_ request: JobOfferCreator.CreateOffer.Request)
}

struct JobOfferCreatorInteractor {
    // MARK: External properties
    var presenter: JobOfferCreatorPresentable?
    var dataStore: JobOfferCreator.DataStore
}

// MARK: JobOfferCreatorLogic
extension JobOfferCreatorInteractor: JobOfferCreatorLogic {
    func getContent(_ request: JobOfferCreator.Content.Request) {
        Networker.sendRequest(
            response: JobOfferCreator.Network.GetContent.Response.self,
            url: Endpoints.Default.url) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func createOffer(_ request: JobOfferCreator.CreateOffer.Request) {
        Networker.sendRequest(
            request: setupCreateOfferRequest(request),
            response: JobOfferCreator.Network.CreateOffer.Response.self,
            url: Endpoints.JobOffers.create) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
}

// MARK: Private
private extension JobOfferCreatorInteractor {
    func showContent(_ response: JobOfferCreator.Network.GetContent.Response?) {
        presenter?.presentContent(.init())
    }
    
    func setupCreateOfferRequest(_ request: JobOfferCreator.CreateOffer.Request) -> JobOfferCreator.Network.CreateOffer.Request {
        return JobOfferCreator.Network.CreateOffer.Request(
            position: request.position,
            category: request.category,
            minSalary: request.minSalary?.getOptionalDouble(),
            maxSalary: request.maxSalary?.getOptionalDouble(),
            currency: request.currency,
            startDate: nil,
            endDate: nil,
            text: request.text,
            assignedTo: request.assignedTo
        )
    }
}
