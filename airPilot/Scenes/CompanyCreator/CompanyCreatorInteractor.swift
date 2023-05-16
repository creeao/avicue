//
//  CompanyCreatorInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol CompanyCreatorLogic {
    func getContent(_ request: CompanyCreator.Content.Request)
    func createCompany(_ request: CompanyCreator.CreateCompany.Request)
}

struct CompanyCreatorInteractor {
    // MARK: External properties
    var presenter: CompanyCreatorPresentable?
    var dataStore: CompanyCreator.DataStore
}

// MARK: CompanyCreatorLogic
extension CompanyCreatorInteractor: CompanyCreatorLogic {
    func getContent(_ request: CompanyCreator.Content.Request) {
        Networker.sendRequest(
            request: CompanyCreator.Network.GetContent.Request(),
            response: CompanyCreator.Network.GetContent.Response.self,
            url: Endpoints.Default.url) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func createCompany(_ request: CompanyCreator.CreateCompany.Request) {
        Networker.sendRequest(
            request: setupCreateCompanyRequest(request),
            response: GroupCreator.Network.GetContent.Response.self,
            url: Endpoints.Companies.createCompany) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
}

// MARK: Private
private extension CompanyCreatorInteractor {
    func showContent(_ response: CompanyCreator.Network.GetContent.Response?) {
        presenter?.presentContent(.init())
    }
    
    func setupCreateCompanyRequest(_ request: CompanyCreator.CreateCompany.Request) -> CompanyCreator.Network.CreateCompany.Request {
        return CompanyCreator.Network.CreateCompany.Request(
            name: request.name,
            headline: request.headline,
            website: request.website
        )
    }
}
