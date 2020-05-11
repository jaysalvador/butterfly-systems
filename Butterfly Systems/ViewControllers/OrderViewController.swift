//
//  OrderViewController.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class OrderViewController: UITableViewController {
    
    private var viewModel: OrderViewModelProtocol? = OrderViewModel()
    
    // MARK: - Setup
    
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in
            
            self?.tableView.reloadData()
        }
        
        self.viewModel?.onError = {
            
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupViewModel()
        
        self.viewModel?.getOrders()
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.orders?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let order = viewModel?.orders?[indexPath.row],
            let cell = tableView.dequeueReusable(cell: OrderCell.self, for: indexPath) {
            
            return cell.prepare(order: order)
        }
        
        return OrderCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTouchUpInside(_ sender: Any) {
    
        self.viewModel?.newOrder()
    }
}
