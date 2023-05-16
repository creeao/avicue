//
//  SelectCategoryPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol SelectCategoryPresentable {
    func presentContent(_ response: SelectCategory.Content.Response)
}

struct SelectCategoryPresenter {
    // MARK: External properties
    var viewController: SelectCategoryDisplayable?
}

// MARK: SelectCategoryPresentable
extension SelectCategoryPresenter: SelectCategoryPresentable {
    func presentContent(_ response: SelectCategory.Content.Response) {
        viewController?.displayContent(.init(type: response.type, categories: response.categories))
    }
}
