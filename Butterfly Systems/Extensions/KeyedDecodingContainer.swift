//
//  KeyedDecodingContainer.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
    /// Decode number aligned to formats thrown by the API
    /// - Parameter key: the `CodingKey` attribute name
    func intIfPresent(forKey key: KeyedDecodingContainer.Key) -> NSNumber? {
        
        guard let value = try? self.decodeIfPresent(Int.self, forKey: key) else {
            
            return nil
        }
        
        return NSNumber(value: value)
    }
    
    /// Decode number aligned to formats thrown by the API
    /// - Parameter key: the `CodingKey` attribute name
    func boolIfPresent(forKey key: KeyedDecodingContainer.Key) -> NSNumber? {
        
        guard let value = try? self.decodeIfPresent(Bool.self, forKey: key) else {
            
            return nil
        }
        
        return NSNumber(value: value)
    }
}
