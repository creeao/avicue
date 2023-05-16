//
//  ProfilePresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol ProfilePresentable {
    func presentContent(_ response: Profile.Content.Response)
}

struct ProfilePresenter {
    // MARK: External properties
    var viewController: ProfileDisplayable?
}

// MARK: ProfilePresentable
extension ProfilePresenter: ProfilePresentable {
    func presentContent(_ response: Profile.Content.Response) {
        viewController?.displayContent(.init(profile: response.profile))
    }
}
