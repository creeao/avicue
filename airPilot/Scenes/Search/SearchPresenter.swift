//
//  SearchPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 20/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol SearchPresentable {
    func presentUsers(_ response: Search.Users.Response)
    func presentCompanies(_ response: Search.Companies.Response)
    func presentGroups(_ response: Search.Groups.Response)
}

struct SearchPresenter {
    // MARK: External properties
    var viewController: SearchDisplayable?
}

// MARK: SearchPresentable
extension SearchPresenter: SearchPresentable {
    func presentUsers(_ response: Search.Users.Response) {
        viewController?.displayUsers(.init(users: response.users))
    }
    
    func presentCompanies(_ response: Search.Companies.Response) {
        viewController?.displayCompanies(.init(companies: response.companies))
    }
    
    func presentGroups(_ response: Search.Groups.Response) {
        viewController?.displayGroups(.init(groups: response.groups))
    }
}
