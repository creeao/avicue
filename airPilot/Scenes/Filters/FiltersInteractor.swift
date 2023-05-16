//
//  FiltersInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol FiltersLogic {
    func getContent(_ request: Filters.Content.Request)
}

struct FiltersInteractor {
    // MARK: External properties
    var presenter: FiltersPresentable?
}

// MARK: FiltersLogic
extension FiltersInteractor: FiltersLogic {
    func getContent(_ request: Filters.Content.Request) {
        presenter?.presentContent(.init())
    }
}
