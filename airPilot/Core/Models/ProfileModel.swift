//
//  Profile.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct ProfileModel: Codable {
    let user: UserModel?
    let birthDate: String?
    let background: String?
    let postsCount: Int?
    let followersCount: Int?
    let friendsCount: Int?
    
    let jobHistory: [JobHistoryModel]?
    var status: UsersRelationType?
}

//struct ProfileModel: Codable {
//    let id: Int
////    let availableAction: AvailableAction?
//    let email: String?
//    let emailVerified: Bool?
//    let firstName: String?
//    let lastName: String?
//    let gender: String?
//    let birthDate: String?
//    let position: String?
//    let company: String?
//    let avatar: String?
//    let background: String?
//    let isActive: Bool?
//    let postsCount: Int?
//    let followersCount: Int?
//    let friendsCount: Int?
//    let details: [InformationModel]?
//    let workHistory: [JobHistoryModel]?
//    let posts: [PostModel]?
//
//    func getName() -> String {
//        return firstName.orEmpty + String.space + lastName.orEmpty
//    }
//
//    func getPosition() -> String {
//        guard let position, let company else { return String.empty }
//        return position + String.atWithSpaces + company
//    }
//}

struct EducationModel: Codable {
    let startDate: String
    let endDate: String
    let degree: String
    let fieldStudy: String
    let name: String
    let place: String
}

struct LanguageModel: Codable {
    let name: String
    let level: String
}

enum AvailableAction: String, Codable {
    case sendInvite = "sendInvite"
    case cancelInvite = "cancelInvite"
    case removeFriend = "removeFriend"
    case acceptInvite = "acceptInvite"
    case follow = "follow"
    case unfollow = "unfollow"
    case editProfile = "editProfile"
    case unknow = "unknow"
}

enum ActionOnUserType: String, Codable {
    case sendInvite = "SEND_INVITE"
    case cancelInvite = "CANCEL_INVITE"
    case removeFriend = "REMOVE_FRIEND"
    case acceptInvite = "ACCEPT_INVITE"
    case follow = "FOLLOW"
    case unfollow = "UNFOLLOW"
    case editProfile = "EDIT_PROFILE"
    case unknow = "UNKNOW"
}
