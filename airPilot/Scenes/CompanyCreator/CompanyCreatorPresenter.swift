//
//  CompanyCreatorPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol CompanyCreatorPresentable {
    func presentContent(_ response: CompanyCreator.Content.Response)
    func presentResult(_ response: CompanyCreator.Result.Response)
}

struct CompanyCreatorPresenter {
    // MARK: External properties
    var viewController: CompanyCreatorDisplayable?
}

// MARK: CompanyCreatorPresentable
extension CompanyCreatorPresenter: CompanyCreatorPresentable {
    func presentContent(_ response: CompanyCreator.Content.Response) {
        viewController?.displayContent(.init())
    }
    
    func presentResult(_ response: CompanyCreator.Result.Response) {
        var result = ResultModel(type: response.type)
        switch response.type {
        case .success:
            result.title = "Success"
            result.description = "Company created correctly"
        case .failure:
            result.title = "Failure"
            result.description = "Failed to create company"
        }
        
        viewController?.displayResult(.init(result: result))
    }
}
