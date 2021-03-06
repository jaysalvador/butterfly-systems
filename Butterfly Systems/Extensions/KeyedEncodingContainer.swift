//
//  KeyedEncodingContainer.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension KeyedEncodingContainer {
    
    mutating func encodeIntIfPresent(_ value: NSNumber?, forKey key: Self.Key) throws {
        
        guard let value = value?.intValue else {
            
            return
        }
        
        try self.encodeIfPresent(value, forKey: key)
    }
    
    mutating func encodeBoolIfPresent(_ value: NSNumber?, forKey key: Self.Key) throws {
        
        guard let value = value?.boolValue else {
            
            return
        }
        
        try self.encodeIfPresent(value, forKey: key)
    }
    
    mutating func encodeSetIfPresent<T>(_ type: T.Type, items: NSSet?, forKey key: Self.Key) throws where T: Encodable {
        
        let array = items?.allObjects as? [T]
        
        try self.encodeIfPresent(array, forKey: key)
    }
}
