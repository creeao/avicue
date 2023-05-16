//
//  EditCompanyProfileInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 13/02/2023.
//  Copyright © 2023 airPilot. All rights reserved.
//

import Foundation
import UIKit

protocol EditCompanyProfileLogic {
    func getContent(_ request: EditCompanyProfile.Content.Request)
    func saveChanges(_ request: EditCompanyProfile.SaveChanges.Request)
    func changeLogo(_ request: EditCompanyProfile.ChangeLogo.Request)
    func changeBackground(_ request: EditCompanyProfile.ChangeBackground.Request)
}

struct EditCompanyProfileInteractor {
    // MARK: External properties
    var presenter: EditCompanyProfilePresentable?
    var dataStore: EditCompanyProfile.DataStore
}

// MARK: EditCompanyProfileLogic
extension EditCompanyProfileInteractor: EditCompanyProfileLogic {
    func getContent(_ request: EditCompanyProfile.Content.Request) {
        Networker.sendRequest(
            response: EditCompanyProfile.Network.GetContent.Response.self,
            url: Endpoints.Companies.Profile.profile + dataStore.companyId.toString) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func saveChanges(_ request: EditCompanyProfile.SaveChanges.Request) {
        Networker.sendRequest(
            request: setupSaveChangesRequest(request),
            response: EditCompanyProfile.Network.SaveChanges.Response.self,
            url: Endpoints.Companies.Profile.edit) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
    
    func changeLogo(_ request: EditCompanyProfile.ChangeLogo.Request) {
        Networker.sendRequest(
            request: EditCompanyProfile.Network.ChangeLogo.Request(companyId: dataStore.companyId),
            response: EditCompanyProfile.Network.ChangeLogo.Response.self,
            isFile: true,
            images: UIImage.getImagesInCorrectSize([request.image]),
            url: Endpoints.Companies.EditProfile.changeLogo) { result in
            switch result {
            case .success(_):
                presenter?.presentResult(.init(type: .success))
            case .failure(_):
                presenter?.presentResult(.init(type: .failure))
            }
        }
    }
    
    func changeBackground(_ request: EditCompanyProfile.ChangeBackground.Request) {
        Networker.sendRequest(
            request: EditCompanyProfile.Network.ChangeBackground.Request(companyId: dataStore.companyId),
            response: EditCompanyProfile.Network.ChangeBackground.Response.self,
            isFile: true,
            images: UIImage.getImagesInCorrectSize([request.image]),
            url: Endpoints.Companies.EditProfile.changeBackground) { result in
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
private extension EditCompanyProfileInteractor {
    func showContent(_ response: EditCompanyProfile.Network.GetContent.Response?) {
        guard let profile = response as? CompanyProfileModel else { return }
        presenter?.presentContent(.init(profile: profile))
    }
    
    func setupSaveChangesRequest(_ request: EditCompanyProfile.SaveChanges.Request) -> EditCompanyProfile.Network.SaveChanges.Request {
        return EditCompanyProfile.Network.SaveChanges.Request(
            companyId: dataStore.companyId,
            name: request.name,
            headline: request.headline,
            website: request.website)
    }
}
