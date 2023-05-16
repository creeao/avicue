//
//  OfferModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 06/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct OfferModel: Codable {
    let id: Int
    let name: String?
    let category: OfferCategory?
    let type: OfferType?
    let price: String?
    let currency: Currency?
    let createdDate: Date?
    let startDate: Date?
    let endDate: Date?
    let text: String?
    let images: [String]?
    let location: Location?
    let rating: Decimal?
    
    let createdBy: UserModel?
    let assignedTo: CompanyModel?
    let addedToFavoritesBy: [UserModel]?
}

struct Rating: Codable {
    let user: UserModel?
    let value: Decimal?
}

enum OfferCategory: String, Codable {
    case aviation = "aviation"
    case apartment = "apartment"
}

enum OfferType: String, Codable {
    case sale = "sale"
    case rent = "rent"
    
    case daily = "daily"
    case monthly = "monthly"
    
    func getText() -> String {
        switch self {
            case .rent: return " / 24H"
            case .sale: return ""
            
            case .daily: return " / 24H"
            case .monthly: return " / Month"
        }
    }
}
