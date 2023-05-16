//
//  DiscountOfferModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//

import Foundation

struct DiscountOfferModel: Codable {
    let id: Int
    let name: String?
    let category: DiscountOfferCategory?
    let price: String?
    let currency: Currency?
    let createdDate: String?
    let startDate: String?
    let endDate: String?
    let text: String?
    let images: [String]?
    let location: Location?
    let rating: Decimal?
    
    let createdBy: UserModel?
    let assignedTo: CompanyModel?
}
