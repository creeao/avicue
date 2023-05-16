//
//  Calendar.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/12/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum Calendar {
    struct Input {
        let calendarId: Int?
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let events: [EventModel]
            let calendarId: Int?
        }
        
        struct ViewModel {
            let events: [EventModel]
            let calendarId: Int?
        }
    }
}

// MARK: Network
extension Calendar {
    enum Network {
        enum GetContent {
            struct Request: Encodable {}
            
            typealias Response = [EventModel]?
        }
        
        enum GetCalendar {
            struct Request: Encodable {}
            
            struct Response: Decodable {}
        }
        
        enum GetUserCalendars {
            struct Request: Encodable {}
            
            typealias Response = [EventModel]?
        }
    }
}

// MARK: DataStore
extension Calendar {
    class DataStore {
        let calendarId: Int?
        
        init(calendarId: Int?) {
            self.calendarId = calendarId
        }
    }
}

// MARK: Scene maker
extension Calendar {
    static func createScene(_ input: Calendar.Input) -> ViewController {
        let viewController = CalendarViewController()
        let presenter = CalendarPresenter(viewController: viewController)
        let dataStore = Calendar.DataStore(calendarId: input.calendarId)
        let interactor = CalendarInteractor(presenter: presenter, dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
