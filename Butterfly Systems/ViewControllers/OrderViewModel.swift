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
    
    func getOrders() {
        
        self.orderClient?.getOrders { [weak self] response in
        
            let ordersDb = Order.fetchOrders()
            
            switch response {
            case .success(let orders):
                
                let managedObjectContext = CoreDataStack.persistentContainer.viewContext
                            
                for order in orders {
                    
                    if let orderDB = ordersDb?.first(where: { $0.id == order.id }) {
                        
                        if order.isLastest(orderDB) {

                            managedObjectContext.delete(orderDB)
                        }
                        else {

                            managedObjectContext.delete(order)
                        }
                    }
                }
                
                do {

                    try managedObjectContext.save()
                    
                    self?.orders = Order.fetchOrders()
                    
                    self?.onUpdated?()
                }
                catch {
                    
                    self?.error = HttpError.coredata
                    
                    self?.onError?()
                }
            case .failure(let error):
            
                self?.error = error
                
                self?.onError?()
            }
        }
    }
    
    func newOrder() {
        
        if Order.create() != nil {
            
            self.orders = Order.fetchOrders()
            
            self.onUpdated?()
        }
        else {
            
            self.error = HttpError.coredata
            
            self.onError?()
        }
        
    }
    
}
