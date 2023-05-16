//
//  GroupModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//

import Foundation

struct GroupModel: Codable {
    let id: Int
    let name: String?
    let headline: String?
    let logo: String?
    let background: String?
    let creationDate: String?
    
    let members: [UserModel]?
    let posts: [PostModel]?
    let conversation: ConversationModel?
    let calendar: CalendarModel?
    
    let postsCount: Int?
    let membersCount: Int?
}
