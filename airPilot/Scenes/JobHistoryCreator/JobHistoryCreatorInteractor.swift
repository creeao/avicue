//
//  JobHistoryCreatorInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol JobHistoryCreatorLogic {
    func getContent(_ request: JobHistoryCreator.Content.Request)
    func addJobHistory(_ request: JobHistoryCreator.AddJobHistory.Request)
}

struct JobHistoryCreatorInteractor {
    // MARK: External properties
    var presenter: JobHistoryCreatorPresentable?
    var dataStore: JobHistoryCreator.DataStore
}

// MARK: JobHistoryCreatorLogic
extension JobHistoryCreatorInteractor: JobHistoryCreatorLogic {
    func getContent(_ request: JobHistoryCreator.Content.Request) {}
    
    func addJobHistory(_ request: JobHistoryCreator.AddJobHistory.Request) {
        Networker.sendRequest(
            request: setupAddJobHistoryRequest(request),
            response: ShopOfferCreator.Network.CreateOffer.Response.self,
            url: Endpoints.Users.Profile.JobHistory.addJobHistory) { result in
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
private extension JobHistoryCreatorInteractor {
    func setupAddJobHistoryRequest(_ request: JobHistoryCreator.AddJobHistory.Request) -> JobHistoryCreator.Network.AddJobHistory.Request {
        return JobHistoryCreator.Network.AddJobHistory.Request(
            assignedTo: request.assignedTo,
            position: request.position,
            startDate: request.startDate,
            endDate: request.endDate)
    }
}
