//
//  Order+CoreDataProperties.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//
//

import Foundation
import CoreData

extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var activeFlag: Bool
    @NSManaged public var approvalStatus: Int64
    @NSManaged public var deliveryNote: String?
    @NSManaged public var deviceKey: String?
    @NSManaged public var id: Int64
    @NSManaged public var issueDate: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var lastUpdatedUserEntityId: Int64
    @NSManaged public var preferredDeliveryDate: Date?
    @NSManaged public var purchaseOrderNumber: String?
    @NSManaged public var sentDate: Date?
    @NSManaged public var serverTimestamp: Int64
    @NSManaged public var status: Int64
    @NSManaged public var supplierId: Int64
    @NSManaged public var invoices: NSSet?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for invoices
extension Order {

    @objc(addInvoicesObject:)
    @NSManaged public func addToInvoices(_ value: Invoice)

    @objc(removeInvoicesObject:)
    @NSManaged public func removeFromInvoices(_ value: Invoice)

    @objc(addInvoices:)
    @NSManaged public func addToInvoices(_ values: NSSet)

    @objc(removeInvoices:)
    @NSManaged public func removeFromInvoices(_ values: NSSet)

}

// MARK: Generated accessors for items
extension Order {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
