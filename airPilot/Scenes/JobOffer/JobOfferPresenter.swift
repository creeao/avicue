//
//  JobOfferPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol JobOfferPresentable {
    func presentContent(_ response: JobOffer.Content.Response)
}

struct JobOfferPresenter {
    // MARK: External properties
    var viewController: JobOfferDisplayable?
}

// MARK: JobOfferPresentable
extension JobOfferPresenter: JobOfferPresentable {
    func presentContent(_ response: JobOffer.Content.Response) {
        let viewModel = JobOffer.Content.ViewModel(
            offer: response.offer,
            informations: response.informations,
            description: response.description)
        viewController?.displayContent(viewModel)
    }
}
