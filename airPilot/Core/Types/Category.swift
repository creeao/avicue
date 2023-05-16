//
//  Category.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/11/2022.
//

import Foundation
import UIKit

struct Category: Codable {
    let id: Int
    let name: String?
    let categories: [Category]?
}

enum ShopOfferMainCategory: CaseIterable {
    case all
    case aviation
    case apartments
    case others
}

extension ShopOfferMainCategory {
    var path: String {
        switch self {
        case .all:
            return "all"
        case .aviation:
            return "aviation"
        case .apartments:
            return "apartments"
        case .others:
            return "others"
        }
    }
    
    var name: String {
        switch self {
        case .all:
            return "All"
        case .aviation:
            return "Aviation"
        case .apartments:
            return "Apartments"
        case .others:
            return "Others"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .all:
            return Image.Categories.all
        case .aviation:
            return Image.Categories.aviation
        case .apartments:
            return Image.Categories.apartments
        case .others:
            return Image.Categories.other
        }
    }
}

enum JobOfferCategory {
    static let all = "all"
    static let aviation = "aviation"
    static let logistics = "logistics"
    static let it = "it"
    static let others = "others"
}
