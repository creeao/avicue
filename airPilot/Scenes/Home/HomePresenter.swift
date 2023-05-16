//
//  HomePresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol HomePresentable {
    func presentContent(_ response: Home.Content.Response)
}

struct HomePresenter {
    // MARK: External properties
    var viewController: HomeDisplayable?
}

// MARK: HomePresentable
extension HomePresenter: HomePresentable {
    func presentContent(_ response: Home.Content.Response) {
        viewController?.displayContent(.init(activities: response.activities))
    }
}
