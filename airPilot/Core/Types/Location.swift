//
//  Location.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct Location: Codable {
    let country: Country?
    let region: String?
    let street: String?
    let buildingNumber: String?
    let flatNumber: String?
}

enum Country: String, Codable {
    case poland = "Poland"
    case unitedStates = "United States"
    case england = "England"
    case germany = "Germany"
    case greece = "Greece"
}
