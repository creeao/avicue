//
//  EditProfilePresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol EditProfilePresentable {
    func presentContent(_ response: EditProfile.Content.Response)
    func presentResult(_ response: EditProfile.Result.Response)
}

struct EditProfilePresenter {
    // MARK: External properties
    var viewController: EditProfileDisplayable?
}

// MARK: EditProfilePresentable
extension EditProfilePresenter: EditProfilePresentable {
    func presentContent(_ response: EditProfile.Content.Response) {
        viewController?.displayContent(.init(currentInformations: response.currentInformations))
    }
    
    func presentResult(_ response: EditProfile.Result.Response) {
        var result = ResultModel(type: response.type)
        switch response.type {
        case .success:
            result.title = "Success"
            result.description = "Your details have been changed"
        case .failure:
            result.title = "Failure"
            result.description = "Your data has not been changed"
        }
        
        viewController?.displayResult(.init(result: result))
    }
}
