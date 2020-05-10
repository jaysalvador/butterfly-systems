//
//  OrderClient.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

protocol OrderClientProtocol {
    
    func getOrders(onCompletion: HttpCompletionClosure<[Order]>?)
}

public class OrderClient: HttpClient, OrderClientProtocol {
    
    public func getOrders(onCompletion: HttpCompletionClosure<[Order]>?) {
        
        let endpoint = "/sample-data/purchase_orders"
        
        self.request(
            [Order].self,
            endpoint: endpoint,
            httpMethod: .get,
            headers: nil,
            onCompletion: onCompletion
        )
    }
}
