//
//  ActivityUser.swift
//  airPilot
//
//  Created by Eryk Chrustek on 14/01/2023.
//

import Foundation

struct UserActivity: Codable {
    let activityDate: String
    let user: UserModel?
}
