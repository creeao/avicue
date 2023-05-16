//
//  EventCreatorPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/01/2023.
//  Copyright © 2023 ACC. All rights reserved.
//

import Foundation

protocol EventCreatorPresentable {
    func presentContent(_ response: EventCreator.Content.Response)
    func presentResult(_ response: EventCreator.Result.Response)
}

struct EventCreatorPresenter {
    // MARK: External properties
    var viewController: EventCreatorDisplayable?
}

// MARK: EventCreatorPresentable
extension EventCreatorPresenter: EventCreatorPresentable {
    func presentContent(_ response: EventCreator.Content.Response) {
        viewController?.displayContent(.init(group: response.group))
    }
    
    func presentResult(_ response: EventCreator.Result.Response) {
        var result = ResultModel(type: response.type)
        switch response.type {
        case .success:
            result.title = "Event created"
            result.description = "Your event is already visible in calendar"
        case .failure:
            result.title = "Event not created"
            result.description = "Your publication is already visible in the list of job offers"
        }
        
        viewController?.displayResult(.init(result: result))
    }
}
