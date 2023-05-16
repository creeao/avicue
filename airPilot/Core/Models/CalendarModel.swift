//
//  CalendarModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/01/2023.
//

import Foundation

struct CalendarModel: Codable {
    let id: Int
    let events: [EventModel]?
}
