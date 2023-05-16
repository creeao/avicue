//
//  EventCreator.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/01/2023.
//  Copyright © 2023 airPilot. All rights reserved.
//

import UIKit

// MARK: Model
enum EventCreator {
    struct Input {
        let calendarId: Int?
    }
    
    enum Content {
        struct Request {}
        
        struct Response {
            let group: GroupModel?
        }
        
        struct ViewModel {
            let group: GroupModel?
        }
    }
    
    enum CreateOffer {
        struct Request {
            let name: String?
            let postition: String?
            let description: String?
            let location: String?
            let departureDestinations: [String]?
            let departure: String?
            let type: EventType
            let date: String?
            let startDate: String?
            let endDate: String?
            let groupId: Int?
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Result {
        struct Response {
            let type: ResultViewType
        }
        
        struct ViewModel {
            let result: ResultModel
        }
    }
}

// MARK: Network
extension EventCreator {
    enum Network {
        enum GetContent {
            struct Request: Encodable {
                let calendarId: Int?
            }
            
            typealias Response = GroupModel?
        }
        
        enum CreateEvent {
            struct Request: Encodable {
                let type: EventType
                let name: String?
                let location: String?
                let date: String?
                let description: String?
                let groupId: Int
            }
            
            struct Response: Decodable {}
        }
        
        enum CreateOfferDuty {
            struct Request: Encodable {
                let type: EventType
                let departureDestinations: [String]?
                let position: String?
                let startDate: String?
                let endDate: String?
                let description: String?
                let groupId: Int
            }
            
            struct Response: Decodable {}
        }
        
        enum CreateOfferSearch {
            struct Request: Encodable {
                let type: EventType
                let departure: String?
                let position: String?
                let date: String?
                let description: String?
                let groupId: Int
            }
            
            struct Response: Decodable {}
        }
    }
}

// MARK: DataStore
extension EventCreator {
    class DataStore {
        var calendarId: Int?
        
        init(calendarId: Int?) {
            self.calendarId = calendarId
        }
    }
}

// MARK: Scene maker
extension EventCreator {
    static func createScene(_ input: EventCreator.Input) -> ViewController {
        let viewController = EventCreatorViewController()
        let presenter = EventCreatorPresenter(viewController: viewController)
        let dataStore = EventCreator.DataStore(calendarId: input.calendarId)
        let interactor = EventCreatorInteractor(
            presenter: presenter,
            dataStore: dataStore)
        viewController.interactor = interactor
        return viewController
    }
}
