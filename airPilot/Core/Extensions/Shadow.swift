//
//  Shadow.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(with color: UIColor = Color.shadow, and blur: CGFloat = 20) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .init(width: 0, height: 4)
        layer.shadowRadius = blur
    }
}
