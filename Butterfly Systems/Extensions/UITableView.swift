//
//  UITableView.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: Convenience - Dequeueing
    
    /// Helper function to dequeue cells based on the UICollectionViewCell name as the reuse identifier
    /// - Parameter cell: custom `UICollectionViewCell` class
    /// - Parameter indexPath: `IndexPath` of the cell
    func dequeueReusable<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T? {
        
        let name = String(describing: cell)
        
        return self.dequeueReusableCell(withIdentifier: name, for: indexPath) as? T
    }
}
