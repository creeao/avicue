//
//  Insets.swift
//  airPilot
//
//  Created by Eryk Chrustek on 31/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

enum Insets {
    static func setup(top: CGFloat = Margin.zero.space, left: CGFloat = Margin.zero.space, bottom: CGFloat = Margin.zero.space, right: CGFloat = Margin.zero.space) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    static func setup(margin: CGFloat = Margin.zero.space) -> UIEdgeInsets {
        UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}
