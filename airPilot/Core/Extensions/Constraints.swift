//
//  Constraints.swift
//  airPilot
//
//  Created by Eryk Chrustek on 26/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

extension UIView {
    func set(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let width = width {
            NSLayoutConstraint.activate([
                widthAnchor.constraint(equalToConstant: width)
            ])
        }
        
        if let height = height {
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: height)
            ])
        }
    }
    
    func removeConstraint(on position: Position) {
        switch position {
        case .top:
            guard let removedConstraint = self.constraints.first(where: { $0.firstAnchor == topAnchor }) else { return }
            self.removeConstraint(removedConstraint)
        case .bottom:
            guard let removedConstraint = self.constraints.first(where: { $0.firstAnchor == bottomAnchor }) else { return }
            self.removeConstraint(removedConstraint)
        case .left:
            guard let removedConstraint = self.constraints.first(where: { $0.firstAnchor == leadingAnchor }) else { return }
            self.removeConstraint(removedConstraint)
        case .right:
            guard let removedConstraint = self.constraints.first(where: { $0.firstAnchor == trailingAnchor }) else { return }
            self.removeConstraint(removedConstraint)
        }
    }
}

enum Position {
    case top
    case bottom
    case left
    case right
}
