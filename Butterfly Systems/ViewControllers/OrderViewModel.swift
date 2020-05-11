//
//  OrderViewModel.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public typealias ViewModelCallback = (() -> Void)

protocol OrderViewModelProtocol {
    
    // MARK: - Data
    
    var error: HttpError? { get }
    
    var orders: [Order]? { get }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func loadOrders()
    
    func getOrders()
    
    func newOrder()
}

class OrderViewModel: OrderViewModelProtocol {
    
    private var orderClient: OrderClientProtocol?
    
    // MARK: - Data
    
    private(set) var error: HttpError?
    
    private(set) var orders: [Order]?
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Init
    
    convenience init() {
        
        self.init(client: OrderClient())
    }
    
    init(client _client: OrderClientProtocol?) {
        
        self.orderClient = _client
    }
    
    // MARK: - Functions
    
    /// Loads orders from the API
    func loadOrders() {
        
        self.orderClient?.getOrders { [weak self] response in
        
            let ordersDb = Order.fetchOrders()
            
            switch response {
            case .success(let orders):
                
                if Order.updateOrders(current: ordersDb, new: orders) {
                    
                    self?.getOrders()
                }
                else {
                    
                    self?.error = HttpError.coredata
                    
                    self?.onError?()
                    
                }
            case .failure(let error):
            
                self?.error = error
                
                self?.onError?()
            }
        }
    }
    
    /// Creates a new `Order ` object
    func newOrder() {
        
        if Order.create() != nil {
            
            self.getOrders()
        }
        else {
            
            self.error = HttpError.coredata
            
            self.onError?()
        }
        
    }
    
    /// Retrieves `Order` array from CoreData
    func getOrders() {
        
        self.orders = Order.fetchOrders()
        
        self.onUpdated?()
    }
    
}
