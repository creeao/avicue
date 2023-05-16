//
//  CurrencyListPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol CurrencyListPresentable {
    func presentContent(_ response: CurrencyList.Content.Response)
}

struct CurrencyListPresenter {
    // MARK: External properties
    var viewController: CurrencyListDisplayable?
}

// MARK: CurrencyListPresentable
extension CurrencyListPresenter: CurrencyListPresentable {
    func presentContent(_ response: CurrencyList.Content.Response) {
        viewController?.displayContent(.init())
    }
}
