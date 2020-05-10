//
//  DateFormatter.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let dateAndTime: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter
    }()
}
