//
//  User.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    let uuid: String
    let email: String?
    let emailVerified: Bool?
    
    let firstName: String?
    let lastName: String?
    let headline: String?
    
    let avatar: String?
}
//
//struct UserModel: Codable {
//    let id: Int
//    let email: String?
//    let emailVerified: Bool?
//    let firstName: String?
//    let lastName: String?
//    let headline: String?
//    let avatar: Int?
//    let background: Int?
////    let birthDate: Date?
//    let isActive: Bool?
//    let postsCount: Int?
//    let followersCount: Int?
//    let friendsCount: Int?
//    var status: UsersRelationType?
//
////    let favourites: [OfferModel]?
//
//    let posts: [PostModel]?
//    let friends: [UserModel]?
//    let followers: [UserModel]?
//
//    let jobHistory: [JobHistoryModel]?
//    let jobOffers: [JobOfferModel]?
//    let shopOffers: [ShopOfferModel]?
//    let shopOffersFavourites: [ShopOfferModel]?
//    let discountOffers: [DiscountOfferModel]?
//    let aviationOffers: [AviationOfferModel]?
//    let employedIn: [CompanyModel]?
//    let exEmployedIn: [CompanyModel]?
//
//    // MARK: Activities
//    let likedPostsActivity: [PostModel]?
//    let sharedPostsActivity: [PostModel]?
//    let sharedShopOffersActivity: [ShopOfferModel]?
//    let sharedJobOffersActivity: [JobOfferModel]?
//}

extension UserModel {
    func getName() -> String {
        if firstName.orEmpty.isNotEmpty || lastName.orEmpty.isNotEmpty {
            return firstName.orEmpty + String.space + lastName.orEmpty
        } else {
            return email.orEmpty
        }
    }
    
//    func getShortInformation() -> UserModel {
//        return UserModel(
//            id: id,
//            email: email,
//            emailVerified: emailVerified,
//            firstName: firstName,
//            lastName: lastName,
//            headline: headline,
//            avatar: avatar,
//            background: nil,
//            isActive: isActive,
//            postsCount: nil,
//            followersCount: nil,
//            friendsCount: nil,
//            posts: nil,
//            friends: nil,
//            followers: nil,
//            jobHistory: nil,
//            jobOffers: nil,
//            shopOffers: nil,
//            shopOffersFavourites: nil,
//            discountOffers: nil,
//            aviationOffers: nil,
//            employedIn: nil,
//            exEmployedIn: nil,
//            likedPostsActivity: nil,
//            sharedPostsActivity: nil,
//            sharedShopOffersActivity: nil,
//            sharedJobOffersActivity: nil)
//    }
}

extension Optional where Wrapped == [UserModel] {
    func contains(_ userUuid: String) -> Bool {
        (self ?? []).contains(where: { $0.uuid == userUuid })
    }
}
