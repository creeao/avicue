//
//  ApartmentOfferModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct ApartmentOfferModel: Codable {
    let id: Int
    let description: String?
    let favourites: [Int]
    let images: [String]?
    let ownerId: String
    let location: Location?
    let price: String?
    let currency: Currency?
    let ratingList: [String: Decimal]?
    let type: ApartmentOfferType?
}

enum ApartmentOfferType: String, Codable {
    case daily = "DAILY"
    case monthly = "MONTHLY"
    
    func getText() -> String {
        switch self {
            case .daily: return "24H"
            case .monthly: return "Month"
        }
    }
}
