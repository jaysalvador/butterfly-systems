//
//  Date.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Date {
    
    /// Uses a `DateFormatter` to return the `String` formatted `Date` value
    /// - Parameter dateFormatter: user-defined `DateFormatter`
    /// - Parameter timezone: custom `TimeZone`
    func toString(using dateFormatter: DateFormatter?, in timezone: String? = nil) -> String? {

        dateFormatter?.timeZone = TimeZone(identifier: timezone ?? TimeZone.current.identifier)

        return dateFormatter?.string(from: self)
    }
    
    func currentTimeMilliseconds() -> Int64 {
        
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
