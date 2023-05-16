//
//  Constants.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

enum Constants {
    static let cornerRadius = 10.0
    static let smallerCornerRadius = 8.0
    static let borderWidth = 1.0
    static let screenWidth = UIScreen.main.bounds.size.width
    
    enum Alpha {
        static let full = 1.0
        static let hard = 0.8
        static let regular = 0.6
        static let light = 0.4
        static let thin = 0.3
        static let mini = 0.2
        static let frail = 0.1
        static let zero = 0.0
    }
    
    enum Size {
        static let logo = 75.0
        static let smallLogo = 60.0
        static let photo = 175.0
        static let button = 50.0
        static let textField = 44.0
        static let listElement = 44.0
        
        enum Star {
            static let big = 20.0
            static let small = 15.0
            static let background = 34.0
        }
    }
}
