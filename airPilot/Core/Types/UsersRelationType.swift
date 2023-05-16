//
//  UsersRelationType.swift
//  airPilot
//
//  Created by Eryk Chrustek on 01/12/2022.
//

import Foundation

enum UsersRelationType: String, Codable {
    case friend = "FRIEND"
    case invitationSent = "INVITATION_SENT"
    case invitationReceived = "INVITATION_RECEIVED"
    case noRelations = "NO_RELATIONS"
    case unknow = "UNKNOW"
}
