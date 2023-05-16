//
//  Salary.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

extension String {
    static let empty: String = ""
    static let slash: String = "/"
    static let slashWithSpaces: String = " / "
    static let pauseWithSpaces: String = " - "
    static let comma: String = ", "
    static let space: String = " "
    static let atWithSpaces: String = " at "
    static let dot: String = "."
    
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
