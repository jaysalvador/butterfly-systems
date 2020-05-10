//
//  ViewController.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 9/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let client = OrderClient()
        
        client?.getOrders { response in
        
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
                }
                catch {
                    
                    print(error)
                }
            case .failure(let error):
                
                print(error)
            }
        }
    }

}
