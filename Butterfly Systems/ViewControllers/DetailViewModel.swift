//
//  DetailViewModel.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol {
    
    // MARK: - Data
    
    var order: Order { get }
    
    var segment: DetailSegment { get set }
    
    var error: HttpError? { get }
    
    var items: [Any]? { get }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func getItems()
    
    func newItem(_ quantity: Int)
}

class DetailViewModel: DetailViewModelProtocol {
    
    // MARK: - Data
    
    var order: Order
    
    var segment: DetailSegment
    
    private(set) var error: HttpError?
    
    private(set) var items: [Any]?
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Init
    
    init(order _order: Order) {
        
        self.order = _order
        
        self.segment = .item
    }
    
    // MARK: - Functions
    
    func getItems() {
    
        if self.segment == .item {

            let items = self.order.items?.allObjects as? [Item]
            
            self.items = items?.sorted { $0.id?.intValue ?? 0 < $1.id?.intValue ?? 0 }
        }
        if self.segment == .invoice {

            let items = self.order.invoices?.allObjects as? [Invoice]
            
            self.items = items?.sorted { $0.id?.intValue ?? 0 < $1.id?.intValue ?? 0 }
        }
        
        self.onUpdated?()
    }
    
    func newItem(_ quantity: Int) {
        
        if Item.create(order: self.order, quantity: quantity) != nil {
            
            self.getItems()
        }
        else {
            
            self.error = HttpError.coredata
            
            self.onError?()
        }
        
    }
    
}
