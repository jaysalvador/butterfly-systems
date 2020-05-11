//
//  Item.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 10/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData

public class Item: NSManagedObject, Codable {

    @NSManaged var id: NSNumber?
    @NSManaged var productItemId: NSNumber?
    @NSManaged var quantity: NSNumber?
    @NSManaged var lastUpdatedUserEntityId: NSNumber?
    @NSManaged var transientIdentifier: String?
    @NSManaged var activeFlag: NSNumber?
    @NSManaged var lastUpdated: Date?
    @NSManaged var order: Order?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case productItemId = "product_item_id"
        case quantity
        case lastUpdatedUserEntityId = "last_updated_user_entity_id"
        case transientIdentifier = "transient_identifier"
        case activeFlag = "active_flag"
        case lastUpdated = "last_updated"
    }
    
    /// Decoded override to bind all currencies into an array
    /// - Parameter decoder: `Decoder ` object
    required public convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedObjectContext) else {
                
            fatalError("Failed to decode Item")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = container.intIfPresent(forKey: .id)
        self.productItemId = container.intIfPresent(forKey: .productItemId)
        self.quantity = container.intIfPresent(forKey: .quantity)
        self.lastUpdatedUserEntityId = container.intIfPresent(forKey: .lastUpdatedUserEntityId)
        self.transientIdentifier = try container.decodeIfPresent(String.self, forKey: .transientIdentifier)
        self.activeFlag = container.boolIfPresent(forKey: .activeFlag)
        self.lastUpdated = try container.decodeIfPresent(Date.self, forKey: .lastUpdated)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIntIfPresent(self.id, forKey: .id)
        try container.encodeIntIfPresent(self.productItemId, forKey: .productItemId)
        try container.encodeIntIfPresent(self.quantity, forKey: .quantity)
        try container.encodeIntIfPresent(self.lastUpdatedUserEntityId, forKey: .lastUpdatedUserEntityId)
        try container.encodeIfPresent(self.transientIdentifier, forKey: .transientIdentifier)
        try container.encodeBoolIfPresent(self.activeFlag, forKey: .activeFlag)
        try container.encodeIfPresent(self.lastUpdated, forKey: .lastUpdated)
    }
    
    public class func fetchRequest() -> NSFetchRequest<Item> {
        
        return NSFetchRequest<Item>(entityName: "Item")
    }
}
