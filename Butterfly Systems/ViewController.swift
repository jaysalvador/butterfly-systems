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
            
            switch response {
            case .success(let orders):
                
                print(orders.count)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }

}
