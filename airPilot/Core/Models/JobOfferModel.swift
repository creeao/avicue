//
//  JobOfferModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 07/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct JobOfferModel: Codable {
    let id: Int
    let position: String?
    let category: Category?
//    let type: JobType?
    let createdDate: String?
    let startDate: String?
    let endDate: String?
    let text: String?
    let minSalary: String?
    let maxSalary: String?
    let currency: Currency?
    let createdBy: UserModel?
    let assignedTo: CompanyModel?
    
    // MARK: Activity
//    var user: UserModel? = nil
//    var activityType: UserActivityType = .shared
}
