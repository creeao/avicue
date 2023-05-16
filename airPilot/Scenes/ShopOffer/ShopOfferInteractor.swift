//
//  ShopOfferInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol ShopOfferLogic {
    func getContent(_ request: ShopOffer.Content.Request)
    func tapFavouriteButton(_ request: ShopOffer.FavouriteAction.Request)
}

struct ShopOfferInteractor {
    // MARK: External properties
    var presenter: ShopOfferPresentable?
    var dataStore: ShopOffer.DataStore
}

// MARK: ShopOfferLogic
extension ShopOfferInteractor: ShopOfferLogic {
    func getContent(_ request: ShopOffer.Content.Request) {
        Networker.sendRequest(
            response: ShopOffer.Network.GetContent.Response.self,
            url: Endpoints.ShopOffers.offer + dataStore.id.toString) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func tapFavouriteButton(_ request: ShopOffer.FavouriteAction.Request) {
        Networker.sendRequest(
            request: setupFavouriteActionRequest(request),
            response: ShopOffer.Network.FavouriteAction.Response.self,
            url: Endpoints.ShopOffers.favouriteAction) { result in
            switch result {
            case .success(_): break
//                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension ShopOfferInteractor {
    func showContent(_ response: ShopOffer.Network.GetContent.Response?) {
        guard let offer = response as? ShopOfferModel else { return }
        presenter?.presentContent(.init(offer: offer))
    }
    
    func setupFavouriteActionRequest(_ request: ShopOffer.FavouriteAction.Request) -> ShopOffer.Network.FavouriteAction.Request {
        return ShopOffer.Network.FavouriteAction.Request(
            offerId: dataStore.id,
            isFavourite: request.isFavourite)
    }
}
