//
//  Item+CoreDataHelper.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Item {
    
    static func create(order: Order, quantity: Int) -> Item? {
        
        let managedObjectContext = CoreDataStack.persistentContainer.viewContext

        let item = Item(context: managedObjectContext)
        
        item.id = NSNumber(value: Date().currentTimeMilliseconds())
        item.quantity = NSNumber(value: quantity)
        item.activeFlag = NSNumber(value: 1)
        item.lastUpdated = Date()
        item.order = order
        
        do {

            try managedObjectContext.save()
            
            return item
        }
        catch {
            
             return nil
        }
    }
}
