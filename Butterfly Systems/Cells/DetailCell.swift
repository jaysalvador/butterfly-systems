//
//  DetailCell.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    func prepare(item: Any) -> UITableViewCell {
        
        if let item = item as? Item {
            
            self.itemLabel.text = "Item: \(item.id?.intValue ?? 0)"
            
            self.quantityLabel.text = "Quantity: \(item.quantity?.intValue ?? 0)"
        }
        else if let item = item as? Invoice {
            
            self.itemLabel.text = "Invoice: \(item.id?.intValue ?? 0)"
            
            self.quantityLabel.text = "Status: \(item.receivedStatus?.intValue ?? 0)"
        }
        else {
            
            self.itemLabel.text = nil
            
            self.quantityLabel.text = nil
        }
        
        return self
    }
    
}
