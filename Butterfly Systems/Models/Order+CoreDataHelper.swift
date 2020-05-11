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
    
    /// Create a new `Order` object with generated `id` using the current timestamp
    static func create() -> Order? {
            
        let managedObjectContext = CoreDataStack.persistentContainer.viewContext
        
        return Order.create(context: managedObjectContext)
    }
    
    static func create(context: NSManagedObjectContext) -> Order? {
        
        let order = Order(context: context)
        
        order.id = NSNumber(value: Date().currentTimeMilliseconds())
        order.issueDate = Date()
        order.status = NSNumber(value: 1)
        order.activeFlag = NSNumber(value: 1)
        order.lastUpdated = Date()
        order.sentDate = Date()
        
        do {

            try context.save()
            
            return order
        }
        catch {
            
             return nil
        }
    }
    
    /// Fetches `Order` list
    /// - Parameter ids: filter by `id`
    static func fetchOrders(_ ids: [Int]? = nil) -> [Order]? {
        
        let managedObjectContext = CoreDataStack.persistentContainer.viewContext
        
        return Order.fetchOrders(ids, context: managedObjectContext)
    }

    static func fetchOrders(_ ids: [Int]? = nil, context: NSManagedObjectContext) -> [Order]? {
                    
        do {
            
            let orders = try context.fetch(Order.fetchRequest()) as? [Order]
            
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
    
    /// Updates orders in CoreData
    /// overwrites Order data bases on `lastUpdated` values
    /// Orders will be updated cascadingly
    /// - Parameter current: current `Order` list
    /// - Parameter new: new `Order` list from API
    static func updateOrders(current: [Order]?, new: [Order]) -> Bool {
        
        let managedObjectContext = CoreDataStack.persistentContainer.viewContext
        
        return Order.updateOrders(current: current, new: new, context: managedObjectContext)
        
    }
    
    static func updateOrders(current: [Order]?, new: [Order], context: NSManagedObjectContext) -> Bool {
        
        for newOrder in new {
            
            if let currentOrder = current?.first(where: { $0.id == newOrder.id }) {
                
                if newOrder.isLastest(currentOrder) {

                    context.delete(currentOrder)
                }
                else {

                    context.delete(newOrder)
                }
            }
        }
        
        do {

            try context.save()
            
            return true
        }
        catch {
            
            return false
        }
    }
    
    /// Checks two orders which one has the latest update
    /// - Parameter otherOrder: another `Order` object to compare
    func isLastest(_ otherOrder: Order) -> Bool {
        
        return self.lastUpdated ?? Date() > otherOrder.lastUpdated ?? Date()
    }
}
