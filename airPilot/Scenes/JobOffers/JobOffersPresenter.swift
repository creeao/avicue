//
//  JobOffersPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol JobOffersPresentable {
    func presentContent(_ response: JobOffers.Content.Response)
}

struct JobOffersPresenter {
    // MARK: External properties
    var viewController: JobOffersDisplayable?
}

// MARK: JobOffersPresentable
extension JobOffersPresenter: JobOffersPresentable {
    func presentContent(_ response: JobOffers.Content.Response) {
        viewController?.displayContent(.init(offers: response.offers))
    }
}
