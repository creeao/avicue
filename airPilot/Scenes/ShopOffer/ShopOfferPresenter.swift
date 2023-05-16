//
//  ShopOfferPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol ShopOfferPresentable {
    func presentContent(_ response: ShopOffer.Content.Response)
}

struct ShopOfferPresenter {
    // MARK: External properties
    var viewController: ShopOfferDisplayable?
}

// MARK: ShopOfferPresentable
extension ShopOfferPresenter: ShopOfferPresentable {
    func presentContent(_ response: ShopOffer.Content.Response) {
        viewController?.displayContent(.init(
            offer: response.offer,
            informations: setupInformations(from: response.offer)))
    }
}

// MARK: Private
private extension ShopOfferPresenter {
    func setupInformations(from offer: ShopOfferModel) -> [InformationModel] {
        var informations = [
            InformationModel(
                title: "Price",
                description: setupPrice(from: offer)),
            InformationModel(
                title: "Country",
                description: offer.country),
            InformationModel(
                title: "City",
                description: offer.city),
            InformationModel(
                title: "Street",
                description: offer.street)
        ]
        
        informations.removeAll(where: { $0.description.isNil })
        return informations
    }
    
    func setupPrice(from offer: ShopOfferModel) -> String {
        guard let price = offer.price, let currency = offer.currency, let type = offer.type else {
            return String.empty
        }
        
        return price.getAmount(with: currency) + type.getText()
    }
}
                                                         
