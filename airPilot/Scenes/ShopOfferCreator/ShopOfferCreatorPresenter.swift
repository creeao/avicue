//
//  ShopOfferCreatorPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol ShopOfferCreatorPresentable {
    func presentContent(_ response: ShopOfferCreator.Content.Response)
    func presentResult(_ response: ShopOfferCreator.Result.Response)
}

struct ShopOfferCreatorPresenter {
    // MARK: External properties
    var viewController: ShopOfferCreatorDisplayable?
}

// MARK: ShopOfferCreatorPresentable
extension ShopOfferCreatorPresenter: ShopOfferCreatorPresentable {
    func presentContent(_ response: ShopOfferCreator.Content.Response) {
        viewController?.displayContent(.init())
    }
    
    func presentResult(_ response: ShopOfferCreator.Result.Response) {
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
