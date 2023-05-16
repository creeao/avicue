//
//  SelectCategoryInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol SelectCategoryLogic {
    func getContent(_ request: SelectCategory.Content.Request)
}

struct SelectCategoryInteractor {
    // MARK: External properties
    var presenter: SelectCategoryPresentable?
    var dataStore: SelectCategory.DataStore
}

// MARK: SelectCategoryLogic
extension SelectCategoryInteractor: SelectCategoryLogic {
    func getContent(_ request: SelectCategory.Content.Request) {
        if dataStore.category.isNil {
            getMainCategories()
        } else {
            getSubcategories(with: (dataStore.category?.id).orZero)
        }
    }
}

// MARK: Private
private extension SelectCategoryInteractor {
    func getMainCategories() {
        Networker.sendRequest(
            response: SelectCategory.Network.GetContent.Response.self,
            url: dataStore.type == .shop ? Endpoints.ShopOffers.Categories.categories : Endpoints.JobOffers.Categories.categories) { result in
                switch result {
                case .success(let response):
                    showContent(response)
                case .failure(let error):
                    Logger.log(error)
                }
            }
    }
    
    func getSubcategories(with id: Int) {
        Networker.sendRequest(
            response: SelectCategory.Network.GetContent.Response.self,
            url: (dataStore.type == .shop ? Endpoints.ShopOffers.Categories.subcategories : Endpoints.JobOffers.Categories.subcategories) + id.toString) { result in
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
private extension SelectCategoryInteractor {
    func showContent(_ response: SelectCategory.Network.GetContent.Response?) {
        dataStore.categories = response as? [Category] ?? []
        presenter?.presentContent(.init(type: dataStore.type, categories: dataStore.categories))
    }
    
    func setupCreateOfferRequest(_ request: JobOfferCreator.CreateOffer.Request) {
//        dataStore.request = .init(
//            position: request.position,
//            category: request.category,
//            minSalary: request.minSalary?.getOptionalDouble(),
//            maxSalary: request.maxSalary?.getOptionalDouble(),
//            currency: request.currency,
//            startDate: nil,
//            endDate: nil,
//            text: request.text,
//            createdBy: Globals.userId,
//            assignedTo: request.assignedTo)
    }
}
