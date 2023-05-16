//
//  DiscountOfferPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol DiscountOfferPresentable {
    func presentContent(_ response: DiscountOffer.Content.Response)
}

struct DiscountOfferPresenter {
    // MARK: External properties
    var viewController: DiscountOfferDisplayable?
}

// MARK: DiscountOfferPresentable
extension DiscountOfferPresenter: DiscountOfferPresentable {
    func presentContent(_ response: DiscountOffer.Content.Response) {
        viewController?.displayContent(.init(offer: response.offer))
    }
}
