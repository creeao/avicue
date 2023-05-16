//
//  Margin.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

enum Margin: CGFloat {
    case tremendous = 40.0
    case huge = 30.0
    case big = 24.0
    case large = 22.0
    case normal = 16.0
    case regular = 12.0
    case medium = 10.0
    case small = 8.0
    case little = 6.0
    case mini = 4.0
    case tiny = 2.0
    case zero = 0.0
    
    var top: CGFloat {
        return self.rawValue
    }
    
    var leading: CGFloat {
        return self.rawValue
    }
    
    var trailing: CGFloat {
        return -self.rawValue
    }
    
    var bottom: CGFloat {
        return -self.rawValue
    }
    
    var space: CGFloat {
        return self.rawValue
    }
    
    var constant: CGFloat {
        return self.rawValue
    }
}
