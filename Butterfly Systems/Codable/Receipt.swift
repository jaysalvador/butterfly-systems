//
//  Receipt.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

public class Receipt: NSManagedObject, Codable {
    
    @NSManaged var id: NSNumber?
    @NSManaged var productItemId: NSNumber?
    @NSManaged var receivedQuantity: NSNumber?
    @NSManaged var created: Date?
    @NSManaged var lastUpdatedUserEntityId: NSNumber?
    @NSManaged var transientIdentifier: String?
    @NSManaged var sentDate: Date?
    @NSManaged var activeFlag: NSNumber?
    @NSManaged var lastUpdated: Date?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case productItemId = "product_item_id"
        case receivedQuantity = "received_quantity"
        case created
        case lastUpdatedUserEntityId = "last_updated_user_entity_id"
        case transientIdentifier = "transient_identifier"
        case sentDate = "sent_date"
        case activeFlag = "active_flag"
        case lastUpdated = "last_updated"
    }
    
    /// Decoded override to bind all currencies into an array
    /// - Parameter decoder: `Decoder ` object
    required public convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Package", in: managedObjectContext) else {
                
            fatalError("Failed to decode Package")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = container.intIfPresent(forKey: .id)
        self.productItemId = container.intIfPresent(forKey: .productItemId)
        self.receivedQuantity = container.intIfPresent(forKey: .receivedQuantity)
        self.created = try container.decodeIfPresent(Date.self, forKey: .created)
        self.lastUpdatedUserEntityId = container.intIfPresent(forKey: .lastUpdatedUserEntityId)
        self.transientIdentifier = try container.decodeIfPresent(String.self, forKey: .transientIdentifier)
        self.sentDate = try container.decodeIfPresent(Date.self, forKey: .sentDate)
        self.activeFlag = container.boolIfPresent(forKey: .activeFlag)
        self.lastUpdated = try container.decodeIfPresent(Date.self, forKey: .lastUpdated)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIntIfPresent(self.id, forKey: .id)
        try container.encodeIntIfPresent(self.productItemId, forKey: .productItemId)
        try container.encodeIntIfPresent(self.receivedQuantity, forKey: .receivedQuantity)
        try container.encodeIfPresent(self.created, forKey: .created)
        try container.encodeIntIfPresent(self.lastUpdatedUserEntityId, forKey: .lastUpdatedUserEntityId)
        try container.encodeIfPresent(self.transientIdentifier, forKey: .transientIdentifier)
        try container.encodeIfPresent(self.sentDate, forKey: .sentDate)
        try container.encodeBoolIfPresent(self.activeFlag, forKey: .activeFlag)
        try container.encodeIfPresent(self.lastUpdated, forKey: .lastUpdated)
    }
}
