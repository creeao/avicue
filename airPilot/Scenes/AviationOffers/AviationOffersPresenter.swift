//
//  AviationOffersPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol AviationOffersPresentable {
    func presentContent(_ response: AviationOffers.Content.Response)
}

struct AviationOffersPresenter {
    // MARK: External properties
    var viewController: AviationOffersDisplayable?
}

// MARK: AviationOffersPresentable
extension AviationOffersPresenter: AviationOffersPresentable {
    func presentContent(_ response: AviationOffers.Content.Response) {
        viewController?.displayContent(.init())
    }
}
