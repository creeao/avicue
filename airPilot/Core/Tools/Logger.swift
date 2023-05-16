//
//  Logger.swift
//  airPilot
//
//  Created by Eryk Chrustek on 05/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

final class Logger {
    static func log(_ item: Any) {
        print("‼️ Logger:")
        print(item as Any)
    }
    
    static func response(for url: String, with item: Any) {
        print("🟢 Response for URL: \(url)")
        print(item as Any)
    }
}
