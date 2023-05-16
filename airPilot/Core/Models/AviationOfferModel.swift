//
//  AviationOfferModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//

import Foundation

struct AviationOfferModel: Codable {
    let id: Int
    let name: String?
    let category: AviationOfferCategory?
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
