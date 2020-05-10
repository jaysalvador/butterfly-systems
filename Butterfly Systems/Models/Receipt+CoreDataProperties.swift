//
//  Receipt+CoreDataProperties.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//
//

import Foundation
import CoreData

extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var activeFlag: Bool
    @NSManaged public var created: Date?
    @NSManaged public var id: Int64
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var lastUpdatedUserEntityId: Int64
    @NSManaged public var productItemId: Int64
    @NSManaged public var receivedQuantity: Int64
    @NSManaged public var sentDate: Date?
    @NSManaged public var transientIdentifier: String?
    @NSManaged public var invoice: Invoice?

}
