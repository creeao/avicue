//
//  ResultScreenPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol ResultScreenPresentable {
    func presentContent(_ response: ResultScreen.Content.Response)
}

struct ResultScreenPresenter {
    // MARK: External properties
    var viewController: ResultScreenDisplayable?
}

// MARK: ResultScreenPresentable
extension ResultScreenPresenter: ResultScreenPresentable {
    func presentContent(_ response: ResultScreen.Content.Response) {
        viewController?.displayContent(.init(result: response.result))
    }
}
