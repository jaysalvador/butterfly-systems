//
//  Item+CoreDataProperties.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//
//

import Foundation
import CoreData

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var activeFlag: Bool
    @NSManaged public var id: Int64
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var lastUpdatedUserEntityId: Int64
    @NSManaged public var productItemId: Int64
    @NSManaged public var quantity: Int64
    @NSManaged public var transientIdentifier: String?
    @NSManaged public var order: Order?

}
