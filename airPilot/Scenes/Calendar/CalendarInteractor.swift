//
//  CalendarInteractor.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol CalendarLogic {
    func getContent(_ request: Calendar.Content.Request)
}

struct CalendarInteractor {
    // MARK: External properties
    var presenter: CalendarPresentable?
    var dataStore: Calendar.DataStore
}

// MARK: CalendarLogic
extension CalendarInteractor: CalendarLogic {
    func getContent(_ request: Calendar.Content.Request) {
        if let calendarId = dataStore.calendarId {
            getCalendar(calendarId)
        } else {
            getUserCalendars()
        }
    }
}

// MARK: Private
private extension CalendarInteractor {
    func getCalendar(_ calendarId: Int) {
        Networker.sendRequest(
            response: Calendar.Network.GetContent.Response.self,
            url: Endpoints.Calendars.calendar + calendarId.toString) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func getUserCalendars() {
        Networker.sendRequest(
            request: Calendar.Network.GetUserCalendars.Request(),
            response: Calendar.Network.GetUserCalendars.Response.self,
            url: Endpoints.Calendars.userCalendars) { result in
            switch result {
            case .success(let response):
                showContent(response)
            case .failure(let error):
                Logger.log(error)
            }
        }
    }
    
    func showContent(_ response: Calendar.Network.GetContent.Response?) {
        guard let events = response as? [EventModel] else { return }
        presenter?.presentContent(.init(
            events: events,
            calendarId: dataStore.calendarId))
    }
}
