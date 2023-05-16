//
//  Company.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct CompanyModel: Codable {
    let id: Int
    let name: String?
    let headline: String?
    let logo: String?
}

struct CompanyProfileModel: Codable {
    let company: CompanyModel
    let background: String?
    let website: String?
    let creationDate: String?
    let location: String?
    let description: String?
    
    let activities: [ActivityModel]?
    let jobOffers: [JobOfferModel]?
    let shopOffers: [ShopOfferModel]?
    let status: CompanyRelationType?
}

enum CompanyRelationType: String, Codable {
    case followed = "FOLLOWED"
    case noRelations = "NO_RELATIONS"
}

enum ActionOnCompanyType: String, Codable {
    case follow = "FOLLOW"
    case unfollow = "UNFOLLOW"
}
