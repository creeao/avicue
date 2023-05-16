//
//  GroupCreatorPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol GroupCreatorPresentable {
    func presentContent(_ response: GroupCreator.Content.Response)
    func presentResult(_ response: GroupCreator.Result.Response)
}

struct GroupCreatorPresenter {
    // MARK: External properties
    var viewController: GroupCreatorDisplayable?
}

// MARK: GroupCreatorPresentable
extension GroupCreatorPresenter: GroupCreatorPresentable {
    func presentContent(_ response: GroupCreator.Content.Response) {
        viewController?.displayContent(.init())
    }
    
    func presentResult(_ response: GroupCreator.Result.Response) {
        var result = ResultModel(type: response.type)
        switch response.type {
        case .success:
            result.title = "Success"
            result.description = "Group and conversation created correctly"
        case .failure:
            result.title = "Failure"
            result.description = "Failed to create group"
        }
        
        viewController?.displayResult(.init(result: result))
    }
}
