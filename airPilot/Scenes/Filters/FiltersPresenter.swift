//
//  FiltersPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol FiltersPresentable {
    func presentContent(_ response: Filters.Content.Response)
}

struct FiltersPresenter {
    // MARK: External properties
    var viewController: FiltersDisplayable?
}

// MARK: FiltersPresentable
extension FiltersPresenter: FiltersPresentable {
    func presentContent(_ response: Filters.Content.Response) {
        viewController?.displayContent(.init())
    }
}
