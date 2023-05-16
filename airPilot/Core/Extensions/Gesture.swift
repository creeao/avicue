//
//  Gesture.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/12/2022.
//

import UIKit

extension UIView {
    func addGesture(_ target: Any?, _ action: Selector?) {
        let action = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(action)
        isUserInteractionEnabled = true
    }
}
