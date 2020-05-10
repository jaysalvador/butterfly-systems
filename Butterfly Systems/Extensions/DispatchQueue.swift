//
//  DispatchQueue.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    /// Accessible variable for the Background Queue
    public class var background: DispatchQueue {
        
        return DispatchQueue.global(qos: .background)
    }
}
