//
//  Item+CoreDataHelper.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    static func create(order: Order, quantity: Int) -> Item? {
        
        let managedObjectContext = CoreDataStack.persistentContainer.viewContext
        
        return Item.create(order: order, quantity: quantity, context: managedObjectContext)
    }

    static func create(order: Order, quantity: Int, context: NSManagedObjectContext) -> Item? {
        
        let item = Item(context: context)
        
        item.id = NSNumber(value: Date().currentTimeMilliseconds())
        item.quantity = NSNumber(value: quantity)
        item.activeFlag = NSNumber(value: 1)
        item.lastUpdated = Date()
        item.order = order
        
        do {

            try context.save()
            
            return item
        }
        catch {
            
             return nil
        }
    }
}
