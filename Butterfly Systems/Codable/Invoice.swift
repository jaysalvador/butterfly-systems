//
//  Invoice.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

public class Invoice: NSManagedObject, Codable {
    
    @NSManaged var id: NSNumber?
    @NSManaged var invoiceNumber: String?
    @NSManaged var receivedStatus: NSNumber?
    @NSManaged var created: Date?
    @NSManaged var lastUpdatedUserEntityId: NSNumber?
    @NSManaged var transientIdentifier: String?
    @NSManaged var receiptSentDate: Date?
    @NSManaged var activeFlag: NSNumber?
    @NSManaged var lastUpdated: Date?
    @NSManaged var receipts: NSSet?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case invoiceNumber = "invoice_number"
        case receivedStatus = "received_status"
        case created
        case lastUpdatedUserEntityId = "last_updated_user_entity_id"
        case transientIdentifier = "transient_identifier"
        case receiptSentDate = "receipt_sent_date"
        case activeFlag = "active_flag"
        case lastUpdated = "last_updated"
        case receipts
    }
    
    /// Decoded override to bind all currencies into an array
    /// - Parameter decoder: `Decoder ` object
    required public convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Invoice", in: managedObjectContext) else {
                
            fatalError("Failed to decode Invoice")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = container.intIfPresent(forKey: .id)
        self.invoiceNumber = try container.decodeIfPresent(String.self, forKey: .invoiceNumber)
        self.receivedStatus = container.intIfPresent(forKey: .receivedStatus)
        self.created = try container.decodeIfPresent(Date.self, forKey: .created)
        self.lastUpdatedUserEntityId = container.intIfPresent(forKey: .lastUpdatedUserEntityId)
        self.transientIdentifier = try container.decodeIfPresent(String.self, forKey: .transientIdentifier)
        self.receiptSentDate = try container.decodeIfPresent(Date.self, forKey: .receiptSentDate)
        self.activeFlag = container.boolIfPresent(forKey: .activeFlag)
        self.lastUpdated = try container.decodeIfPresent(Date.self, forKey: .lastUpdated)
        self.receipts = container.decodeSetIfPresent(Receipt.self, forKey: .receipts)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIntIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.invoiceNumber, forKey: .invoiceNumber)
        try container.encodeIntIfPresent(self.receivedStatus, forKey: .receivedStatus)
        try container.encodeIfPresent(self.created, forKey: .created)
        try container.encodeIntIfPresent(self.lastUpdatedUserEntityId, forKey: .lastUpdatedUserEntityId)
        try container.encodeIfPresent(self.transientIdentifier, forKey: .transientIdentifier)
        try container.encodeIfPresent(self.receiptSentDate, forKey: .receiptSentDate)
        try container.encodeBoolIfPresent(self.activeFlag, forKey: .activeFlag)
        try container.encodeIfPresent(self.lastUpdated, forKey: .lastUpdated)
        try container.encodeSetIfPresent(Receipt.self, items: self.receipts, forKey: .receipts)
    }
}
