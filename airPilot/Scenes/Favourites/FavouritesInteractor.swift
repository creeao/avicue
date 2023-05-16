//
//  FavouritesInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol FavouritesLogic {
    func getContent(_ request: Favourites.Content.Request)
    func tapFavouriteButton(_ request: Favourites.FavouriteAction.Request)
}

struct FavouritesInteractor {
    // MARK: External properties
    var presenter: FavouritesPresentable?
    var dataStore: Favourites.DataStore
}

// MARK: FavouritesLogic
extension FavouritesInteractor: FavouritesLogic {
    func getContent(_ request: Favourites.Content.Request) {
        switch dataStore.type {
        case .shopOffers:
            getFavouritesShopOffers()
        }
    }
    
    func tapFavouriteButton(_ request: Favourites.FavouriteAction.Request) {
        Networker.sendRequest(
            request: setupFavouriteActionRequest(request),
            response: Favourites.Network.FavouriteAction.Response.self,
            url: Endpoints.ShopOffers.favouriteAction) { result in
            switch result {
            case .success(let response):
                Logger.log(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension FavouritesInteractor {
    func getFavouritesShopOffers() {
        Networker.sendRequest(
            request: Favourites.Network.GetShopOffers.Request(),
            response: Favourites.Network.GetShopOffers.Response.self,
            url: Endpoints.ShopOffers.favourites) { result in
            switch result {
            case .success(let response):
                guard let shopOffers = response as? [ShopOfferModel] else { return }
                presenter?.presentContent(.init(shopOffers: shopOffers))
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func setupFavouriteActionRequest(_ request: Favourites.FavouriteAction.Request) -> Favourites.Network.FavouriteAction.Request {
        return Favourites.Network.FavouriteAction.Request(
            offerId: request.offerId,
            isFavourite: request.isFavourite)
    }
}
