//
//  CommentModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/12/2022.
//

import Foundation

struct CommentModel: Codable {
    let id: Int
    let text: String?
    let createdDate: String?
    let createdBy: UserModel?
    var likedBy: [UserModel]?
    let assignedTo: PostModel?
    
    let likesCount: Int?
    var isLiked: Bool?
}
