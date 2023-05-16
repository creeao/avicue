//
//  Date.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//

import Foundation

extension String {
    func date(dateStyle: Date.FormatStyle.DateStyle = .abbreviated, timeStyle: Date.FormatStyle.TimeStyle = .omitted) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)
        return date?.formatted(date: dateStyle, time: timeStyle)
    }
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
    
    var getDateTime: String {
        guard let time = self.date(dateStyle: .omitted, timeStyle: .shortened),
              let fullDate = self.date(dateStyle: .abbreviated, timeStyle: .omitted) else {
            return String.empty
        }

        return time + String.pauseWithSpaces + fullDate
    }
    
    var getDate: String {
        guard let date = self.date(dateStyle: .abbreviated, timeStyle: .omitted) else {
            return String.empty
        }

        return date
    }
    
    var getTime: String {
        guard let time = self.date(dateStyle: .omitted, timeStyle: .shortened) else {
            return String.empty
        }

        return time
    }
}
