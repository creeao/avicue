//
//  CompanyPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol CompanyPresentable {
    func presentContent(_ response: Company.Content.Response)
}

struct CompanyPresenter {
    // MARK: External properties
    var viewController: CompanyDisplayable?
}

// MARK: CompanyPresentable
extension CompanyPresenter: CompanyPresentable {
    func presentContent(_ response: Company.Content.Response) {
        let viewModel = Company.Content.ViewModel(profile: response.profile)
        viewController?.displayContent(viewModel)
    }
}

// MARK: Private
private extension CompanyPresenter {
//    func setupInformations(from offer: CompanyModel) -> [InformationModel] {
//        var informations = [
//            InformationModel(
//                title: "Location",
//                description: offer.location),
//            InformationModel(
//                title: "Creation date",
//                description: offer.creationDate),
//            InformationModel(
//                title: "Employees",
//                description: (offer.employeesCount.orEmpty + String.space + "people")),
//            InformationModel(
//                title: "Employed friends",
//                description: (offer.employedFriendsCount.orEmpty + String.space + "people"))
//        ]
//
//        informations.removeAll(where: { $0.description.isNil })
//        return informations
//    }
}
