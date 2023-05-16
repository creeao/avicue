//
//  EditProfileInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileLogic {
    func getContent(_ request: EditProfile.Content.Request)
    func saveChanges(_ request: EditProfile.SaveChanges.Request)
    func changeAvatar(_ request: EditProfile.ChangeAvatar.Request)
    func changeBackground(_ request: EditProfile.ChangeBackground.Request)
    func removeJobHistory(_ request: EditProfile.RemoveJobHistory.Request)
}

struct EditProfileInteractor {
    // MARK: External properties
    var presenter: EditProfilePresentable?
    var dataStore: EditProfile.DataStore
}

// MARK: EditProfileLogic
extension EditProfileInteractor: EditProfileLogic {
    func getContent(_ request: EditProfile.Content.Request) {
        Networker.sendRequest(
            response: EditProfile.Network.GetContent.Response.self,
            url: Endpoints.Users.userProfile + Globals.userUuid) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func getHeadline(_ request: EditProfile.SaveChanges.Request) {
        Networker.sendRequest(
            response: EditProfile.Network.SaveChanges.Response.self,
            url: Endpoints.Users.Profile.editProfile) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
    
    func saveChanges(_ request: EditProfile.SaveChanges.Request) {
        Networker.sendRequest(
            request: setupSaveChangesRequest(request),
            response: EditProfile.Network.SaveChanges.Response.self,
            url: Endpoints.Users.Profile.editProfile) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
    
    func changeAvatar(_ request: EditProfile.ChangeAvatar.Request) {
        Networker.sendRequest(
            request: EditProfile.Network.ChangeAvatar.Request(),
            response: EditProfile.Network.ChangeAvatar.Response.self,
            isFile: true,
            images: UIImage.getImagesInCorrectSize([request.image]),
            url: Endpoints.Users.addAvatar) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
    
    func changeBackground(_ request: EditProfile.ChangeBackground.Request) {
        Networker.sendRequest(
            request: EditProfile.Network.ChangeBackground.Request(),
            response: EditProfile.Network.ChangeBackground.Response.self,
            isFile: true,
            images: UIImage.getImagesInCorrectSize([request.image]),
            url: Endpoints.Users.addBackground) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
    
    func removeJobHistory(_ request: EditProfile.RemoveJobHistory.Request) {
        Networker.sendRequest(
            request: setupRemoveHistoryRequest(request),
            response: EditProfile.Network.RemoveJobHistory.Response.self,
            url: Endpoints.Users.Profile.JobHistory.removeJobHistory)  { result in
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
private extension EditProfileInteractor {
    func showContent(_ response: EditProfile.Network.GetContent.Response?) {
        guard let currentInformations = response as? ProfileModel else { return }
        presenter?.presentContent(.init(currentInformations: currentInformations))
    }
    
    func setupSaveChangesRequest(_ request: EditProfile.SaveChanges.Request) -> EditProfile.Network.SaveChanges.Request {
        return EditProfile.Network.SaveChanges.Request(
            firstName: request.firstName,
            lastName: request.lastName,
            headline: request.headline,
            email: request.email
        )
    }
    
    func setupRemoveHistoryRequest(_ request: EditProfile.RemoveJobHistory.Request) -> EditProfile.Network.RemoveJobHistory.Request {
        return EditProfile.Network.RemoveJobHistory.Request(
            jobHistoryId: request.id
        )
    }
}
