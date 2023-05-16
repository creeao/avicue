//
//  ShopOfferType.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//

import Foundation

enum ShopOfferType: String, Codable, CaseIterable {
    case sale = "SALE"
    case hourly = "HOURLY"
    case daily = "DAILY"
    case monthly = "MONTHLY"

    func getText() -> String {
        switch self {
            case .sale: return ""
            case .hourly: return " / 1H"
            case .daily: return " / 24H"
            case .monthly: return " / Month"
        }
    }
    
    var title: String {
        switch self {
            case .sale: return "Sale"
            case .hourly: return "Rent - Hourly"
            case .daily: return "Rent - Daily"
            case .monthly: return "Rent - Monthly"
        }
    }
}
