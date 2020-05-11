//
//  OrderCell.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    
    func prepare(order: Order) -> UITableViewCell {
        
        self.orderLabel.text = "Order: \(order.id?.intValue ?? 0)"
        
        self.dateLabel.text = order.lastUpdated?.toString(using: .dateAndTime)
        
        self.itemsLabel.text = "Items: \(order.items?.count ?? 0)"
        
        return self
    }
}
