//
//  Butterfly_SystemsTests.swift
//  Butterfly SystemsTests
//
//  Created by Jay Salvador on 9/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest
import CoreData
@testable import Butterfly_Systems

class Butterfly_SystemsTests: XCTestCase {

    func testData() {
        
        let orders = getOrders()
        
        XCTAssertEqual(orders.count, 1, "data must have one order")
        
        XCTAssertEqual(orders.first?.items?.count, 4, "Order must have 4 items")
        
        XCTAssertEqual(orders.first?.invoices?.count, 1, "Order must have 1 invoice")
        
        let newOrder = Order(context: CoreDataStack.persistentContainer.viewContext)
        
        newOrder.lastUpdated = Date()
        
        if let order = orders.first {

            XCTAssertEqual(newOrder.isLastest(order), true, "New order must be latest")
            
            let viewModel = DetailViewModel(order: order)
            
            viewModel.getItems()

            XCTAssertEqual(viewModel.items?.count, 4, "Order must have 4 items")
            
            viewModel.segment = .invoice
            
            viewModel.getItems()
            
            XCTAssertEqual(viewModel.items?.count, 1, "Order must have 1 invoice")
            
        }
    }

    func getOrders() -> [Order] {
        
        let expectation = self.expectation(description: "no data recieved")
        
        var orders = [Order]()
        
        DataHelper.getData { (response) in
            
            switch response {
                
            case .success(let _orders):
                
                orders = _orders
                
            case .failure:
                
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        return orders
    }
}
