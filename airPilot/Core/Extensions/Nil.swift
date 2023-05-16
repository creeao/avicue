//
//  Nil.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var isNotNil: Bool {
        return !isNil
    }
}

extension Optional where Wrapped == Bool {
    var isTrue: Bool {
        return self ?? false
    }
}
