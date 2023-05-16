//
//  Color.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

enum Color {
    // MARK: Colors    
    static let transparent = getColor(for: "transparent")
    static let white = getColor(for: "white")
    static let black = getColor(for: "black")
    static let dark = getColor(for: "dark")
    static let gray = getColor(for: "gray")
    static let orange = getColor(for: "orange")
    static let yellow = getColor(for: "yellow")
    static let salmon = getColor(for: "salmon")
    static let green = getColor(for: "green")
    static let blue = getColor(for: "blue")
    static let purple = getColor(for: "purple")
    
    // MARK: Elements
    static let background = getColor(for: "background")
    static let shadow = getColor(for: "shadow")
    static let dashedBorder = getColor(for: "dashedBorder")
    
    static func getColor(for name: String) -> UIColor {
        return UIColor(named: name) ?? .white
    }
}

extension UIColor {
    var withHardAlpha: UIColor {
        self.withAlphaComponent(Constants.Alpha.hard)
    }
    
    var withRegularAlpha: UIColor {
        self.withAlphaComponent(Constants.Alpha.regular)
    }
    
    var withLightAlpha: UIColor {
        self.withAlphaComponent(Constants.Alpha.light)
    }
    
    var withThinAlpha: UIColor {
        self.withAlphaComponent(Constants.Alpha.thin)
    }
    
    var withMiniAlpha: UIColor {
        self.withAlphaComponent(Constants.Alpha.mini)
    }
    
    var withFrailAlpha: UIColor {
        self.withAlphaComponent(Constants.Alpha.frail)
    }
}
