//
//  ActivityType.swift
//  airPilot
//
//  Created by Eryk Chrustek on 14/01/2023.
//

import Foundation

enum ActivityType: String, Codable {
    case post = "POST"
    case postLiked = "POST_LIKED"
    case postShared = "POST_SHARED"
    case shopOfferShared = "SHOP_OFFER_SHARED"
    case jobOfferShared = "JOB_OFFER_SHARED"
    case comment = "COMMENT"
}
