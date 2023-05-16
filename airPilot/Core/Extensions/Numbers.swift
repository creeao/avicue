//
//  Numbers.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

extension Int {
    var toString: String {
        return String(self)
    }
    
    var isZero: Bool {
        return self == 0
    }
}

// MARK: Optionals
extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Float {
    var orZero: Float {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Decimal {
    var orZero: Decimal {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == CGFloat {
    var orZero: CGFloat {
        return self ?? 0.0
    }
}
