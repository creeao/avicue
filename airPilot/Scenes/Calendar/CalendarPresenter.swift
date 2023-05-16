//
//  CalendarPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import Foundation

protocol CalendarPresentable {
    func presentContent(_ response: Calendar.Content.Response)
}

struct CalendarPresenter {
    // MARK: External properties
    var viewController: CalendarDisplayable?
}

// MARK: CalendarPresentable
extension CalendarPresenter: CalendarPresentable {
    func presentContent(_ response: Calendar.Content.Response) {
        viewController?.displayContent(.init(
            events: response.events,
            calendarId: response.calendarId))
    }
}
