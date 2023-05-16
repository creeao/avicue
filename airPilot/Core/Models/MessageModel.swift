//
//  MessageModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct MessageModel: Codable {
    let id: Int
    let text: String?
    let createdBy: UserModel?

    let createdDate: String?
    let updatedDate: String?
}
