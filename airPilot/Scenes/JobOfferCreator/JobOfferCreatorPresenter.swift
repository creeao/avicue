//
//  JobOfferCreatorPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol JobOfferCreatorPresentable {
    func presentContent(_ response: JobOfferCreator.Content.Response)
    func presentResult(_ response: JobOfferCreator.Result.Response)
}

struct JobOfferCreatorPresenter {
    // MARK: External properties
    var viewController: JobOfferCreatorDisplayable?
}

// MARK: JobOfferCreatorPresentable
extension JobOfferCreatorPresenter: JobOfferCreatorPresentable {
    func presentContent(_ response: JobOfferCreator.Content.Response) {
        viewController?.displayContent(.init())
    }
    
    func presentResult(_ response: JobOfferCreator.Result.Response) {
        var result = ResultModel(type: response.type)
        switch response.type {
        case .success:
            result.title = "Offer added"
            result.description = "Your publication is already visible in the list of job offers"
        case .failure:
            result.title = "Offer added"
            result.description = "Your publication is already visible in the list of job offers"
        }
        
        viewController?.displayResult(.init(result: result))
    }
}
