//
//  CompanyInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol CompanyLogic {
    func getContent(_ request: Company.Content.Request)
    func actionOnCompany(_ request: Company.ActionOnCompany.Request)
    func tapFavouriteButton(_ request: Company.FavouriteAction.Request)
}

struct CompanyInteractor {
    // MARK: External properties
    var presenter: CompanyPresentable?
    var dataStore: Company.DataStore
}

// MARK: CompanyLogic
extension CompanyInteractor: CompanyLogic {
    func getContent(_ request: Company.Content.Request) {
        Networker.sendRequest(
            response: Company.Network.GetContent.Response.self,
            url: Endpoints.Companies.Profile.profile + dataStore.companyId.toString) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func actionOnCompany(_ request: Company.ActionOnCompany.Request) {
        Networker.sendRequest(
            request: setupActionOnCompanyRequest(request),
            response: Company.Network.ActionOnCompany.Response.self,
            url: Endpoints.Companies.actionOnCompany) { result in
            switch result {
            case .success(let response):
                Logger.log(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func tapFavouriteButton(_ request: Company.FavouriteAction.Request) {
        Networker.sendRequest(
            request: setupFavouriteActionRequest(request),
            response: Company.Network.FavouriteAction.Response.self,
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
private extension CompanyInteractor {
    func showContent(_ response: Company.Network.GetContent.Response?) {
        guard let profile = response as? CompanyProfileModel else { return }
        presenter?.presentContent(.init(profile: profile))
    }
    
    func setupActionOnCompanyRequest(_ request: Company.ActionOnCompany.Request) -> Company.Network.ActionOnCompany.Request {
        return Company.Network.ActionOnCompany.Request(
            companyId: dataStore.companyId,
            type: request.actionOnCompany)
    }
    
    func setupFavouriteActionRequest(_ request: Company.FavouriteAction.Request) -> Company.Network.FavouriteAction.Request {
        return Company.Network.FavouriteAction.Request(
            offerId: request.offerId,
            isFavourite: request.isFavourite)
    }
}
