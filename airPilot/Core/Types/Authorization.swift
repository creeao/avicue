//
//  Register.swift
//  airPilot
//
//  Created by Eryk Chrustek on 05/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

enum Authorization {
    case email(email: String, password: String)
    case facebook
    case apple
    case google
}
