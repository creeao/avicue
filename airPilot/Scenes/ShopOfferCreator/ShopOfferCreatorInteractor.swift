//
//  ShopOfferCreatorInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation
import UIKit

protocol ShopOfferCreatorLogic {
    func getContent(_ request: ShopOfferCreator.Content.Request)
    func createOffer(_ request: ShopOfferCreator.CreateOffer.Request)
}

struct ShopOfferCreatorInteractor {
    // MARK: External properties
    var presenter: ShopOfferCreatorPresentable?
    var dataStore: ShopOfferCreator.DataStore
}

// MARK: ShopOfferCreatorLogic
extension ShopOfferCreatorInteractor: ShopOfferCreatorLogic {
    func getContent(_ request: ShopOfferCreator.Content.Request) {
        Networker.sendRequest(
            response: ShopOfferCreator.Network.GetContent.Response.self,
            url: Endpoints.Default.url) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func createOffer(_ request: ShopOfferCreator.CreateOffer.Request) {
        setupCreateOfferRequest(request)
        Networker.sendRequest(
            request: dataStore.request,
            response: ShopOfferCreator.Network.CreateOffer.Response.self,
            images: UIImage.getImagesInCorrectSize(request.images.orEmpty),
            url: Endpoints.ShopOffers.create) { result in
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
private extension ShopOfferCreatorInteractor {
    func showContent(_ response: ShopOfferCreator.Network.GetContent.Response?) {
        presenter?.presentContent(.init())
    }
    
    func setupCreateOfferRequest(_ request: ShopOfferCreator.CreateOffer.Request) {
        dataStore.request = .init(
            name: request.name,
            category: 1,
            type: request.type,
            price: request.price?.getOptionalDecimal(),
            currency: request.currency,
            startDate: nil,
            endDate: nil,
            text: request.text,
            assignedTo: request.assignedTo)
    }
}
