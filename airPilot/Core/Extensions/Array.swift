//
//  Array.swift
//  airPilot
//
//  Created by Eryk Chrustek on 13/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

extension Array {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Optional where Wrapped == [String] {
    func contains(_ value: String) -> Bool {
        self.orEmpty.contains(where: { $0 == value })
    }
    
    var orEmpty: [String] {
        return self ?? []
    }
}
