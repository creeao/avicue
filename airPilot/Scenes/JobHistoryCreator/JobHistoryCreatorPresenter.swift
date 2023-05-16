//
//  JobHistoryCreatorPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol JobHistoryCreatorPresentable {
    func presentContent(_ response: JobHistoryCreator.Content.Response)
    func presentResult(_ response: JobHistoryCreator.AddJobHistory.Response)
}

struct JobHistoryCreatorPresenter {
    // MARK: External properties
    var viewController: JobHistoryCreatorDisplayable?
}

// MARK: JobHistoryCreatorPresentable
extension JobHistoryCreatorPresenter: JobHistoryCreatorPresentable {
    func presentContent(_ response: JobHistoryCreator.Content.Response) {
        viewController?.displayContent(.init())
    }
    
    func presentResult(_ response: JobHistoryCreator.AddJobHistory.Response) {
        var result = ResultModel(type: response.type)
        switch response.type {
        case .success:
            result.title = "Job history added"
            result.description = "Your job history is already visible in the profile list"
        case .failure:
            result.title = "Job history not added"
            result.description = "Your job history is already visible in the profile list"
        }
        
        viewController?.displayResult(.init(result: result))
    }
}
