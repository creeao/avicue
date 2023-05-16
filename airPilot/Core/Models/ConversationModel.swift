//
//  ConversationModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct ConversationModel: Codable {
//    let id: Int
//    let avatar: String?
//    let name: String?
//    let lastMessage: String?
//    let lastMessageDate: String?
    
    let id: Int
    let avatar: String?
    let name: String?
    let createdDate: String?
    let updatedDate: String?
    
    let users: [UserModel]?
    let messages: [MessageModel]?
}
