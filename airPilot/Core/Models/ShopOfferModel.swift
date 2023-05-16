//
//  ShopOfferModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//

import Foundation

struct ShopOfferModel: Codable {
    let id: Int
    let name: String?
    let category: Category?
    let type: ShopOfferType?
    let price: String?
    let currency: Currency?
    let createdDate: String?
    let startDate: String?
    let endDate: String?
    let text: String?
    let images: [String]?
    let country: String?
    let city: String?
    let street: String?
    let buildingNumber: String?
    let apartmentNumber: String?
    let rating: Decimal?
    
    let createdBy: UserModel?
    let assignedTo: CompanyModel?
    let addedToFavoritesBy: [UserModel]?
    
    var isFavourite: Bool?
    
    // MARK: Activity
//    var user: UserModel? = nil
//    var activityType: UserActivityType = .shared
}
