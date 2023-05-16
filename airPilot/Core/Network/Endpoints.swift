//
//  Path.swift
//  airPilot
//
//  Created by Eryk Chrustek on 23/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

enum Endpoints {
    // MARK: Common
    enum Common {
        static let image: String = "http://localhost:3000/api/files/"
        static let server: String = "http://localhost:3000/api/"
    }
    
    // MARK: Users
    enum Users {
        static let user: String = "users/"
        static let userProfile: String = "users/profile/"
        static let users: String = "users/all"
        static let friends: String = "users/friends/"
        static let followers: String = "users/followers/"
        static let posts: String = "users/posts/"
        static let action: String = "users/user/action/"
        static let friendsActivities: String = "users/friends-activities/"
        static let addAvatar: String = "users/add-avatar/"
        static let addBackground: String = "users/add-background/"
        static let membershipInformation: String = "users/membership-information/"
        
        enum Profile {
            static let editProfile: String = "users/edit-profile/"
            static let headline: String = "users/get-headline/"
            static let checkStatusWithUser: String = "users/check-status-with-user/"
            static let actionOnUser: String = "users/action-on-user/"
            
            enum JobHistory {
                static let addJobHistory: String = "job-history/add-job-history/"
                static let removeJobHistory: String =  "job-history/remove-job-history/"
            }
        }
    }
    
    enum Calendars {
        static let userCalendars: String = "calendars/user-calendars/"
        static let calendar: String = "calendars/"
        static let group: String = "calendars/group/"
    }
    
    enum Events {
        static let createEvent: String = "events/create-event"
        static let createOfferDuty: String = "events/create-offer-duty"
        static let createOfferSearch: String = "events/create-offer-search"
    }
    
    enum Activities {
        static let activity: String = "activities/"
        static let createActivity: String = "activities/create-activity"
    }
    
    enum Menu {
        static let menu: String = "menu/"
    }
    
    enum Companies {
        static let companies: String = "companies/all"
        static let company: String = "companies/"
        static let actionOnCompany: String = "companies/action-on-company/"
        static let createCompany: String = "companies/create-company/"
        
        enum Profile {
            static let profile: String = "companies/profile/"
            static let edit: String = "companies/profile/edit"
        }
        
        enum EditProfile {
            static let changeLogo: String = "companies/change-logo"
            static let changeBackground: String = "companies/change-background"
        }
    }
    
    enum Groups {
        static let groups: String = "groups/all"
        static let group: String = "groups/"
        static let userGroups: String = "groups/user-groups/"
        static let createGroup: String = "groups/create-group"
        static let createPost: String = "groups/create-post"
    }
    
    enum Posts {
        static let post: String = "posts/"
        static let action: String = "posts/post/action/"
        
        static let likePost: String = "posts/like-post/"
        static let unlikePost: String = "posts/unlike-post/"
        static let sharePost: String = "posts/share-post/"
        static let createPost: String = "posts/create-post/"
    }
    
    enum Comments {
        static let createComment: String = "comments/create-comment/"
        static let likeComment: String = "comments/like-comment/"
    }
    
    enum JobOffers {
        static let offers: String = "job-offers/"
        static let offer: String = "job-offers/offer/"
        static let category: String = "job-offers/category/"
        static let create: String = "job-offers/create-offer/"
        
        enum Categories {
            static let categories: String = "job-offers/categories/"
            static let subcategories: String = "job-offers/categories/subcategories/"
            static let category: String = "job-offers/categories/category/"
        }
    }
    
    enum ShopOffers {
        static let offers: String = "shop-offers/"
        static let offer: String = "shop-offers/"
        static let category: String = "shop-offers/category/"
        static let create: String = "shop-offers/create-offer/"
        static let addFiles: String = "shop-offers/add-files/"
        static let favouriteAction: String = "shop-offers/favourite-action/"
        static let favourites: String = "shop-offers/favourites/"
        
        enum Categories {
            static let categories: String = "shop-offers/categories/"
            static let subcategories: String = "shop-offers/categories/subcategories/"
            static let category: String = "shop-offers/categories/category/"
        }
    }
    
    enum AviationOffers {
        static let offers: String = "aviation-offers/"
        static let offer: String = "aviation-offers/offer/"
    }
    
    enum DiscountOffers {
        static let offers: String = "discount-offers/"
        static let offer: String = "discount-offers/offer/"
    }
    
    enum Conversations {
        static let userConversations: String = "conversations/user-conversations/"
        static let conversation: String = "conversations/conversation/"
        static let findConversation: String = "conversations/find-conversation/"
        static let createConversation: String = "conversations/create-conversation/"
        static let sendMessage: String = "conversations/send-message/"
        
        static let offers: String = "discount-offers/"
        static let offer: String = "discount-offers/offer/"
    }
    
    enum Search {
        static let users: String = "search/users/"
    }
    
    enum Default {
        static let url: String = "url/"
    }
}
