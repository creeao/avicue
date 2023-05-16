//
//  Currency.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

enum Currency: String, Codable, CaseIterable {
    case pln = "PLN"
    case eur = "EUR"
    case usd = "USD"
    case dkk = "DKK"
    case nok = "NOK"
    case aud = "AUD"
    case chf = "CHF"
}

extension Currency {
    var name: String {
        switch self {
        case .pln:
            return "Polish Zloty"
        case .eur:
            return "Euro"
        case .usd:
            return "United States Dollar"
        case .dkk:
            return "Danish Krone"
        case .nok:
            return "Norwegian Krone"
        case .aud:
            return "Australian dollar"
        case .chf:
            return "Swiss Franc"
        }
    }
}
