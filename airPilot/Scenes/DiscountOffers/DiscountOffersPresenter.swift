//
//  DiscountOffersPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol DiscountOffersPresentable {
    func presentContent(_ response: DiscountOffers.Content.Response)
}

struct DiscountOffersPresenter {
    // MARK: External properties
    var viewController: DiscountOffersDisplayable?
}

// MARK: DiscountOffersPresentable
extension DiscountOffersPresenter: DiscountOffersPresentable {
    func presentContent(_ response: DiscountOffers.Content.Response) {
        viewController?.displayContent(.init(offers: response.offers))
    }
}
