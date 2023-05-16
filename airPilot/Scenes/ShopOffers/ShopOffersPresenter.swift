//
//  ShopOffersPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol ShopOffersPresentable {
    func presentContent(_ response: ShopOffers.Content.Response)
}

struct ShopOffersPresenter {
    // MARK: External properties
    var viewController: ShopOffersDisplayable?
}

// MARK: ShopOffersPresentable
extension ShopOffersPresenter: ShopOffersPresentable {
    func presentContent(_ response: ShopOffers.Content.Response) {
        viewController?.displayContent(.init(offers: response.offers))
    }
}
