//
//  EventCreatorInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/01/2023.
//  Copyright © 2023 airPilot. All rights reserved.
//

import Foundation

protocol EventCreatorLogic {
    func getContent(_ request: EventCreator.Content.Request)
    func createOffer(_ request: EventCreator.CreateOffer.Request)
}

struct EventCreatorInteractor {
    // MARK: External properties
    var presenter: EventCreatorPresentable?
    var dataStore: EventCreator.DataStore
}

// MARK: EventCreatorLogic
extension EventCreatorInteractor: EventCreatorLogic {
    func getContent(_ request: EventCreator.Content.Request) {
        if let calendarId = dataStore.calendarId {
            Networker.sendRequest(
                response: EventCreator.Network.GetContent.Response.self,
                url: Endpoints.Calendars.group + calendarId.toString) { result in
                switch result {
                case .success(let response):
                    showContent(response)
                case .failure(let error):
                    Logger.log(error)
                }
            }
        } else {
            showContent(nil)
        }
    }
    
    func createOffer(_ request: EventCreator.CreateOffer.Request) {
        switch request.type {
        case .event:
            let createOfferRequest = setupCreateEventRequest(request)
            Networker.sendRequest(
                request: createOfferRequest,
                response: EventCreator.Network.CreateEvent.Response.self,
                url: Endpoints.Events.createEvent) { result in
                switch result {
                case .success(_):
                    presenter?.presentResult(.init(type: .success))
                case .failure(_):
                    presenter?.presentResult(.init(type: .failure))
                }
            }
        case .offerDuty:
            let createOfferRequest = setupCreateOfferDutyRequest(request)
            Networker.sendRequest(
                request: createOfferRequest,
                response: EventCreator.Network.CreateEvent.Response.self,
                url: Endpoints.Events.createOfferDuty) { result in
                switch result {
                case .success(_):
                    presenter?.presentResult(.init(type: .success))
                case .failure(_):
                    presenter?.presentResult(.init(type: .failure))
                }
            }
        default:
            let createOfferRequest = setupCreateOfferSearchRequest(request)
            Networker.sendRequest(
                request: createOfferRequest,
                response: EventCreator.Network.CreateEvent.Response.self,
                url: Endpoints.Events.createOfferSearch) { result in
                switch result {
                case .success(_):
                    presenter?.presentResult(.init(type: .success))
                case .failure(_):
                    presenter?.presentResult(.init(type: .failure))
                }
            }
        }
    }
}

// MARK: Private
private extension EventCreatorInteractor {
    func showContent(_ response: EventCreator.Network.GetContent.Response?) {
        guard let group = response as? GroupModel else {
            presenter?.presentContent(.init(group: nil))
            return
        }
        
        presenter?.presentContent(.init(group: group))
    }
    
    func setupCreateEventRequest(_ request: EventCreator.CreateOffer.Request) -> EventCreator.Network.CreateEvent.Request {
        return EventCreator.Network.CreateEvent.Request(
            type: .event,
            name: request.name,
            location: request.location,
            date: request.date,
            description: request.description,
            groupId: request.groupId.orZero)
    }
            
    func setupCreateOfferDutyRequest(_ request: EventCreator.CreateOffer.Request) -> EventCreator.Network.CreateOfferDuty.Request {
        return EventCreator.Network.CreateOfferDuty.Request(
            type: .offerDuty,
            departureDestinations: request.departureDestinations,
            position: request.postition,
            startDate: request.startDate,
            endDate: request.endDate,
            description: request.description,
            groupId: request.groupId.orZero)
    }
    
    func setupCreateOfferSearchRequest(_ request: EventCreator.CreateOffer.Request) -> EventCreator.Network.CreateOfferSearch.Request {
        return EventCreator.Network.CreateOfferSearch.Request(
            type: request.type,
            departure: request.departure,
            position: request.postition,
            date: request.date,
            description: request.description,
            groupId: request.groupId.orZero)
    }
}
