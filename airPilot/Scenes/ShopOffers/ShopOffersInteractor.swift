//
//  ShopOffersInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol ShopOffersLogic {
    func getContent(_ request: ShopOffers.Content.Request)
    func selectCategory(_ request: ShopOffers.SelectCategory.Request)
    func tapFavouriteButton(_ request: ShopOffers.FavouriteAction.Request)
}

struct ShopOffersInteractor {
    // MARK: External properties
    var presenter: ShopOffersPresentable?
    var dataStore: ShopOffers.DataStore
}

// MARK: ShopOffersLogic
extension ShopOffersInteractor: ShopOffersLogic {
    func getContent(_ request: ShopOffers.Content.Request) {
        let all = Endpoints.ShopOffers.offers
        let category = (Endpoints.ShopOffers.category + (request.category?.id).orZero.toString)
        let url = request.category.isNotNil ? category : all
        
        Networker.sendRequest(
            response: ShopOffers.Network.GetContent.Response.self,
            url: url) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func selectCategory(_ request: ShopOffers.SelectCategory.Request) {
        dataStore.selectedCategory = request.category
        
        Networker.sendRequest(
            response: ShopOffers.Network.GetContent.Response.self,
            url: Endpoints.ShopOffers.Categories.category + (dataStore.selectedCategory?.name).orEmpty) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func tapFavouriteButton(_ request: ShopOffers.FavouriteAction.Request) {
        Networker.sendRequest(
            request: setupFavouriteActionRequest(request),
            response: ShopOffers.Network.FavouriteAction.Response.self,
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
private extension ShopOffersInteractor {
    func showContent(_ response: ShopOffers.Network.GetContent.Response?) {
        dataStore.offers = response as? [ShopOfferModel] ?? []
        presenter?.presentContent(.init(offers: dataStore.offers))
    }
    
    func setupFavouriteActionRequest(_ request: ShopOffers.FavouriteAction.Request) -> ShopOffers.Network.FavouriteAction.Request {
        return ShopOffers.Network.FavouriteAction.Request(
            offerId: request.offerId,
            isFavourite: request.isFavourite)
    }
}
