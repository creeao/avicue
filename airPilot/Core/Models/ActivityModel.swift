//
//  ActivityModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 14/01/2023.
//

import Foundation

struct ActivityModel: Codable {
    let id: Int
    let type: ActivityType
    let activityDate: String?
    let friendsActivity: [UserActivity]?
    
    let post: PostModel?
    let shopOffer: ShopOfferModel?
    let jobOffer: JobOfferModel?
    let comment: CommentModel?
    
    init(id: Int, type: ActivityType, activityDate: String? = nil, friendsActivity: [UserActivity]? = nil, post: PostModel? = nil, shopOffer: ShopOfferModel? = nil, jobOffer: JobOfferModel? = nil, comment: CommentModel? = nil) {
        self.id = id
        self.type = type
        self.activityDate = activityDate
        self.friendsActivity = friendsActivity
        self.post = post
        self.shopOffer = shopOffer
        self.jobOffer = jobOffer
        self.comment = comment
    }
}
