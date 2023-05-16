//
//  CompaniesPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol CompaniesPresentable {
    func presentContent(_ response: Companies.Content.Response)
}

struct CompaniesPresenter {
    // MARK: External properties
    var viewController: CompaniesDisplayable?
}

// MARK: CompaniesPresentable
extension CompaniesPresenter: CompaniesPresentable {
    func presentContent(_ response: Companies.Content.Response) {
        viewController?.displayContent(.init(companies: response.companies))
    }
}
