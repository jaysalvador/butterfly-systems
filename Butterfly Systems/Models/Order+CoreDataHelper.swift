//
//  Order+CoreDataHelper.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

extension Order {
    
    static func create() -> Order? {
            
        let managedObjectContext = CoreDataStack.persistentContainer.viewContext
        
        let order = Order(context: managedObjectContext)
        
        order.id = NSNumber(value: Date().currentTimeMilliseconds())
        order.issueDate = Date()
        order.status = NSNumber(value: 1)
        order.activeFlag = NSNumber(value: 1)
        order.lastUpdated = Date()
        order.sentDate = Date()
        
        do {

            try managedObjectContext.save()
            
            return order
        }
        catch {
            
             return nil
        }
    }
    
    static func fetchOrders(_ ids: [Int]? = nil) -> [Order]? {
            
        let managedObjectContext = CoreDataStack.persistentContainer.viewContext
        
        do {
            
            let orders = try managedObjectContext.fetch(Order.fetchRequest()) as? [Order]
            
            if let ids = ids?.compactMap({ NSNumber(value: $0) }) {
                
                return orders?.filter { ids.contains($0.id ?? NSNumber(value: -1)) }
            }
            else {
                
                return orders
            }
        }
        catch {
            
            return nil
        }
    }
    
    func isLastest(_ otherOrder: Order) -> Bool {
        
        return self.lastUpdated ?? Date() > otherOrder.lastUpdated ?? Date()
    }
}
