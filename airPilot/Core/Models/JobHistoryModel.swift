//
//  JobHistoryModel.swift
//  airPilot
//
//  Created by Eryk Chrustek on 07/11/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct JobHistoryModel: Codable {
    let id: Int
    let position: String?
    let category: JobCategory?
//    let type: JobType?
    let createdDate: String?
    let startDate: String?
    let endDate: String?
    let createdBy: UserModel?
    let assignedTo: CompanyModel?
}
