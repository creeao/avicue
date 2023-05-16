//
//  AviationOfferPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol AviationOfferPresentable {
    func presentContent(_ response: AviationOffer.Content.Response)
}

struct AviationOfferPresenter {
    // MARK: External properties
    var viewController: AviationOfferDisplayable?
}

// MARK: AviationOfferPresentable
extension AviationOfferPresenter: AviationOfferPresentable {
    func presentContent(_ response: AviationOffer.Content.Response) {
        viewController?.displayContent(.init(offer: response.offer))
    }
}
