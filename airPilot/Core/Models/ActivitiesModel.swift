//
//  ActivitiesModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/11/2022.
//

import Foundation

struct ActivitiesModel: Codable {
    let id: Int
    let ownShopOffers: [ShopOfferModel]?
    let ownJobOffers: [JobOfferModel]?
    let ownPosts: [PostModel]?
    let likedPosts: [PostModel]?
    
}
