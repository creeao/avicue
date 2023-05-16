//
//  EditCompanyProfilePresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 13/02/2023.
//  Copyright © 2023 ACC. All rights reserved.
//

import Foundation

protocol EditCompanyProfilePresentable {
    func presentContent(_ response: EditCompanyProfile.Content.Response)
    func presentResult(_ response: EditCompanyProfile.Result.Response)
}

struct EditCompanyProfilePresenter {
    // MARK: External properties
    var viewController: EditCompanyProfileDisplayable?
}

// MARK: EditCompanyProfilePresentable
extension EditCompanyProfilePresenter: EditCompanyProfilePresentable {
    func presentContent(_ response: EditCompanyProfile.Content.Response) {
        viewController?.displayContent(.init(profile: response.profile))
    }
    
    func presentResult(_ response: EditCompanyProfile.Result.Response) {
        var result = ResultModel(type: response.type)
        switch response.type {
        case .success:
            result.title = "Success"
            result.description = "Company details have been changed"
        case .failure:
            result.title = "Failure"
            result.description = "Company data has not been changed"
        }
        
        viewController?.displayResult(.init(result: result))
    }
}
