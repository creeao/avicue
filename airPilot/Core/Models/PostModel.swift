//
//  Post.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    let id: Int
    let text: String?
    let createdDate: String?
    let createdBy: UserModel?
    var likedBy: [UserModel]?
    let comments: [CommentModel]?
    let assignedToCompany: CompanyModel?
    let assignedToGroup: CompanyModel?
    
    var commentsCount: Int?
    var likesCount: Int?
    var isLiked: Bool?
    
    // MARK: Activity
//    var user: UserModel? = nil
//    var activityType: UserActivityType = .shared
}

enum UserActivityType: String, Codable {
    case own
    case shared
    case liked
}

