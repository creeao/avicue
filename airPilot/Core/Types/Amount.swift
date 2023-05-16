//
//  Amount.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

//struct Amount: Codable {
//    let amount: Double
//    let currency: Currency
//}

struct Amount {
    let amount: String
    let amountAfterDot: String
    let currency: Currency
    
    func getAmountString(withAmountAfterDot: Bool = false) -> String {
        let currency = withAmountAfterDot ? (String.dot + amountAfterDot + String.space + currency.rawValue) : (String.space + currency.rawValue)
        
        switch amount.length {
        case 0...3:
            return amount + currency
        case 4:
            return amount.substring(toIndex: 1) + String.space + amount.substring(fromIndex: 1) + currency
        case 5:
            return amount.substring(toIndex: 2) + String.space + amount.substring(fromIndex: 2) + currency
        case 6:
            return amount.substring(toIndex: 3) + String.space + amount.substring(fromIndex: 3) + currency
        case 7:
            return amount.substring(toIndex: 1) + String.space + amount[1..<4] + String.space + amount.substring(fromIndex: 4) + currency
        case 8:
            return amount.substring(toIndex: 2) + String.space + amount[2..<5] + String.space + amount.substring(fromIndex: 5) + currency
        case 9:
            return amount.substring(toIndex: 3) + String.space + amount[3..<6] + String.space + amount.substring(fromIndex: 6) + currency
        default:
            return amount + currency
        }
    }
}

extension String {
    func getDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    func getOptionalDouble() -> Double? {
        return Double(self)
    }
    
    func getOptionalDecimal() -> Decimal? {
        return Decimal(string: self)
    }
    
    func getAmount(with currency: Currency, withAmountAfterDot: Bool = false) -> String {
        amount(with: currency).getAmountString(withAmountAfterDot: withAmountAfterDot)
    }
    
//    func getAmount(with currency: Currency) -> String {
//        let doubleValue = String(self.description).getDouble()
//        let amount = doubleValue.getString()
//        let currency = (String.space + currency.rawValue)
//
//        switch amount.length {
//        case 0...3:
//            return amount + currency
//        case 4:
//            return amount.substring(toIndex: 1) + String.space + amount.substring(fromIndex: 1) + currency
//        case 5:
//            return amount.substring(toIndex: 2) + String.space + amount.substring(fromIndex: 2) + currency
//        case 6:
//            return amount.substring(toIndex: 3) + String.space + amount.substring(fromIndex: 3) + currency
//        case 7:
//            return amount.substring(toIndex: 1) + String.space + amount[1..<4] + String.space + amount.substring(fromIndex: 4) + currency
//        default:
//            return amount
//        }
//    }
//
    func amount(with currency: Currency, withGrouping: Bool = true) -> Amount {
        let doubleValue = String(self.description).getDouble()
        let amount = doubleValue.getString()

        return Amount(
            amount: doubleValue.getString(places: 0),
            amountAfterDot: amount[(amount.count - 2)..<amount.count],
            currency: currency)
    }
        
}

extension Double {
    func getString(places: Int = 2) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    var roundedValue: String {
        let value = self.rounded(toPlaces: 2)
        return String(describing: value)
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(100.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Amount {
    func getAmount() -> String {
        let amount = String(self.amount.description)
        let currency = (String.space + self.currency.rawValue)
        switch amount.length {
        case 0...3:
            return amount + currency
        case 4:
            return amount.substring(toIndex: 1) + String.space + amount.substring(fromIndex: 1) + currency
        case 5:
            return amount.substring(toIndex: 2) + String.space + amount.substring(fromIndex: 2) + currency
        case 6:
            return amount.substring(toIndex: 3) + String.space + amount.substring(fromIndex: 3) + currency
        case 7:
            return amount.substring(toIndex: 1) + String.space + amount[1..<4] + String.space + amount.substring(fromIndex: 4) + currency
        default:
            return amount
        }
    }
}
