//
//  CompaniesInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol CompaniesLogic {
    func getContent(_ request: Companies.Content.Request)
}

struct CompaniesInteractor {
    // MARK: External properties
    var presenter: CompaniesPresentable?
    var dataStore: Companies.DataStore
}

// MARK: CompaniesLogic
extension CompaniesInteractor: CompaniesLogic {
    func getContent(_ request: Companies.Content.Request) {
        Networker.sendRequest(
            response: Companies.Network.GetContent.Response.self,
            url: Endpoints.Companies.companies) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}

// MARK: Private
private extension CompaniesInteractor {
    func showContent(_ response: Companies.Network.GetContent.Response?) {
        dataStore.companies = response as? [CompanyModel] ?? []
        presenter?.presentContent(.init(companies: dataStore.companies))
    }
}
