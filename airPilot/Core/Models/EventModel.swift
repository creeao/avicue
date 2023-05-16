//
//  EventModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/01/2023.
//

import Foundation

struct EventModel: Codable {
    let id: Int
    let name: String?
    let type: EventType?
    let description: String?
    let locations: [String]?
    let location: String?
    let startDate: String?
    let endDate: String?
    let calendar: CalendarModel?
    let createdBy: UserModel?
}
