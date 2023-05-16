//
//  SearchInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 20/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol SearchLogic {
    func getUsers(_ request: Search.Users.Request)
    func getCompanies(_ request: Search.Companies.Request)
    func getGroups(_ request: Search.Groups.Request)
}

struct SearchInteractor {
    // MARK: External properties
    var presenter: SearchPresentable?
    var dataStore: Search.DataStore
}

// MARK: SearchLogic
extension SearchInteractor: SearchLogic {
    func getUsers(_ request: Search.Users.Request) {
        Networker.sendRequest(
            response: Search.Network.GetUsers.Response.self,
            url: Endpoints.Users.users) { result in
            switch result {
            case .success(let response):
                dataStore.users = response as? [UserModel] ?? []
                presenter?.presentUsers(.init(users: dataStore.users))
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func getCompanies(_ request: Search.Companies.Request) {
        Networker.sendRequest(
            response: Search.Network.GetCompanies.Response.self,
            url: Endpoints.Companies.companies) { result in
            switch result {
            case .success(let response):
                dataStore.companies = response as? [CompanyModel] ?? []
                presenter?.presentCompanies(.init(companies: dataStore.companies))
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func getGroups(_ request: Search.Groups.Request) {
        Networker.sendRequest(
            response: Search.Network.GetGroups.Response.self,
            url: Endpoints.Groups.groups) { result in
            switch result {
            case .success(let response):
                dataStore.groups = response as? [GroupModel] ?? []
                presenter?.presentGroups(.init(groups: dataStore.groups))
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
}
