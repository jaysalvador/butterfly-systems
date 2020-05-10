//
//  Order.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

public class Order: NSManagedObject, Codable {

    @NSManaged var id: NSNumber?
    @NSManaged var supplierId: NSNumber?
    @NSManaged var purchaseOrderNumber: String?
    @NSManaged var issueDate: Date?
    @NSManaged var status: NSNumber?
    @NSManaged var activeFlag: NSNumber?
    @NSManaged var lastUpdated: Date?
    @NSManaged var lastUpdatedUserEntityId: NSNumber?
    @NSManaged var sentDate: Date?
    @NSManaged var serverTimestamp: NSNumber?
    @NSManaged var deviceKey: String?
    @NSManaged var approvalStatus: NSNumber?
    @NSManaged var preferredDeliveryDate: Date?
    @NSManaged var deliveryNote: String?
    @NSManaged var items: NSSet?
    @NSManaged var invoices: NSSet?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case supplierId = "supplier_id"
        case purchaseOrderNumber = "purchase_order_number"
        case issueDate = "issue_date"
        case status
        case activeFlag = "active_flag"
        case lastUpdated = "last_updated"
        case lastUpdatedUserEntityId = "last_updated_user_entity_id"
        case sentDate = "sent_date"
        case serverTimestamp = "server_timestamp"
        case deviceKey = "device_key"
        case approvalStatus = "approval_status"
        case preferredDeliveryDate = "preferred_delivery_date"
        case deliveryNote = "delivery_note"
        case items
        case invoices
    }
    
    /// Decoded override to bind all currencies into an array
    /// - Parameter decoder: `Decoder ` object
    required public convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Order", in: managedObjectContext) else {
                
            fatalError("Failed to decode Order")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = container.intIfPresent(forKey: .id)
        self.supplierId = container.intIfPresent(forKey: .supplierId)
        self.purchaseOrderNumber = try container.decodeIfPresent(String.self, forKey: .purchaseOrderNumber)
        self.issueDate = try container.decodeIfPresent(Date.self, forKey: .issueDate)
        self.status = container.intIfPresent(forKey: .status)
        self.activeFlag = container.boolIfPresent(forKey: .activeFlag)
        self.lastUpdated = try container.decodeIfPresent(Date.self, forKey: .lastUpdated)
        self.lastUpdatedUserEntityId = container.intIfPresent(forKey: .lastUpdatedUserEntityId)
        self.sentDate = try container.decodeIfPresent(Date.self, forKey: .sentDate)
        self.serverTimestamp = container.intIfPresent(forKey: .serverTimestamp)
        self.deviceKey = try container.decodeIfPresent(String.self, forKey: .deviceKey)
        self.approvalStatus = container.intIfPresent(forKey: .approvalStatus)
        self.preferredDeliveryDate = try container.decodeIfPresent(Date.self, forKey: .preferredDeliveryDate)
        self.deliveryNote = try container.decodeIfPresent(String.self, forKey: .deliveryNote)
        self.items = container.decodeSetIfPresent(Item.self, forKey: .items)
        self.invoices = container.decodeSetIfPresent(Invoice.self, forKey: .invoices)

    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIntIfPresent(self.id, forKey: .id)
        try container.encodeIntIfPresent(self.supplierId, forKey: .supplierId)
        try container.encodeIfPresent(self.purchaseOrderNumber, forKey: .purchaseOrderNumber)
        try container.encodeIfPresent(self.issueDate, forKey: .issueDate)
        try container.encodeIntIfPresent(self.status, forKey: .status)
        try container.encodeBoolIfPresent(self.activeFlag, forKey: .activeFlag)
        try container.encodeIfPresent(self.lastUpdated, forKey: .lastUpdated)
        try container.encodeIntIfPresent(self.lastUpdatedUserEntityId, forKey: .lastUpdatedUserEntityId)
        try container.encodeIfPresent(self.sentDate, forKey: .sentDate)
        try container.encodeIntIfPresent(self.serverTimestamp, forKey: .serverTimestamp)
        try container.encodeIfPresent(self.deviceKey, forKey: .deviceKey)
        try container.encodeIntIfPresent(self.approvalStatus, forKey: .approvalStatus)
        try container.encodeIfPresent(self.preferredDeliveryDate, forKey: .preferredDeliveryDate)
        try container.encodeIfPresent(self.deliveryNote, forKey: .deliveryNote)
        
        try container.encodeSetIfPresent(Item.self, items: self.items, forKey: .items)
        try container.encodeSetIfPresent(Invoice.self, items: self.invoices, forKey: .items)
    }
}
